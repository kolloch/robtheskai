import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:robokru/src/app.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://lappodmgqobkrcswzhmv.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImxhcHBvZG1ncW9ia3Jjc3d6aG12Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2ODU3ODE3MTMsImV4cCI6MjAwMTM1NzcxM30.12FJqI631GawO2xpjYRM_824s3UgaGdKKBzL7AUayHo',
  );

  runApp(ProviderScope(
    child: MyApp(router: appRouter),
  ));
}
