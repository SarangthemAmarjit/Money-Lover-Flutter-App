import 'package:flutter/material.dart';

class AmountPage extends StatelessWidget {
  const AmountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: const [
          SizedBox(
            height: 50,
          ),
          Text('Add Amount')
        ],
      ),
    );
  }
}
