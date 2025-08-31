import 'package:chatty/featuers/channel/pages/channel_page.dart';
import 'package:chatty/featuers/chat/pages/chat_list_page.dart';
import 'package:chatty/featuers/chat/providers/chat_provider.dart';
import 'package:chatty/featuers/contact/pages/contact_list_page.dart';
import 'package:chatty/featuers/dashboard/pages/widgets/dashboard_drawer_widget.dart';
import 'package:chatty/featuers/dashboard/providers/dashboard_provider.dart';
import 'package:chatty/featuers/profile/page/profile_page.dart';
import 'package:chatty/featuers/setting/page/setting_page.dart';
import 'package:chatty/featuers/star/page/star_page.dart';
import 'package:chatty/featuers/status/page/status_page.dart';
import 'package:chatty/routes/paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int pageIndex = ref.watch(pageIndexProvider);

    return Scaffold(
        appBar: AppBar(title: const Text("Chatty")),
        body: IndexedStack(
          index: pageIndex,
          children: const [
            ChatListPage(),
            ProfilePage(),
            ContactListPage(),
            StatusPage(),
            ChannelPage(),
            StarPage(),
            SettingPage(),
          ],
        ),
        drawer: const DashboardDrawerWidget(),
        floatingActionButton: FloatingActionButtonWidget(pageIndex, ref));
  }
}

class FloatingActionButtonWidget extends StatelessWidget {
  final int pageIndex;
  final WidgetRef ref;
  const FloatingActionButtonWidget(this.pageIndex, this.ref, {super.key});

  @override
  Widget build(BuildContext context) {
    switch (pageIndex) {
      case 0:
        return FloatingActionButton(
          backgroundColor: Colors.blue,
          onPressed: () => ref
              .read(newChatNotifierProvider.notifier)
              .newChat("ffachrulrozii@gmail.com"),
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        );

      case 2:
        return FloatingActionButton.extended(
          backgroundColor: Colors.blue,
          onPressed: () => context.push(PATH.CONTACT_ADD),
          label: const Row(
            children: [
              Icon(
                Icons.add,
                color: Colors.white,
              ),
              Text(
                "New Contact",
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        );

      default:
        return Container();
    }
  }
}
