import 'package:flutter/material.dart';

class EmailFieldWidget extends StatefulWidget {
  final TextEditingController emailCon;

  const EmailFieldWidget({super.key, required this.emailCon});

  @override
  State<EmailFieldWidget> createState() => _EmailFieldWidgetState();
}

class _EmailFieldWidgetState extends State<EmailFieldWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.emailCon,
      decoration: InputDecoration(
        hintText: 'Username or Email',
      ),
      keyboardType: TextInputType.emailAddress,
    );
  }
}
