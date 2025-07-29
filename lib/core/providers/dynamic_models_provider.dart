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
      'dynamic_models', // cache key
      models,
      const Duration(hours: 2),
    );

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
        organizationId,
        models,
        const Duration(minutes: 30),
      );

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
                data: (user) => user?.uid,
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
    } catch (_) {
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
        modelId,
        model,
        const Duration(hours: 1),
      );

      return model;
    } catch (e) {
      return null;
    }
  },
);

// =============================================================================
// BACKGROUND REFRESH HELPERS
// =============================================================================

void _refreshModelsInBackground(AutoDisposeRef ref) {
  Future.microtask(() async {
    try {
      final freshModels = await _fetchModelsFromFirestore();
      await EnhancedIsarService.cacheDynamicModels(
        'dynamic_models',
        freshModels,
        const Duration(hours: 2),
      );
    } catch (_) {
      // Silent fail
    }
  });
}

void _refreshOrgModelsInBackground(AutoDisposeRef ref, String organizationId) {
  Future.microtask(() async {
    try {
      final freshModels = await _fetchModelsByOrganization(organizationId);
      await EnhancedIsarService.cacheOrgModels(
        organizationId,
        freshModels,
        const Duration(minutes: 30),
      );
    } catch (_) {
      // Silent fail
    }
  });
}

// =============================================================================
// HELPER FUNCTIONS TO FETCH MODELS FROM FIRESTORE
// =============================================================================

Future<List<DynamicModel>> _fetchModelsFromFirestore() async {
  final snapshot = await FirebaseFirestore.instance
      .collection(AppConstants.dynamicModelsCollection)
      .where('isActive', isEqualTo: true)
      .orderBy('updatedAt', descending: true)
      .get();

  return snapshot.docs.map((doc) => DynamicModel.fromFirestore(doc)).toList();
}

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

// =============================================================================
// MODEL SPECIALIZATION PROVIDERS
// =============================================================================

final equipmentModelsProvider =
    FutureProvider.autoDispose<List<DynamicModel>>((ref) async {
  final allModels = await ref.watch(dynamicModelsProvider.future);
  return allModels
      .where((model) =>
          model.category?.toLowerCase() == 'equipment' ||
          model.modelName.toLowerCase().contains('equipment'))
      .toList();
});

final maintenanceModelsProvider =
    FutureProvider.autoDispose<List<DynamicModel>>((ref) async {
  final allModels = await ref.watch(dynamicModelsProvider.future);
  return allModels
      .where((model) =>
          model.category?.toLowerCase() == 'maintenance' ||
          model.modelName.toLowerCase().contains('maintenance'))
      .toList();
});

final inspectionModelsProvider =
    FutureProvider.autoDispose<List<DynamicModel>>((ref) async {
  final allModels = await ref.watch(dynamicModelsProvider.future);
  return allModels
      .where((model) =>
          model.category?.toLowerCase() == 'inspection' ||
          model.modelName.toLowerCase().contains('inspection'))
      .toList();
});

final reportModelsProvider =
    FutureProvider.autoDispose<List<DynamicModel>>((ref) async {
  final allModels = await ref.watch(dynamicModelsProvider.future);
  return allModels
      .where((model) =>
          model.category?.toLowerCase() == 'report' ||
          model.modelName.toLowerCase().contains('report'))
      .toList();
});

// =============================================================================
// MODEL STATISTICS AND ANALYTICS PROVIDERS
// =============================================================================

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

final modelUsageAnalyticsProvider =
    FutureProvider.family.autoDispose<Map<String, dynamic>, String>(
  (ref, organizationId) async {
    try {
      final models =
          await ref.watch(dynamicModelsByOrgProvider(organizationId).future);

      final analytics = <String, dynamic>{
        'totalModels': models.length,
        'mostUsedModels': <String>[],
        'recentlyCreated': <String>[],
        'fieldTypeDistribution': <String, int>{},
        'validationComplexity': <String, int>{
          'simple': 0,
          'moderate': 0,
          'complex': 0,
        },
      };

      final fieldTypes = <String, int>{};
      final validationComplexity = analytics['validationComplexity']!;

      for (final model in models) {
        for (final field in model.fields.values) {
          fieldTypes[field.fieldType] = (fieldTypes[field.fieldType] ?? 0) + 1;
        }

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

final dynamicModelsStreamProvider =
    StreamProvider.autoDispose<List<DynamicModel>>((ref) {
  return FirebaseFirestore.instance
      .collection(AppConstants.dynamicModelsCollection)
      .where('isActive', isEqualTo: true)
      .orderBy('updatedAt', descending: true)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => DynamicModel.fromFirestore(doc)).toList())
      .handleError((error) {
    throw Exception('Failed to stream dynamic models: $error');
  });
});

final orgModelsStreamProvider = StreamProvider.family
    .autoDispose<List<DynamicModel>, String>((ref, organizationId) {
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
      organizationId,
      models,
      const Duration(minutes: 30),
    );

    return models;
  }).handleError((error) {
    throw Exception('Failed to stream org models: $error');
  });
});

// =============================================================================
// HELPER FUNCTIONS
// =============================================================================

int _calculateValidationComplexity(DynamicModel model) {
  int score = model.requiredFields.length +
      model.fields.values.where((f) => f.validationRules.isNotEmpty).length +
      model.relationships.length +
      model.validationRules.length;
  return score;
}

List<String> _validateModelHealth(DynamicModel model) {
  final issues = <String>[];

  if (model.fields.isEmpty) {
    issues.add('Model has no fields defined');
  }

  for (final field in model.fields.values) {
    if (field.displayName.trim().isEmpty) {
      issues.add('Field ${field.fieldName} has no display name');
    }
  }

  for (final requiredField in model.requiredFields) {
    if (!model.fields.containsKey(requiredField)) {
      issues
          .add('Required field $requiredField not found in field definitions');
    }
  }

  for (final field in model.fields.values) {
    if (field.isSelectionField && !field.hasOptions) {
      issues.add('Selection field ${field.fieldName} has no options defined');
    }
  }

  for (final field in model.fields.values) {
    if (field.isReferenceField && (field.referenceModel?.isEmpty ?? true)) {
      issues.add(
          'Reference field ${field.fieldName} has no reference model defined');
    }
  }

  return issues;
}

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
