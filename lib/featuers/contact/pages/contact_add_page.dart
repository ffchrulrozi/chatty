import 'package:chatty/featuers/contact/providers/contact_provider.dart';
import 'package:chatty/routes/paths.dart';
import 'package:chatty/routes/routes.dart';
import 'package:chatty/utils/helper/divider_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ContactAddPage extends ConsumerWidget {
  const ContactAddPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formNameController = TextEditingController();
    final formEmailController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("New Contact"),
      ),
      body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              TextField(
                controller: formNameController,
                decoration: const InputDecoration(labelText: "Name"),
              ),
              v(1),
              TextField(
                controller: formEmailController,
                decoration: const InputDecoration(labelText: "Email"),
              ),
              v(5),
              ElevatedButton(
                  onPressed: () {
                    ref.read(contactNotifierProvider.notifier).create(
                          formNameController.text,
                          formEmailController.text,
                        );

                    navigatorKey.currentContext?.go(PATH.DASHBOARD.path);
                  },
                  child: const Text("Save"))
            ],
          )),
    );
  }
}
