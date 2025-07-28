import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'core/services/connectivity_service.dart';
import 'core/services/enhanced_isar_service.dart';
import 'features/dashboard/widgets/connectivity_wrapper.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize connectivity service
  await ConnectivityService().initialize();

  // Initialize Isar cache
  await EnhancedIsarService.initialize();

  runApp(const ProviderScope(child: SubstationManagerApp()));
}

class SubstationManagerApp extends ConsumerWidget {
  const SubstationManagerApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title: 'Substation Manager Pro',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return ConnectivityWrapper(
          child: child ?? const SizedBox(),
        );
      },
    );
  }
}
