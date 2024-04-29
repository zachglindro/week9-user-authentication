import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../providers/auth_provider.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpState();
}

class _SignUpState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
            margin: const EdgeInsets.all(30),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [heading, emailField, passwordField, submitButton],
              ),
            )),
      ),
    );
  }

  bool isEmailValid(String? email) {
    var re = RegExp(r"^[\w\.]+[A-z0-9]@[a-z]+\.[a-z]+$", unicode: true);
    if (email == null) return false;
    return email.length >= 8 && re.hasMatch(email);
  }

  bool isPasswordValid(String? password) {
    var re = RegExp(r"^[\w@&\$!#\?%]+$", unicode: true);
    var cap = RegExp(r"[A-Z]", unicode: true);
    var low = RegExp(r"[a-z]", unicode: true);
    var num = RegExp(r"[0-9]", unicode: true);
    var char = RegExp(r"[@&\$!#\?%]", unicode: true);

    if (password == null) return false;

    bool hasRequiredChars = cap.hasMatch(password) &&
        low.hasMatch(password) &&
        num.hasMatch(password) &&
        char.hasMatch(password);

    return password.length >= 8 && re.hasMatch(password) && hasRequiredChars;
  }

  Widget get heading => const Padding(
        padding: EdgeInsets.only(bottom: 30),
        child: Text(
          "Sign Up",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      );

  Widget get emailField => Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: TextFormField(
          decoration: const InputDecoration(
              border: OutlineInputBorder(),
              label: Text("Email"),
              hintText: "Enter a valid email"),
          onSaved: (value) => setState(() => email = value),
          validator: (value) {
            if (!isEmailValid(value)) {
              return "Please enter a valid email format";
            }
            return null;
          },
        ),
      );

  Widget get passwordField => Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: TextFormField(
          decoration: const InputDecoration(
              border: OutlineInputBorder(),
              label: Text("Password"),
              hintText: "At least 8 characters"),
          obscureText: true,
          onSaved: (value) => setState(() => password = value),
          validator: (value) {
            if (!isPasswordValid(value)) {
              return "Must contain A-z, 0-9, !@#\$?&%";
            }
            return null;
          },
        ),
      );

  Widget get submitButton => ElevatedButton(
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          _formKey.currentState!.save();
          // await context
          //     .read<UserAuthProvider>()
          //     .authService
          //     .signUp(email!, password!);
        }
      },
      child: const Text("Sign Up"));
}
