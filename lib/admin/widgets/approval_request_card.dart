// lib/features/admin/presentation/widgets/approval_request_card.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../auth/multi_tenant_auth.dart';
import 'role_selection_dialog.dart';

class ApprovalRequestCard extends ConsumerStatefulWidget {
  final Map<String, dynamic> request;

  const ApprovalRequestCard({super.key, required this.request});

  @override
  ConsumerState<ApprovalRequestCard> createState() =>
      _ApprovalRequestCardState();
}

class _ApprovalRequestCardState extends ConsumerState<ApprovalRequestCard> {
  bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    final userDetails = widget.request['userDetails'] as Map<String, dynamic>;
    final orgDetails =
        widget.request['organizationDetails'] as Map<String, dynamic>?;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Row(
              children: [
                _buildUserAvatar(userDetails),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildUserInfo(userDetails, orgDetails),
                ),
                _buildStatusBadge(),
              ],
            ),

            const SizedBox(height: 16),

            // Request Details Section
            _buildRequestDetails(),

            const SizedBox(height: 16),

            // Action Buttons Section
            if (!_isProcessing) _buildActionButtons(),
            if (_isProcessing) _buildProcessingIndicator(),
          ],
        ),
      ),
    );
  }

  Widget _buildUserAvatar(Map<String, dynamic> userDetails) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey.shade300, width: 2),
      ),
      child: CircleAvatar(
        radius: 28,
        backgroundImage: userDetails['photoUrl'] != null
            ? NetworkImage(userDetails['photoUrl'])
            : null,
        backgroundColor: Colors.blue.shade100,
        child: userDetails['photoUrl'] == null
            ? Text(
                _getInitials(userDetails['name'] ?? 'U'),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade700,
                ),
              )
            : null,
      ),
    );
  }

  Widget _buildUserInfo(
      Map<String, dynamic> userDetails, Map<String, dynamic>? orgDetails) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          userDetails['name'] ?? 'Unknown User',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 4),
        Text(
          userDetails['email'] ?? '',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey.shade600,
              ),
        ),
        if (orgDetails != null) ...[
          const SizedBox(height: 4),
          Text(
            'Organization: ${orgDetails['name'] ?? 'Unknown'}',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.grey.shade500,
                  fontStyle: FontStyle.italic,
                ),
          ),
        ],
      ],
    );
  }

  Widget _buildStatusBadge() {
    final status = widget.request['status'] as String? ?? 'pending';
    Color badgeColor;
    IconData badgeIcon;

    switch (status.toLowerCase()) {
      case 'pending':
        badgeColor = Colors.orange;
        badgeIcon = Icons.schedule;
        break;
      case 'approved':
        badgeColor = Colors.green;
        badgeIcon = Icons.check_circle;
        break;
      case 'rejected':
        badgeColor = Colors.red;
        badgeIcon = Icons.cancel;
        break;
      default:
        badgeColor = Colors.grey;
        badgeIcon = Icons.help;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: badgeColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: badgeColor.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(badgeIcon, size: 16, color: badgeColor),
          const SizedBox(width: 4),
          Text(
            status.toUpperCase(),
            style: TextStyle(
              color: badgeColor,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRequestDetails() {
    final requestedAt = widget.request['requestedAt'] as String?;
    final requestedRole = widget.request['userDetails']?['requestedRole']
        as Map<String, dynamic>?;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.access_time, size: 16, color: Colors.grey.shade600),
              const SizedBox(width: 8),
              Text(
                'Requested: ${_formatDate(requestedAt)}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
          if (requestedRole != null) ...[
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.person_outline,
                    size: 16, color: Colors.grey.shade600),
                const SizedBox(width: 8),
                Text(
                  'Requested Role: ${requestedRole['displayName'] ?? 'Unknown'}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () => _handleApproval(true),
            icon: const Icon(Icons.check, size: 20),
            label: const Text('Approve'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: OutlinedButton.icon(
            onPressed: _showRoleSelectionDialog,
            icon: const Icon(Icons.person_add, size: 20),
            label: const Text('Assign Role'),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () => _handleApproval(false),
            icon: const Icon(Icons.close, size: 20),
            label: const Text('Reject'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProcessingIndicator() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
          const SizedBox(width: 12),
          Text(
            'Processing request...',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey.shade600,
                ),
          ),
        ],
      ),
    );
  }

  void _handleApproval(bool approved) async {
    if (_isProcessing) return;

    setState(() {
      _isProcessing = true;
    });

    try {
      final approvalService = ref.read(userApprovalServiceProvider);

      if (approved) {
        await approvalService.approveUser(
          widget.request['userId'] as String,
          widget.request['id'] as String,
        );

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Row(
                children: [
                  Icon(Icons.check_circle, color: Colors.white),
                  SizedBox(width: 8),
                  Text('User approved successfully!'),
                ],
              ),
              backgroundColor: Colors.green,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      } else {
        _showRejectionDialog();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.error, color: Colors.white),
                const SizedBox(width: 8),
                Expanded(child: Text('Error: $e')),
              ],
            ),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isProcessing = false;
        });
      }
    }
  }

  void _showRoleSelectionDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => RoleSelectionDialog(
        request: widget.request,
        onRoleSelected: (selectedRole) async {
          setState(() {
            _isProcessing = true;
          });

          try {
            final approvalService = ref.read(userApprovalServiceProvider);
            await approvalService.approveUserWithRole(
              widget.request['userId'] as String,
              widget.request['id'] as String,
              selectedRole,
            );

            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Row(
                    children: [
                      const Icon(Icons.check_circle, color: Colors.white),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'User approved with role: ${selectedRole['displayName']}',
                        ),
                      ),
                    ],
                  ),
                  backgroundColor: Colors.green,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            }
          } catch (e) {
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Row(
                    children: [
                      const Icon(Icons.error, color: Colors.white),
                      const SizedBox(width: 8),
                      Expanded(child: Text('Error: $e')),
                    ],
                  ),
                  backgroundColor: Colors.red,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            }
          } finally {
            if (mounted) {
              setState(() {
                _isProcessing = false;
              });
            }
          }
        },
      ),
    );
  }

  void _showRejectionDialog() async {
    final reason = await showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (context) => _RejectionReasonDialog(),
    );

    if (reason != null) {
      try {
        final approvalService = ref.read(userApprovalServiceProvider);
        await approvalService.rejectUser(
          widget.request['userId'] as String,
          widget.request['id'] as String,
          reason: reason.isEmpty ? null : reason,
        );

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Row(
                children: [
                  Icon(Icons.info, color: Colors.white),
                  SizedBox(width: 8),
                  Text('User request rejected'),
                ],
              ),
              backgroundColor: Colors.orange,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  const Icon(Icons.error, color: Colors.white),
                  const SizedBox(width: 8),
                  Expanded(child: Text('Error: $e')),
                ],
              ),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      }
    }
  }

  String _getInitials(String name) {
    if (name.isEmpty) return 'U';
    final parts = name.trim().split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return name[0].toUpperCase();
  }

  String _formatDate(String? dateStr) {
    if (dateStr == null) return 'Unknown';
    try {
      final date = DateTime.parse(dateStr);
      return DateFormat('MMM dd, yyyy • hh:mm a').format(date);
    } catch (e) {
      return 'Invalid date';
    }
  }
}

