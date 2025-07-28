import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/models/dynamic_model.dart';
import '../../../core/models/dynamic_models_provider.dart';
import '../widgets/dynamic_form_builder.dart';

class DynamicRecordScreen extends ConsumerWidget {
  final String modelName;
  const DynamicRecordScreen({super.key, required this.modelName});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final modelsAsync = ref.watch(dynamicModelsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(modelName),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => GoRouter.of(context).pop(),
        ),
      ),
      body: modelsAsync.when(
        data: (models) {
          try {
            final DynamicModel model =
                models.firstWhere((m) => m.modelName == modelName);
            return Padding(
              padding: const EdgeInsets.all(16),
              child: DynamicFormBuilder(
                model: model,
                onSubmit: (data) {
                  // TODO: persist via Firestore or local cache
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Saved $modelName record!')),
                  );
                },
              ),
            );
          } catch (e) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  Text('Model "$modelName" not found'),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () => GoRouter.of(context).pop(),
                    child: const Text('Go Back'),
                  ),
                ],
              ),
            );
          }
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              Text('Error: $e'),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () => ref.refresh(dynamicModelsProvider),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
