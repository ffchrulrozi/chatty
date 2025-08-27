import 'package:chatty/assets/assets.gen.dart';
import 'package:chatty/routes/paths.dart';
import 'package:chatty/utils/helper/divider_helper.dart';
import 'package:chatty/utils/helper/style_helper.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChatListPage extends StatelessWidget {
  const ChatListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final users = ['ffachrulrozii@gmail.com', 'budi', 'cindi', 'dodi', 'edi'];
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        var chat = users[index];
        return InkWell(
          onTap: () => context.push("${PATH.CHAT_PERSONAL.name}/$chat"),
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                ClipOval(
                  child: Image.asset(
                    Assets.lib.assets.img.logo.path,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
                h(1.5),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      chat,
                      style: text(context).titleMedium,
                    ),
                    const Text("Last Message"),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
