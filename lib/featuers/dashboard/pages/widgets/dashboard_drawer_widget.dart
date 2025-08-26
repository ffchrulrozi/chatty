import 'package:chatty/utils/helper/divider_helper.dart';
import 'package:chatty/utils/helper/style_helper.dart';
import 'package:flutter/material.dart';

class DashboardDrawerWidget extends StatelessWidget {
  final Function(int) changePage;
  const DashboardDrawerWidget({required this.changePage, super.key});

  @override
  Widget build(BuildContext context) {
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
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.white,
                      ),
                      padding: const EdgeInsets.all(10),
                      child: const Icon(
                        Icons.person_outline_outlined,
                        size: 75,
                      ),
                    ),
                    h(1),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Fachrul Rozi",
                            style: text(context)
                                .bodyLarge!
                                .copyWith(color: Colors.white),
                          ),
                          Text(
                            "ffchrulrozi@gmail.com",
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
            child:
                const DrawerMenuItem("Statuses", Icons.align_horizontal_left_rounded),
          ),
          InkWell(
            onTap: () => changePage(3),
            child: const DrawerMenuItem("Channels", Icons.adjust_sharp),
          ),
          InkWell(
            onTap: () => changePage(4),
            child: const DrawerMenuItem("Stared", Icons.star_border_purple500),
          ),
          const Divider(),
          InkWell(
            onTap: () => changePage(5),
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
