import 'package:chatty/featuers/auth/pages/auth_login_page.dart';
import 'package:chatty/featuers/chat/pages/chat_personal_page.dart';
import 'package:chatty/featuers/chat/providers/chat_provider.dart';
import 'package:chatty/featuers/dashboard/pages/dashboard_page.dart';
import 'package:chatty/featuers/splash/pages/splash_page.dart';
import 'package:chatty/routes/paths.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final appRoutes = GoRouter(
  navigatorKey: navigatorKey,
  routes: [
    GoRoute(
      path: PATH.SPLASH,
      builder: (_, __) => const SplashPage(),
    ),
    GoRoute(
      path: PATH.LOGIN,
      builder: (_, __) => const ProviderScope(child: AuthLoginPage()),
    ),
    GoRoute(
      path: PATH.DASHBOARD,
      builder: (_, __) => const ProviderScope(child: DashboardPage()),
    ),
    GoRoute(
      path: PATH.CHAT_PERSONAL.path,
      builder: (context, state) {
        String myEmail = FirebaseAuth.instance.currentUser!.email!;
        String receiverEmail = state.pathParameters['id']!;
        String chatId = myEmail.hashCode <= receiverEmail.hashCode
            ? "$myEmail#$receiverEmail"
            : "$receiverEmail#$myEmail";

        return ProviderScope(
          overrides: [
            chatIdProvider.overrideWithValue(chatId),
            receiverEmailProvider.overrideWithValue(receiverEmail),
          ],
          child: const ChatPersonalPage(),
        );
      },
    )
  ],
);