// Rejection Reason Dialog
class _RejectionReasonDialog extends StatefulWidget {
  @override
  State<_RejectionReasonDialog> createState() => _RejectionReasonDialogState();
}

class _RejectionReasonDialogState extends State<_RejectionReasonDialog> {
  final _reasonController = TextEditingController();
  String? _selectedReason;

  final List<String> _predefinedReasons = [
    'Incomplete information provided',
    'Invalid credentials or documentation',
    'Not authorized for this organization',
    'Duplicate registration request',
    'Security policy violation',
    'Other (specify below)',
  ];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Rejection Reason'),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Please select or provide a reason for rejection:'),
            const SizedBox(height: 16),

            // Predefined reasons
            ..._predefinedReasons.map((reason) => RadioListTile<String>(
                  title: Text(reason, style: const TextStyle(fontSize: 14)),
                  value: reason,
                  groupValue: _selectedReason,
                  onChanged: (value) {
                    setState(() {
                      _selectedReason = value;
                    });
                  },
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                )),

            // Custom reason text field
            if (_selectedReason == 'Other (specify below)') ...[
              const SizedBox(height: 16),
              TextField(
                controller: _reasonController,
                decoration: const InputDecoration(
                  labelText: 'Custom reason',
                  hintText: 'Enter specific reason for rejection',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                textCapitalization: TextCapitalization.sentences,
              ),
            ],
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _selectedReason != null
              ? () {
                  String finalReason = _selectedReason!;
                  if (_selectedReason == 'Other (specify below)') {
                    finalReason = _reasonController.text.trim();
                    if (finalReason.isEmpty) return;
                  }
                  Navigator.of(context).pop(finalReason);
                }
              : null,
          child: const Text('Reject'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }
}
