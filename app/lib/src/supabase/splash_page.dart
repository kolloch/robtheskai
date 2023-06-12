import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:robokru/src/supabase/account_page.dart';
import 'package:robokru/src/supabase/supabase.dart';

import 'login_page.dart';

class AccountSplashPage extends ConsumerStatefulWidget {
  static const routeName = '/splash';

  const AccountSplashPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _SplashPageState();
  }
}

class _SplashPageState extends ConsumerState<AccountSplashPage> {
  bool _redirectCalled = false;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _redirect();
  }

  Future<void> _redirect() async {
    await Future.delayed(Duration.zero);
    if (_redirectCalled || !mounted) {
      return;
    }

    _redirectCalled = true;
    final supabase = ref.read(supabaseProvider);
    final session = supabase.auth.currentSession;
    if (session != null) {
      context.pushReplacementNamed(AccountPage.routeName);
    } else {
      context.pushReplacementNamed(LoginPage.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
