import 'package:chatty/featuers/auth/pages/auth_login_page.dart';
import 'package:chatty/featuers/chat/pages/chat_group_page.dart';
import 'package:chatty/featuers/chat/pages/chat_personal_page.dart';
import 'package:chatty/featuers/dashboard/pages/dashboard_page.dart';
import 'package:chatty/featuers/splash/pages/splash_page.dart';
import 'package:chatty/routes/paths.dart';
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
      builder: (_, __) => const AuthLoginPage(),
    ),
    GoRoute(
      path: PATH.DASHBOARD,
      builder: (_, __) => const DashboardPage(),
    ),
    GoRoute(
      path: PATH.CHAT_PERSONAL,
      builder: (_, __) => const ChatPersonalPage(),
    ),
    GoRoute(
      path: PATH.CHAT_GROUP,
      builder: (_, __) => const ChatGroupPage(),
    ),
  ],
);
