// flutter
import 'package:flutter/material.dart';
// external packages
import 'package:firebase_auth/firebase_auth.dart';
// own library (private)
import 'package:flutter_widgets/flutter_widgets.dart';
// this project
import 'package:flutter_scheduler/home/screen.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);
  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  TextEditingController textControllerPassword = TextEditingController();
  TextEditingController textControllerEmail = TextEditingController();

  bool showPassword = false;
  bool disabledUpload = true;

  UserCredential? creds;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: MediaQuery.of(context).size.height / 5,
        horizontal: 8.0,
      ),
      child: Center(
        child: SizedBox(
          width: 400,
          height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              TextField(
                controller: textControllerEmail,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
                onChanged: (value) => setState(() {
                  disabledUpload = textControllerPassword.text == '' ||
                      textControllerEmail.text == '';
                }),
              ),
              TextField(
                controller: textControllerPassword,
                obscureText: !showPassword,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'Password',
                  suffixIcon: IconButton(
                    icon: Tooltip(
                      message: showPassword ? 'Show' : 'Hide',
                      child: showPassword
                          ? const Icon(Icons.visibility_off)
                          : const Icon(Icons.visibility),
                    ),
                    onPressed: () => setState(() {
                      showPassword = !showPassword;
                    }),
                  ),
                ),
                onChanged: (value) => setState(() {
                  disabledUpload = textControllerPassword.text == '' ||
                      textControllerEmail.text == '';
                }),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 50,
                width: 250,
                child: Theme(
                  data: Theme.of(context),
                  child: CustomAsyncButton(
                    disabledUpload: disabledUpload,
                    buttonText: 'Login',
                    onPressed: () async => creds =
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: textControllerEmail.text,
                      password: textControllerPassword.text,
                    ),
                    onSuccess: () {
                      if (creds!.user != null) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const HomeScreen(),
                          ),
                        );
                      }
                      setState(() {
                        textControllerPassword.text = '';
                        textControllerEmail.text = '';
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
