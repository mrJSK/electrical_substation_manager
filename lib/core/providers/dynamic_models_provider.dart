import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/dynamic_model.dart';
import '../services/connectivity_service.dart';
import '../services/enhanced_isar_service.dart';
import '../constants/app_constants.dart';
import 'global_providers.dart';
import 'cached_providers.dart'; // Using your existing cached providers

// =============================================================================
// CORE DYNAMIC MODEL PROVIDERS
// =============================================================================

/// Provider for all active dynamic models with caching
final dynamicModelsProvider =
    FutureProvider.autoDispose<List<DynamicModel>>((ref) async {
  final cacheManager = ref.watch(cacheManagerProvider.notifier);
  final connectivity = ref.watch(connectivityServiceProvider);

  try {
    // Try to get from cache first using Enhanced Isar Service
    final cachedModels = await EnhancedIsarService.getCachedDynamicModels();
    if (cachedModels != null && cachedModels.isNotEmpty) {
      // Return cached data if offline or as immediate response
      if (connectivity.status != ConnectivityStatus.online) {
        return cachedModels;
      }

      // Return cached data immediately and refresh in background
      _refreshModelsInBackground(ref);
      return cachedModels;
    }

    // Fetch from Firestore
    final models = await _fetchModelsFromFirestore();

    // Cache the results using Enhanced Isar Service
    await EnhancedIsarService.cacheDynamicModels(
        models, const Duration(hours: 2));

    return models;
  } catch (e) {
    // Try to return cached data on error
    final cachedModels = await EnhancedIsarService.getCachedDynamicModels();
    if (cachedModels != null && cachedModels.isNotEmpty) {
      return cachedModels;
    }

    throw Exception('Failed to load dynamic models: $e');
  }
});

/// Provider for dynamic models by organization with enhanced caching
final dynamicModelsByOrgProvider =
    FutureProvider.family.autoDispose<List<DynamicModel>, String>(
  (ref, organizationId) async {
    final connectivity = ref.watch(connectivityServiceProvider);

    try {
      // Try to get from cache first using Enhanced Isar Service
      final cachedModels =
          await EnhancedIsarService.getCachedOrgModels(organizationId);

      if (cachedModels != null && cachedModels.isNotEmpty) {
        // Return cached data if offline or as immediate response
        if (connectivity.status != ConnectivityStatus.online) {
          return cachedModels;
        }

        // Return cached data immediately and refresh in background
        _refreshOrgModelsInBackground(ref, organizationId);
        return cachedModels;
      }

      // Fetch from Firestore
      final models = await _fetchModelsByOrganization(organizationId);

      // Cache the results using Enhanced Isar Service
      await EnhancedIsarService.cacheOrgModels(
          organizationId, models, const Duration(minutes: 30));

      return models;
    } catch (e) {
      // Try to return cached data on error
      final cachedModels =
          await EnhancedIsarService.getCachedOrgModels(organizationId);
      if (cachedModels != null) {
        return cachedModels;
      }

      throw Exception(
          'Failed to load models for organization $organizationId: $e');
    }
  },
);

/// Provider for getting a specific model by name with organization context
final dynamicModelByNameProvider = FutureProvider.family
    .autoDispose<DynamicModel?, ({String modelName, String? organizationId})>(
  (ref, params) async {
    try {
      final organizationId = params.organizationId ??
          ref.watch(currentUserProvider).when(
                data: (user) => user?.uid, // Fallback to user ID as org ID
                loading: () => null,
                error: (_, __) => null,
              );

      if (organizationId != null) {
        final models =
            await ref.watch(dynamicModelsByOrgProvider(organizationId).future);
        return models.firstWhere(
          (model) => model.modelName == params.modelName,
          orElse: () => throw StateError('Model not found'),
        );
      } else {
        final models = await ref.watch(dynamicModelsProvider.future);
        return models.firstWhere(
          (model) => model.modelName == params.modelName,
          orElse: () => throw StateError('Model not found'),
        );
      }
    } catch (e) {
      return null; // Model not found
    }
  },
);

/// Provider for model by ID with caching
final dynamicModelByIdProvider =
    FutureProvider.family.autoDispose<DynamicModel?, String>(
  (ref, modelId) async {
    try {
      // Try to get from cache first using Enhanced Isar Service
      final cachedModel = await EnhancedIsarService.getCachedModelById(modelId);
      if (cachedModel != null) {
        return cachedModel;
      }

      // Fetch from Firestore
      final doc = await FirebaseFirestore.instance
          .collection(AppConstants.dynamicModelsCollection)
          .doc(modelId)
          .get();

      if (!doc.exists) return null;

      final model = DynamicModel.fromFirestore(doc);

      // Cache the result using Enhanced Isar Service
      await EnhancedIsarService.cacheModelById(
          modelId, model, const Duration(hours: 1));

      return model;
    } catch (e) {
      return null;
    }
  },
);

