import 'package:chatty/assets/assets.gen.dart';
import 'package:chatty/featuers/auth/providers/auth_provider.dart';
import 'package:chatty/utils/helper/divider_helper.dart';
import 'package:chatty/utils/helper/style_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthLoginPage extends ConsumerWidget {
  const AuthLoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final authNotifier = ref.read(authProvider.notifier);

    return Scaffold(
      body: authState.isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    Assets.lib.assets.img.logo.path,
                    width: 125,
                    height: 125,
                    fit: BoxFit.cover,
                  ),
                  v(10),
                  SizedBox(
                    width: 300,
                    child: ElevatedButton(
                      onPressed: () => authNotifier.login(),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              Assets.lib.assets.img.google.path,
                              width: 25,
                              height: 25,
                              fit: BoxFit.cover,
                            ),
                            h(1),
                            const Text("Login with Google")
                          ],
                        ),
                      ),
                    ),
                  ),
                  v(2),
                  Text(
                    authState.message ?? "",
                    style: text(context).bodySmall!.copyWith(color: Colors.red),
                  ),
                  v(10),
                ],
              ),
            ),
    );
  }
}
