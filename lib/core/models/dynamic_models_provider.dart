import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/dynamic_model.dart';
import '../constants/app_constants.dart';

final dynamicModelsProvider =
    FutureProvider.autoDispose<List<DynamicModel>>((ref) async {
  try {
    final snapshot = await FirebaseFirestore.instance
        .collection(AppConstants.dynamicModelsCollection)
        .where('isActive', isEqualTo: true)
        .get();

    return snapshot.docs.map((doc) => DynamicModel.fromFirestore(doc)).toList();
  } catch (e) {
    throw Exception('Failed to load dynamic models: $e');
  }
});

// Alternative provider that takes organization ID
final dynamicModelsByOrgProvider =
    FutureProvider.family.autoDispose<List<DynamicModel>, String>(
  (ref, organizationId) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection(AppConstants.dynamicModelsCollection)
          .where('organizationId', isEqualTo: organizationId)
          .where('isActive', isEqualTo: true)
          .get();

      return snapshot.docs
          .map((doc) => DynamicModel.fromFirestore(doc))
          .toList();
    } catch (e) {
      throw Exception('Failed to load models for organization: $e');
    }
  },
);

// Provider for getting a specific model by name
final dynamicModelByNameProvider =
    FutureProvider.family.autoDispose<DynamicModel?, String>(
  (ref, modelName) async {
    final models = await ref.watch(dynamicModelsProvider.future);
    try {
      return models.firstWhere((model) => model.modelName == modelName);
    } catch (e) {
      return null; // Model not found
    }
  },
);
