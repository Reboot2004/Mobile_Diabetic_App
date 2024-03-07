import 'package:flutter/material.dart';

class RegistrationSuccessDialog extends StatelessWidget {
  final BuildContext context;
  final VoidCallback onOkPressed;

  const RegistrationSuccessDialog({
    Key? key,
    required this.context,
    required this.onOkPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Registration Successful'),
      content: const Text('You can now sign in with your credentials.'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            onOkPressed();
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
