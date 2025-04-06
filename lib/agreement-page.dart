import 'package:flutter/material.dart';

class AgreementPage extends StatelessWidget {
  final String agreementText;

  AgreementPage({required this.agreementText});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Licensing Agreement")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Text(
            agreementText,
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}
