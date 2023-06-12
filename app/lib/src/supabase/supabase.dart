import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide Provider;

final supabaseProvider = Provider((ref) => Supabase.instance.client);

final AutoDisposeStreamProvider<AuthState> authStateProvider =
    StreamProvider.autoDispose((ref) {
  final supabase = ref.watch(supabaseProvider);
  return supabase.auth.onAuthStateChange;
});
