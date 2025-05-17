import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bookfeed_app/providers/auth_provider.dart';
import 'package:bookfeed_app/pages/welcome_page.dart';
import 'package:bookfeed_app/pages/feed_page.dart';

class AuthLayout extends StatelessWidget {
  const AuthLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();

    if (auth.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (auth.user != null) {
      return const FeedPage();
    }
    return const WelcomePage();
  }
}