import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:peeples/utils/authentication.dart';

class GoogleSignButton extends ConsumerStatefulWidget {
  const GoogleSignButton({Key? key}) : super(key: key);

  @override
  _GoogleSignButtonState createState() => _GoogleSignButtonState();
}

class _GoogleSignButtonState extends ConsumerState {
  bool _isActioning = false;

  @override
  void initState() {
    super.initState();
    ref.read(firebaseProvider);
  }

  @override
  Widget build(BuildContext context) {
    var auth = ref.watch(firebaseProvider);

    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: _isActioning
          ? CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            )
          : OutlinedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
              ),
              onPressed: () async {
                setState(() {
                  _isActioning = true;
                });
                if (ref.watch(isSignedInProvider)) {
                  await ref
                      .watch(firebaseProvider.notifier)
                      .signOutWithGoogle(context);
                } else {
                  await ref
                      .watch(firebaseProvider.notifier)
                      .signInWithGoogle(context);
                }
                setState(() {
                  _isActioning = false;
                });
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: ref.watch(isSignedInProvider)
                          ? const Text(
                              'Sign out with Google',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black54,
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          : const Text(
                              'Sign in with Google',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black54,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
