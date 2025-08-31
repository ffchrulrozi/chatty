import 'package:chatty/featuers/dashboard/providers/dashboard_provider.dart';
import 'package:chatty/utils/helper/divider_helper.dart';
import 'package:chatty/utils/helper/style_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class DashboardDrawerWidget extends ConsumerWidget {
  const DashboardDrawerWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.read(userProvider);
    final pageIndexNotifier = ref.read(pageIndexProvider.notifier);

    void changePage(int index) {
      pageIndexNotifier.state = index;
      context.pop();
    }

    return Drawer(
      child: Column(
        children: [
          Container(
            height: 200,
            color: Colors.blueGrey,
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  children: [
                    user?.photoURL != null
                        ? ClipOval(
                            child: Image.network(
                            user!.photoURL!,
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          ))
                        : Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              color: Colors.white,
                            ),
                            padding: const EdgeInsets.all(10),
                            child: const Icon(
                              Icons.person_outline_outlined,
                              size: 40,
                            ),
                          ),
                    h(1),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user?.displayName ?? "-",
                            style: text(context)
                                .bodyLarge!
                                .copyWith(color: Colors.white),
                          ),
                          Text(
                            user?.email ?? "-",
                            style: text(context).bodyMedium!.copyWith(
                                color: Colors.white,
                                overflow: TextOverflow.ellipsis),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          InkWell(
            onTap: () => changePage(1),
            child: const DrawerMenuItem("My Profile", Icons.chat),
          ),
          const Divider(),
          InkWell(
            onTap: () => changePage(0),
            child: const DrawerMenuItem("Chats", Icons.chat),
          ),
          InkWell(
            onTap: () => changePage(2),
            child: const DrawerMenuItem("Contacts", Icons.chat),
          ),
          InkWell(
            onTap: () => changePage(3),
            child: const DrawerMenuItem(
                "Statuses", Icons.align_horizontal_left_rounded),
          ),
          InkWell(
            onTap: () => changePage(4),
            child: const DrawerMenuItem("Channels", Icons.adjust_sharp),
          ),
          InkWell(
            onTap: () => changePage(5),
            child: const DrawerMenuItem("Stared", Icons.star_border_purple500),
          ),
          const Divider(),
          InkWell(
            onTap: () => changePage(6),
            child: const DrawerMenuItem("Setting", Icons.settings),
          ),
        ],
      ),
    );
  }
}

class DrawerMenuItem extends StatelessWidget {
  final String label;
  final IconData icon;
  const DrawerMenuItem(this.label, this.icon, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [Icon(icon), h(1), Text(label)],
      ),
    );
  }
}
