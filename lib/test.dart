import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TtestLol extends StatefulWidget {
  const TtestLol({Key? key}) : super(key: key);

  @override
  _TtestLolState createState() => _TtestLolState();
}

class _TtestLolState extends State<TtestLol> {
  void signIn() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: "barry.allen@example.com",
              password: "SuperSecretPassword!");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: ElevatedButton(
          onPressed: () => signIn(),
          child: Text('Click'),
        ),
      ),
    );
  }
}
