import 'package:flutter/material.dart';

AlertDialog alertbox = AlertDialog(
  insetPadding: const EdgeInsets.symmetric(horizontal: 100),
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  backgroundColor: Colors.white,
  elevation: 6,
  content: SizedBox(
    width: 30,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: const CircularProgressIndicator(
              backgroundColor: Color.fromARGB(255, 252, 251, 250),
            )),
        const Text(
          'Please Wait...',
          style: TextStyle(color: Color.fromARGB(255, 6, 0, 0)),
        )
      ],
    ),
  ),
);
