import 'package:flutter/material.dart';

import '../constants.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.13),
      child: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            TextFormField(
              decoration: InputDecoration(
                hintText: "Email",
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: defpaultPadding),
              child: TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Senha",
                ),
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                "Esqueceu sua senha?",
                style: TextStyle(color: Colors.white),
              ),
            ),
            Spacer(flex: 2),//define localização do form
          ],
        ),
      ),
    );
  }
}