// =============================================================================
// SPECIALIZED PROVIDERS FOR ELECTRICAL INDUSTRY
// =============================================================================

/// Provider for equipment-related models
final equipmentModelsProvider =
    FutureProvider.autoDispose<List<DynamicModel>>((ref) async {
  final allModels = await ref.watch(dynamicModelsProvider.future);
  return allModels
      .where((model) =>
          model.category?.toLowerCase() == 'equipment' ||
          model.modelName.contains('equipment'))
      .toList();
});

/// Provider for maintenance-related models
final maintenanceModelsProvider =
    FutureProvider.autoDispose<List<DynamicModel>>((ref) async {
  final allModels = await ref.watch(dynamicModelsProvider.future);
  return allModels
      .where((model) =>
          model.category?.toLowerCase() == 'maintenance' ||
          model.modelName.contains('maintenance'))
      .toList();
});

/// Provider for inspection-related models
final inspectionModelsProvider =
    FutureProvider.autoDispose<List<DynamicModel>>((ref) async {
  final allModels = await ref.watch(dynamicModelsProvider.future);
  return allModels
      .where((model) =>
          model.category?.toLowerCase() == 'inspection' ||
          model.modelName.contains('inspection'))
      .toList();
});

/// Provider for report-related models
final reportModelsProvider =
    FutureProvider.autoDispose<List<DynamicModel>>((ref) async {
  final allModels = await ref.watch(dynamicModelsProvider.future);
  return allModels
      .where((model) =>
          model.category?.toLowerCase() == 'report' ||
          model.modelName.contains('report'))
      .toList();
});

// =============================================================================
// MODEL STATISTICS AND ANALYTICS PROVIDERS
// =============================================================================

/// Provider for model statistics
final modelStatisticsProvider =
    FutureProvider.autoDispose<Map<String, dynamic>>((ref) async {
  final allModels = await ref.watch(dynamicModelsProvider.future);

  final stats = <String, dynamic>{
    'totalModels': allModels.length,
    'activeModels': allModels.where((m) => m.isActive).length,
    'systemModels': allModels.where((m) => m.isSystemModel).length,
    'customModels': allModels.where((m) => !m.isSystemModel).length,
    'categories': <String, int>{},
    'totalFields': 0,
    'averageFieldsPerModel': 0.0,
    'modelsWithValidation': 0,
    'modelsWithPermissions': 0,
  };

  // Category breakdown
  final categories = <String, int>{};
  int totalFields = 0;
  int modelsWithValidation = 0;
  int modelsWithPermissions = 0;

  for (final model in allModels) {
    final category = model.category?.toLowerCase() ?? 'other';
    categories[category] = (categories[category] ?? 0) + 1;

    totalFields += model.fields.length;

    if (model.validationRules.isNotEmpty || model.requiredFields.isNotEmpty) {
      modelsWithValidation++;
    }

    if (model.permissions.isNotEmpty) {
      modelsWithPermissions++;
    }
  }

  stats['categories'] = categories;
  stats['totalFields'] = totalFields;
  stats['averageFieldsPerModel'] =
      allModels.isNotEmpty ? totalFields / allModels.length : 0.0;
  stats['modelsWithValidation'] = modelsWithValidation;
  stats['modelsWithPermissions'] = modelsWithPermissions;

  return stats;
});

/// Provider for model usage analytics
final modelUsageAnalyticsProvider =
    FutureProvider.family.autoDispose<Map<String, dynamic>, String>(
  (ref, organizationId) async {
    try {
      // This would typically come from your analytics service
      final models =
          await ref.watch(dynamicModelsByOrgProvider(organizationId).future);

      final analytics = <String, dynamic>{
        'totalModels': models.length,
        'mostUsedModels': <String>[],
        'recentlyCreated': <String>[],
        'fieldTypeDistribution': <String, int>{},
        'validationComplexity': <String, int>{},
      };

      // Calculate field type distribution
      final fieldTypes = <String, int>{};
      final validationComplexity = <String, int>{
        'simple': 0,
        'moderate': 0,
        'complex': 0
      };

      for (final model in models) {
        // Count field types
        for (final field in model.fields.values) {
          fieldTypes[field.fieldType] = (fieldTypes[field.fieldType] ?? 0) + 1;
        }

        // Assess validation complexity
        final validationScore = _calculateValidationComplexity(model);
        if (validationScore < 3) {
          validationComplexity['simple'] = validationComplexity['simple']! + 1;
        } else if (validationScore < 7) {
          validationComplexity['moderate'] =
              validationComplexity['moderate']! + 1;
        } else {
          validationComplexity['complex'] =
              validationComplexity['complex']! + 1;
        }
      }

      analytics['fieldTypeDistribution'] = fieldTypes;
      analytics['validationComplexity'] = validationComplexity;

      return analytics;
    } catch (e) {
      return <String, dynamic>{
        'error': true,
        'message': e.toString(),
      };
    }
  },
);

