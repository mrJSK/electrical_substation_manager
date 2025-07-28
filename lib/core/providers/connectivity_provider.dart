// lib/core/providers/connectivity_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/connectivity_service.dart';

final connectivityServiceProvider = Provider<ConnectivityService>((ref) {
  return ConnectivityService();
});

final connectivityStatusProvider = StreamProvider<ConnectivityStatus>((ref) {
  final service = ref.watch(connectivityServiceProvider);

  // Convert ChangeNotifier to Stream
  return Stream.fromFuture(service.initialize().then((_) => service.status))
      .asyncExpand((_) {
    return Stream.periodic(const Duration(seconds: 1), (_) => service.status);
  });
});

final isOnlineProvider = Provider<bool>((ref) {
  final connectivity = ref.watch(connectivityServiceProvider);
  return connectivity.isOnline;
});
