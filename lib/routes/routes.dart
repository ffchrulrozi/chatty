import 'package:chatty/featuers/auth/pages/auth_login_page.dart';
import 'package:chatty/featuers/chat/pages/chat_list_contact_page.dart';
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
      path: PATH.SPLASH.path,
      builder: (_, __) => const ProviderScope(child: SplashPage()),
    ),
    GoRoute(
      path: PATH.LOGIN.path,
      builder: (_, __) => const ProviderScope(child: AuthLoginPage()),
    ),
    GoRoute(
      path: PATH.DASHBOARD.path,
      builder: (_, __) => const ProviderScope(child: DashboardPage()),
    ),
    GoRoute(
      path: PATH.CONTACT_ADD.path,
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
      },
    ),
    GoRoute(
      path: PATH.CHAT_LIST_CONTACT.path,
      builder: (_, __) => const ProviderScope(child: ChatListContactPage()),
    ),
    GoRoute(
      path: PATH.CHAT_PERSONAL.path,
      builder: (context, state) {
        final String id = state.pathParameters['id']!;
        final String name = state.uri.queryParameters['name']!;

        return ProviderScope(
          overrides: [
            chatIdProvider.overrideWithValue(id),
            receiverNameProvider.overrideWithValue(name),
          ],
          child: PopScope(
            canPop: false,
            onPopInvokedWithResult: (didPop, result) {
              if (didPop) return;
              context.go(PATH.DASHBOARD.path);
            },
            child: const ChatPersonalPage(),
          ),
        );
      },
    )
  ],
);