// =============================================================================
// REAL-TIME PROVIDERS WITH FIRESTORE STREAMS
// =============================================================================

/// Stream provider for real-time model updates
final dynamicModelsStreamProvider =
    StreamProvider.autoDispose<List<DynamicModel>>((ref) {
  return FirebaseFirestore.instance
      .collection(AppConstants.dynamicModelsCollection)
      .where('isActive', isEqualTo: true)
      .orderBy('updatedAt', descending: true)
      .snapshots()
      .map((snapshot) {
    final models =
        snapshot.docs.map((doc) => DynamicModel.fromFirestore(doc)).toList();

    // Update cache when we get new stream data
    EnhancedIsarService.cacheDynamicModels(models, const Duration(hours: 2));

    return models;
  }).handleError((error) {
    throw Exception('Failed to stream dynamic models: $error');
  });
});

/// Stream provider for organization-specific models
final orgModelsStreamProvider =
    StreamProvider.family.autoDispose<List<DynamicModel>, String>(
  (ref, organizationId) {
    return FirebaseFirestore.instance
        .collection(AppConstants.dynamicModelsCollection)
        .where('organizationId', isEqualTo: organizationId)
        .where('isActive', isEqualTo: true)
        .orderBy('updatedAt', descending: true)
        .snapshots()
        .map((snapshot) {
      final models =
          snapshot.docs.map((doc) => DynamicModel.fromFirestore(doc)).toList();

      // Update cache when we get new stream data
      EnhancedIsarService.cacheOrgModels(
          organizationId, models, const Duration(minutes: 30));

      return models;
    }).handleError((error) {
      throw Exception('Failed to stream org models: $error');
    });
  },
);

// =============================================================================
// MODEL SEARCH AND FILTERING PROVIDERS
// =============================================================================

/// Provider for searching models
final modelSearchProvider = FutureProvider.family
    .autoDispose<List<DynamicModel>, ({String query, String? organizationId})>(
  (ref, params) async {
    final models = params.organizationId != null
        ? await ref
            .watch(dynamicModelsByOrgProvider(params.organizationId!).future)
        : await ref.watch(dynamicModelsProvider.future);

    if (params.query.isEmpty) return models;

    final query = params.query.toLowerCase();
    return models.where((model) {
      return model.modelName.toLowerCase().contains(query) ||
          model.displayName.toLowerCase().contains(query) ||
          (model.description?.toLowerCase().contains(query) ?? false) ||
          (model.category?.toLowerCase().contains(query) ?? false);
    }).toList();
  },
);

/// Provider for filtering models by category
final modelsByCategoryProvider = FutureProvider.family.autoDispose<
    List<DynamicModel>, ({String category, String? organizationId})>(
  (ref, params) async {
    final models = params.organizationId != null
        ? await ref
            .watch(dynamicModelsByOrgProvider(params.organizationId!).future)
        : await ref.watch(dynamicModelsProvider.future);

    return models
        .where((model) =>
            model.category?.toLowerCase() == params.category.toLowerCase())
        .toList();
  },
);

// =============================================================================
// MODEL VALIDATION AND HEALTH CHECK PROVIDERS
// =============================================================================

/// Provider for model validation health check
final modelHealthCheckProvider =
    FutureProvider.autoDispose<Map<String, dynamic>>((ref) async {
  final models = await ref.watch(dynamicModelsProvider.future);

  final healthCheck = <String, dynamic>{
    'totalModels': models.length,
    'healthyModels': 0,
    'modelsWithIssues': 0,
    'issues': <Map<String, dynamic>>[],
  };

  int healthyModels = 0;
  final issues = <Map<String, dynamic>>[];

  for (final model in models) {
    final modelIssues = _validateModelHealth(model);
    if (modelIssues.isEmpty) {
      healthyModels++;
    } else {
      issues.addAll(modelIssues.map((issue) => {
            'modelId': model.id,
            'modelName': model.modelName,
            'issue': issue,
            'severity': _getIssueSeverity(issue),
          }));
    }
  }

  healthCheck['healthyModels'] = healthyModels;
  healthCheck['modelsWithIssues'] = models.length - healthyModels;
  healthCheck['issues'] = issues;

  return healthCheck;
});

// =============================================================================
// HELPER FUNCTIONS
// =============================================================================

/// Fetch models from Firestore with error handling
Future<List<DynamicModel>> _fetchModelsFromFirestore() async {
  final snapshot = await FirebaseFirestore.instance
      .collection(AppConstants.dynamicModelsCollection)
      .where('isActive', isEqualTo: true)
      .orderBy('updatedAt', descending: true)
      .get();

  return snapshot.docs.map((doc) => DynamicModel.fromFirestore(doc)).toList();
}

