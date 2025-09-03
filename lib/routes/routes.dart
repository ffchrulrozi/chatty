import 'package:chatty/featuers/auth/pages/auth_login_page.dart';
import 'package:chatty/featuers/chat/pages/chat_personal_page.dart';
import 'package:chatty/featuers/chat/providers/chat_personal_provider.dart';
import 'package:chatty/featuers/contact/pages/contact_add_page.dart';
import 'package:chatty/featuers/contact/pages/contact_detail_page.dart';
import 'package:chatty/featuers/contact/providers/contact_provider.dart';
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
      builder: (_, __) => const ProviderScope(child: SplashPage()),
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
      path: PATH.CONTACT_ADD,
      builder: (_, __) => const ProviderScope(child: ContactAddPage()),
    ),
    GoRoute(
        path: PATH.CONTACT_DETAIL.path,
        builder: (context, state) {
          String id = state.pathParameters["id"]!;
          return ProviderScope(
            overrides: [
              contactDetailIdProvider.overrideWithValue(id),
            ],
            child: const ContactDetailPage(),
          );
        }),
    GoRoute(
      path: PATH.CHAT_PERSONAL.path,
      builder: (context, state) {
        String id = state.pathParameters['id']!;

        return ProviderScope(
          overrides: [
            chatIdProvider.overrideWithValue(id),
          ],
          child: const ChatPersonalPage(),
        );
      },
    )
  ],
);
