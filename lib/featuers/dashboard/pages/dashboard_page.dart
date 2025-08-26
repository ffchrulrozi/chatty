import 'package:chatty/featuers/channel/pages/channel_page.dart';
import 'package:chatty/featuers/chat/pages/chat_list_page.dart';
import 'package:chatty/featuers/dashboard/pages/widgets/dashboard_drawer_widget.dart';
import 'package:chatty/featuers/profile/page/profile_page.dart';
import 'package:chatty/featuers/setting/page/setting_page.dart';
import 'package:chatty/featuers/star/page/star_page.dart';
import 'package:chatty/featuers/status/page/status_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int pageIndex = 0;

  void changePage(int index) {
    context.pop();
    setState(() {
      pageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
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
      drawer: DashboardDrawerWidget(changePage: changePage),
    );
  }
}
