import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'firebase_options.dart';
import 'screens/shared/splash_screen.dart';

// TODO: Import your Isar collection schemas here.
// Example: import 'models/equipment.g.dart';

/// ## Isar Provider
///
/// Use a Riverpod provider to safely manage the Isar instance.
/// This avoids global variables and allows the UI to reactively handle
/// the asynchronous initialization.
final isarProvider = FutureProvider<Isar>((ref) async {
  final dir = await getApplicationDocumentsDirectory();
  // Open the Isar instance with all your collection schemas.
  return await Isar.open(
    [
      // TODO: Add your Isar collection schemas here.
      // Example: EquipmentSchema,
    ],
    directory: dir.path,
    name: 'SubstationDB', // Optional: Give your database a name
  );
});

Future<void> main() async {
  // Ensure Flutter bindings are initialized.
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase.
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // The ProviderScope stores the state of all providers.
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Substation Manager Pro',
      debugShowCheckedModeBanner: false,
      // Use ResponsiveBreakpoints for responsive UI.
      builder: (context, child) => ResponsiveBreakpoints.builder(
        child: child!,
        breakpoints: [
          const Breakpoint(start: 0, end: 450, name: MOBILE),
          const Breakpoint(start: 451, end: 900, name: TABLET),
          const Breakpoint(start: 901, end: 1920, name: DESKTOP),
          const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
        ],
      ),
      // Updated theme for Material 3.
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        useMaterial3: true,
      ),
      // Set SplashScreen as the initial route.
      home: const SplashScreen(),
    );
  }
}
