import 'package:chatty/featuers/contact/models/contact.dart';
import 'package:chatty/featuers/contact/providers/contact_provider.dart';
import 'package:chatty/routes/paths.dart';
import 'package:chatty/routes/routes.dart';
import 'package:chatty/utils/helper/divider_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ContactDetailPage extends ConsumerStatefulWidget {
  const ContactDetailPage({super.key});

  @override
  ConsumerState<ContactDetailPage> createState() => _ContactDetailPageState();
}

class _ContactDetailPageState extends ConsumerState<ContactDetailPage> {
  DetailContact? data;

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future getData() async {
    var res = await ref.read(contactNotifierProvider.notifier).detailContact();
    setState(() {
      data = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    final formNameController = TextEditingController(text: data?.name);
    final formEmailController = TextEditingController(text: data?.email);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Contact"),
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
                  ref.read(contactNotifierProvider.notifier).update(
                        formNameController.text,
                        formEmailController.text,
                      );
                  navigatorKey.currentContext?.go(PATH.DASHBOARD);
                },
                child: const Text("Save Changes"),
              ),
              v(2),
              ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text("Confirm"),
                          content: const Text(
                              "Are you sure you want to delete this user?"),
                          actions: [
                            TextButton(
                              onPressed: () => context.pop(),
                              child: const Text("Cancel"),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                ref
                                    .read(contactNotifierProvider.notifier)
                                    .delete();

                                context.go(PATH.DASHBOARD);
                              },
                              child: const Text("Delete"),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: const Text(
                    "Delete",
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          )),
    );
  }
}
