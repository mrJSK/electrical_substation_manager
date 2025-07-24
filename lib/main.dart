import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';

import 'firebase_options.dart';
import 'services/location_service.dart';
import 'web/router/web_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Load states/cities JSON for the organization builder
  await LocationService.initializeLocationData();

  runApp(
    const ProviderScope(
      child: ElectriAdminApp(),
    ),
  );
}

class ElectriAdminApp extends StatelessWidget {
  const ElectriAdminApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'ElectriAdmin - Substation Management',
      theme: ThemeData(
        useMaterial3: true,
        textTheme: GoogleFonts.interTextTheme(),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF3B82F6),
          brightness: Brightness.light,
        ),
      ),
      routerConfig: webRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}