/// Fetch models by organization from Firestore
Future<List<DynamicModel>> _fetchModelsByOrganization(
    String organizationId) async {
  final snapshot = await FirebaseFirestore.instance
      .collection(AppConstants.dynamicModelsCollection)
      .where('organizationId', isEqualTo: organizationId)
      .where('isActive', isEqualTo: true)
      .orderBy('updatedAt', descending: true)
      .get();

  return snapshot.docs.map((doc) => DynamicModel.fromFirestore(doc)).toList();
}

/// Refresh models in background for better UX
void _refreshModelsInBackground(AutoDisposeRef ref) {
  Future.microtask(() async {
    try {
      final freshModels = await _fetchModelsFromFirestore();
      await EnhancedIsarService.cacheDynamicModels(
          freshModels, const Duration(hours: 2));
    } catch (e) {
      // Silent fail - user already has cached data
    }
  });
}

/// Refresh organization models in background
void _refreshOrgModelsInBackground(AutoDisposeRef ref, String organizationId) {
  Future.microtask(() async {
    try {
      final freshModels = await _fetchModelsByOrganization(organizationId);
      await EnhancedIsarService.cacheOrgModels(
          organizationId, freshModels, const Duration(minutes: 30));
    } catch (e) {
      // Silent fail - user already has cached data
    }
  });
}

/// Calculate validation complexity score for a model
int _calculateValidationComplexity(DynamicModel model) {
  int score = 0;

  // Count required fields
  score += model.requiredFields.length;

  // Count fields with validation rules
  score +=
      model.fields.values.where((f) => f.validationRules.isNotEmpty).length;

  // Count relationships
  score += model.relationships.length;

  // Count global validation rules
  score += model.validationRules.length;

  return score;
}

/// Validate model health and return issues
List<String> _validateModelHealth(DynamicModel model) {
  final issues = <String>[];

  // Check for empty fields
  if (model.fields.isEmpty) {
    issues.add('Model has no fields defined');
  }

  // Check for missing display names
  for (final field in model.fields.values) {
    if (field.displayName.trim().isEmpty) {
      issues.add('Field ${field.fieldName} has no display name');
    }
  }

  // Check for unreferenced required fields
  for (final requiredField in model.requiredFields) {
    if (!model.fields.containsKey(requiredField)) {
      issues
          .add('Required field $requiredField not found in field definitions');
    }
  }

  // Check for selection fields without options
  for (final field in model.fields.values) {
    if (field.isSelectionField && !field.hasOptions) {
      issues.add('Selection field ${field.fieldName} has no options defined');
    }
  }

  // Check for reference fields without reference model
  for (final field in model.fields.values) {
    if (field.isReferenceField && (field.referenceModel?.isEmpty ?? true)) {
      issues.add(
          'Reference field ${field.fieldName} has no reference model defined');
    }
  }

  return issues;
}

/// Get issue severity level
String _getIssueSeverity(String issue) {
  if (issue.contains('no fields defined') || issue.contains('not found')) {
    return 'high';
  } else if (issue.contains('no options') ||
      issue.contains('no reference model')) {
    return 'medium';
  } else {
    return 'low';
  }
}

// =============================================================================
// PROVIDER EXTENSIONS FOR EASIER USAGE
// =============================================================================

extension DynamicModelProviderExtensions on WidgetRef {
  /// Refresh dynamic models
  void refreshDynamicModels() {
    refresh(dynamicModelsProvider);
  }

  /// Refresh models for specific organization
  void refreshOrgModels(String organizationId) {
    refresh(dynamicModelsByOrgProvider(organizationId));
  }

  /// Get model by name with current user's organization
  Future<DynamicModel?> getModelByName(String modelName) async {
    final currentUser = watch(currentUserProvider).value;
    final organizationId = currentUser?.uid; // Adjust based on your user model

    return await read(dynamicModelByNameProvider((
      modelName: modelName,
      organizationId: organizationId,
    )).future);
  }

  /// Check if model exists
  Future<bool> modelExists(String modelName, [String? organizationId]) async {
    final model = await read(dynamicModelByNameProvider((
      modelName: modelName,
      organizationId: organizationId,
    )).future);
    return model != null;
  }

  /// Clear all dynamic model cache
  Future<void> clearDynamicModelCache() async {
    final cacheManager = read(cacheManagerProvider.notifier);
    await cacheManager.invalidateAllCache();
    refresh(dynamicModelsProvider);
  }

  /// Clear cache for specific organization
  Future<void> clearOrgModelCache(String organizationId) async {
    await EnhancedIsarService.clearOrgModels(organizationId);
    refresh(dynamicModelsByOrgProvider(organizationId));
  }
}
