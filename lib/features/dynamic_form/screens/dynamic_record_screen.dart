import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/models/dynamic_model.dart';
import '../../../core/providers/dynamic_models_provider.dart';
import '../../../core/providers/global_providers.dart';
import '../../../core/constants/app_constants.dart';
import '../../dashboard/widgets/connectivity_indicator.dart';
import '../../dashboard/widgets/online_operation_guard.dart';
import '../widgets/dynamic_form_builder.dart';

class DynamicRecordScreen extends ConsumerStatefulWidget {
  final String modelName;
  final String? recordId; // For editing existing records
  final Map<String, dynamic>? initialData; // For pre-populated forms

  const DynamicRecordScreen({
    super.key,
    required this.modelName,
    this.recordId,
    this.initialData,
  });

  @override
  ConsumerState<DynamicRecordScreen> createState() =>
      _DynamicRecordScreenState();
}

class _DynamicRecordScreenState extends ConsumerState<DynamicRecordScreen>
    with TickerProviderStateMixin {
  late AnimationController _slideController;
  late AnimationController _fadeController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  bool _isSaving = false;
  bool _hasUnsavedChanges = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _startAnimations();
  }

  void _setupAnimations() {
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOut,
    ));
  }

  void _startAnimations() {
    _fadeController.forward();
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) {
        _slideController.forward();
      }
    });
  }

  @override
  void dispose() {
    _slideController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentUserId = ref.watch(currentUserIdProvider);

    return PopScope(
      canPop: !_hasUnsavedChanges,
      onPopInvoked: (didPop) async {
        if (!didPop && _hasUnsavedChanges) {
          final shouldLeave = await _showUnsavedChangesDialog();
          if (shouldLeave && context.mounted) {
            context.pop();
          }
        }
      },
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: _buildBody(context, currentUserId),
        floatingActionButton: _buildFloatingActionButton(context),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    final isEditing = widget.recordId != null;

    return AppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _formatModelName(widget.modelName),
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            isEditing ? 'Edit Record' : 'New Record',
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
      backgroundColor: Theme.of(context).primaryColor,
      foregroundColor: Colors.white,
      elevation: 2,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => _handleBackPress(context),
        tooltip: 'Back',
      ),
      actions: [
        // Connectivity indicator
        const ConnectivityIndicator(showText: false),
        const SizedBox(width: 8),

        // Save button
        if (!_isSaving)
          OnlineOperationGuard(
            onTap: () => _handleQuickSave(),
            offlineMessage: 'Saving records requires internet connection',
            child: IconButton(
              icon: const Icon(Icons.save),
              onPressed: () => _handleQuickSave(),
              tooltip: 'Quick Save',
            ),
          ),

        // More options
        PopupMenuButton<String>(
          icon: const Icon(Icons.more_vert),
          onSelected: (value) => _handleMenuAction(context, value),
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'save_draft',
              child: ListTile(
                dense: true,
                leading: Icon(Icons.drafts, size: 20),
                title: Text('Save as Draft', style: TextStyle(fontSize: 14)),
                contentPadding: EdgeInsets.zero,
              ),
            ),
            const PopupMenuItem(
              value: 'clear_form',
              child: ListTile(
                dense: true,
                leading: Icon(Icons.clear_all, size: 20),
                title: Text('Clear Form', style: TextStyle(fontSize: 14)),
                contentPadding: EdgeInsets.zero,
              ),
            ),
            const PopupMenuDivider(),
            const PopupMenuItem(
              value: 'help',
              child: ListTile(
                dense: true,
                leading: Icon(Icons.help_outline, size: 20),
                title: Text('Help', style: TextStyle(fontSize: 14)),
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ],
        ),

        const SizedBox(width: 8),
      ],
    );
  }

  Widget _buildBody(BuildContext context, String? currentUserId) {
    if (currentUserId == null) {
      return _buildNotSignedInState();
    }

    final modelsAsync = ref.watch(dynamicModelsProvider);

    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: modelsAsync.when(
          data: (models) => _buildFormContent(context, models, currentUserId),
          loading: () => _buildLoadingState(),
          error: (error, stackTrace) => _buildErrorState(error),
        ),
      ),
    );
  }

  Widget _buildFormContent(
      BuildContext context, List<DynamicModel> models, String userId) {
    try {
      final DynamicModel model = models.firstWhere(
        (m) => m.modelName == widget.modelName,
        orElse: () => throw Exception('Model not found'),
      );

      // Check user permissions for this model
      final hasPermission = _checkModelPermissions(model, userId);
      if (!hasPermission) {
        return _buildNoPermissionState();
      }

      return SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Model info card
            _buildModelInfoCard(context, model),
            const SizedBox(height: 20),

            // Form content
            Form(
              key: _formKey,
              onChanged: () => setState(() => _hasUnsavedChanges = true),
              child: DynamicFormBuilder(
                model: model,
                initialData: widget.initialData,
                recordId: widget.recordId,
                onSubmit: (data) => _handleFormSubmit(context, model, data),
                onFieldChanged: (fieldName, value) =>
                    _handleFieldChanged(fieldName, value),
                onValidationChanged: (isValid) =>
                    _handleValidationChanged(isValid),
              ),
            ),

            // Bottom spacing for FAB
            const SizedBox(height: 80),
          ],
        ),
      );
    } catch (e) {
      return _buildModelNotFoundState();
    }
  }

  Widget _buildModelInfoCard(BuildContext context, DynamicModel model) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).primaryColor.withOpacity(0.05),
              Colors.white,
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    _getModelIcon(model.category ?? 'general'),
                    color: Theme.of(context).primaryColor,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _formatModelName(model.modelName),
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor,
                                ),
                      ),
                      if (model.description != null) ...[
                        const SizedBox(height: 2),
                        Text(
                          model.description!,
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Colors.grey[600],
                                  ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ],
                  ),
                ),

                // Field count indicator
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${model.fields.length} fields',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.blue[700],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            if (model.category != null || model.version != null) ...[
              const SizedBox(height: 12),
              Row(
                children: [
                  if (model.category != null) ...[
                    _buildInfoChip(
                      'Category',
                      model.category!,
                      Icons.category_outlined,
                      Colors.purple,
                    ),
                    const SizedBox(width: 8),
                  ],
                  if (model.version != null) ...[
                    _buildInfoChip(
                      'Version',
                      model.version!,
                      Icons.info_outline,
                      Colors.orange,
                    ),
                  ],
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildInfoChip(
      String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          Text(
            '$label: $value',
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingState() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: Theme.of(context).primaryColor,
          ),
          const SizedBox(height: 16),
          Text(
            'Loading ${_formatModelName(widget.modelName)}...',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.grey[600],
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Please wait while we prepare the form',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.grey[500],
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(Object error) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 64,
            color: Colors.red[300],
          ),
          const SizedBox(height: 16),
          Text(
            'Error Loading Form',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.red[700],
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Unable to load the form configuration',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.grey[600],
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            error.toString(),
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.grey[500],
                ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton.icon(
                onPressed: () => context.pop(),
                icon: const Icon(Icons.arrow_back),
                label: const Text('Go Back'),
              ),
              const SizedBox(width: 12),
              ElevatedButton.icon(
                onPressed: () => ref.refresh(dynamicModelsProvider),
                icon: const Icon(Icons.refresh),
                label: const Text('Retry'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildModelNotFoundState() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 64,
            color: Colors.orange[300],
          ),
          const SizedBox(height: 16),
          Text(
            'Model Not Found',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.orange[700],
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'The model "${_formatModelName(widget.modelName)}" could not be found',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.grey[600],
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.blue.shade200),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.info_outline,
                  color: Colors.blue.shade700,
                  size: 24,
                ),
                const SizedBox(height: 8),
                Text(
                  'This might be because:',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.blue.shade700,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  '• The model configuration is still being loaded\n'
                  '• You don\'t have permission to access this model\n'
                  '• The model name has changed or been removed',
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () => context.pop(),
            icon: const Icon(Icons.arrow_back),
            label: const Text('Go Back'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNoPermissionState() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.lock_outline,
            size: 64,
            color: Colors.red[300],
          ),
          const SizedBox(height: 16),
          Text(
            'Access Denied',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.red[700],
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'You don\'t have permission to access this form',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.grey[600],
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            'Contact your administrator to request access to "${_formatModelName(widget.modelName)}" records.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[500],
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          OutlinedButton.icon(
            onPressed: () => context.pop(),
            icon: const Icon(Icons.arrow_back),
            label: const Text('Go Back'),
          ),
        ],
      ),
    );
  }

  Widget _buildNotSignedInState() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.person_outline,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'Sign In Required',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.grey[600],
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Please sign in to access this form',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.grey[500],
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    if (_isSaving) {
      return FloatingActionButton(
        onPressed: null,
        backgroundColor: Colors.grey,
        child: const SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ),
      );
    }

    return OnlineFloatingActionButton(
      onPressed: () => _handleFormSubmit(context, null, {}),
      offlineMessage: 'Saving records requires internet connection',
      tooltip: widget.recordId != null ? 'Update Record' : 'Save Record',
      backgroundColor: Theme.of(context).colorScheme.secondary,
      child: Icon(
        widget.recordId != null ? Icons.update : Icons.save,
      ),
    );
  }

  // Helper methods
  String _formatModelName(String modelName) {
    return modelName
        .split('_')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(' ');
  }

  IconData _getModelIcon(String category) {
    switch (category.toLowerCase()) {
      case 'equipment':
        return Icons.electrical_services;
      case 'maintenance':
        return Icons.build;
      case 'inspection':
        return Icons.search;
      case 'report':
        return Icons.description;
      case 'user':
        return Icons.person;
      case 'organization':
        return Icons.business;
      default:
        return Icons.dynamic_form;
    }
  }

  bool _checkModelPermissions(DynamicModel model, String userId) {
    // Implement permission checking logic here
    // For now, return true - you can enhance this based on your permission system
    return true;
  }

  void _handleBackPress(BuildContext context) async {
    if (_hasUnsavedChanges) {
      final shouldLeave = await _showUnsavedChangesDialog();
      if (shouldLeave && context.mounted) {
        context.pop();
      }
    } else {
      context.pop();
    }
  }

  Future<bool> _showUnsavedChangesDialog() async {
    return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: const Row(
              children: [
                Icon(Icons.warning, color: Colors.orange),
                SizedBox(width: 12),
                Text('Unsaved Changes'),
              ],
            ),
            content: const Text(
              'You have unsaved changes. Are you sure you want to leave without saving?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Stay'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context, true),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Leave'),
              ),
            ],
          ),
        ) ??
        false;
  }

  void _handleQuickSave() {
    if (_formKey.currentState?.validate() ?? false) {
      // Implement quick save logic
      HapticFeedback.lightImpact();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Row(
            children: [
              Icon(Icons.save, color: Colors.white),
              SizedBox(width: 12),
              Text('Draft saved successfully'),
            ],
          ),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      );
    }
  }

  void _handleMenuAction(BuildContext context, String action) {
    switch (action) {
      case 'save_draft':
        _handleSaveDraft();
        break;
      case 'clear_form':
        _handleClearForm();
        break;
      case 'help':
        _showHelpDialog();
        break;
    }
  }

  void _handleSaveDraft() {
    // Implement draft saving logic
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Draft saved to local storage'),
        backgroundColor: Colors.blue,
      ),
    );
    setState(() => _hasUnsavedChanges = false);
  }

  void _handleClearForm() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear Form'),
        content: const Text('Are you sure you want to clear all form data?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Clear'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      _formKey.currentState?.reset();
      setState(() => _hasUnsavedChanges = false);
    }
  }

  void _showHelpDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Row(
          children: [
            Icon(Icons.help_outline, color: Colors.blue),
            SizedBox(width: 12),
            Text('Form Help'),
          ],
        ),
        content: const SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Form Navigation:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text('• Use Tab key to move between fields\n'
                  '• Required fields are marked with *\n'
                  '• Save drafts to continue later\n'
                  '• All changes are validated before saving'),
              SizedBox(height: 16),
              Text(
                'Need Help?',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text('Contact support@substationmanager.com for assistance'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Future<void> _handleFormSubmit(BuildContext context, DynamicModel? model,
      Map<String, dynamic> data) async {
    if (_isSaving) return;

    setState(() => _isSaving = true);

    try {
      // Add haptic feedback
      HapticFeedback.lightImpact();

      // Simulate save operation
      await Future.delayed(const Duration(seconds: 2));

      if (mounted) {
        setState(() {
          _isSaving = false;
          _hasUnsavedChanges = false;
        });

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.check_circle, color: Colors.white),
                const SizedBox(width: 12),
                Text(
                  widget.recordId != null
                      ? 'Record updated successfully!'
                      : 'Record saved successfully!',
                ),
              ],
            ),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            action: SnackBarAction(
              label: 'View',
              textColor: Colors.white,
              onPressed: () {
                // Navigate to record view
              },
            ),
          ),
        );

        // Navigate back after successful save
        Future.delayed(const Duration(seconds: 1), () {
          if (mounted) {
            context.pop();
          }
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isSaving = false);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Save failed: $e'),
            backgroundColor: Colors.red,
            action: SnackBarAction(
              label: 'Retry',
              textColor: Colors.white,
              onPressed: () => _handleFormSubmit(context, model, data),
            ),
          ),
        );
      }
    }
  }

  void _handleFieldChanged(String fieldName, dynamic value) {
    // Handle individual field changes
    setState(() => _hasUnsavedChanges = true);
  }

  void _handleValidationChanged(bool isValid) {
    // Handle validation state changes
    // You can update UI based on form validity
  }
}

// Extension for better router integration
extension DynamicRecordRouterExtension on BuildContext {
  void goToRecord(String modelName,
      {String? recordId, Map<String, dynamic>? initialData}) {
    // This would be used with your router configuration
    if (recordId != null) {
      go('/record/$modelName/$recordId');
    } else {
      go('/record/$modelName');
    }
  }
}
