import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:peeples/utils/authentication.dart';
import 'package:peeples/widgets/google_sign_btn.dart';

class SignInScreen extends ConsumerWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
          child: FutureBuilder(
        future: ref.read(firebaseProvider.notifier).setup(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          } else if (snapshot.connectionState == ConnectionState.done) {
            return const GoogleSignButton();
          } else {
            return const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(
                Colors.deepPurple,
              ),
            );
          }
        },
      )),
    );
  }
}
