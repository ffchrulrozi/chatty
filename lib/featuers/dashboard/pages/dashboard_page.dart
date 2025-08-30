import 'package:chatty/featuers/channel/pages/channel_page.dart';
import 'package:chatty/featuers/chat/pages/chat_list_page.dart';
import 'package:chatty/featuers/chat/providers/chat_provider.dart';
import 'package:chatty/featuers/dashboard/pages/widgets/dashboard_drawer_widget.dart';
import 'package:chatty/featuers/dashboard/providers/dashboard_provider.dart';
import 'package:chatty/featuers/profile/page/profile_page.dart';
import 'package:chatty/featuers/setting/page/setting_page.dart';
import 'package:chatty/featuers/star/page/star_page.dart';
import 'package:chatty/featuers/status/page/status_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
          StatusPage(),
          ChannelPage(),
          StarPage(),
          SettingPage(),
        ],
      ),
      drawer: const DashboardDrawerWidget(),
      floatingActionButton: pageIndex == 0
          ? FloatingActionButton(
              backgroundColor: Colors.blue,
              onPressed: () => ref
                  .read(newChatNotifierProvider.notifier)
                  .newChat("ffachrulrozii@gmail.com"),
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            )
          : null,
    );
  }
}
