import 'package:chatty/featuers/contact/providers/contact_provider.dart';
import 'package:chatty/utils/helper/divider_helper.dart';
import 'package:chatty/utils/helper/style_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ContactListPage extends ConsumerWidget {
  const ContactListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const colors = [
      Colors.blue,
      Colors.green,
      Colors.amber,
      Colors.red,
      Colors.teal,
      Colors.grey,
      Colors.purple,
      Colors.blueGrey
    ];

    var contactStreaming = ref.watch(contactStreamingProvider);

    return contactStreaming.when(
      data: (contacts) {
        return ListView.builder(
          itemCount: contacts.length,
          itemBuilder: (context, index) {
            final contact = contacts[index];
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: colors[index],
                        borderRadius: BorderRadius.circular(50)),
                    width: 50,
                    height: 50,
                    child: Center(
                      child: Text(
                        contact.name[0].toUpperCase(),
                        style: text(context)
                            .titleLarge!
                            .copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                  h(1),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        contact.name,
                        style: text(context).titleMedium,
                      ),
                      Text(contact.email),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
      error: (e, st) => const Center(child: Text("An error occured")),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
