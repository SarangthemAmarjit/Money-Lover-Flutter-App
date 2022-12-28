import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moneylover/router/router.gr.dart';
import 'package:moneylover/services/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: StreamBuilder(
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot> streamsnapshot) {
          if (streamsnapshot.hasData) {
            var data = streamsnapshot.data!.docs;
            int totalamount = 0;
            for (var element in data) {
              totalamount = totalamount + element['amount'] as int;
            }

            Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Row(
                  children: const [Text('₹')],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    right: 10,
                  ),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: TextButton.icon(
                      style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all(
                              const Color.fromARGB(255, 88, 56, 232))),
                      icon: const Icon(Icons.logout),
                      label: Text(
                        'Log Out',
                        style: GoogleFonts.kreon(),
                      ),
                      onPressed: () async {
                        showDialog(
                            context: context,
                            builder: ((context) {
                              return AlertDialog(
                                title: Text(
                                  'Confirm',
                                  style: GoogleFonts.kreon(),
                                ),
                                content: Text('Do You Want to Logout?',
                                    style: GoogleFonts.kreon()),
                                actions: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.green),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text("CANCEL",
                                              style: GoogleFonts.kreon())),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.green),
                                            onPressed: () async {
                                              final prefs =
                                                  await SharedPreferences
                                                      .getInstance();
                                              log('Log Out');
                                              prefs
                                                  .remove('uid')
                                                  .whenComplete(() {
                                                AuthService().Googlesignout();
                                                context.router.push(
                                                    const AuthFlowRoute());
                                              });
                                            },
                                            child: Text("YES",
                                                style: GoogleFonts.kreon())),
                                      )
                                    ],
                                  ),
                                ],
                              );
                            }));

                        log('Done');
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  'Welcome to Money Lover',
                  style: GoogleFonts.kreon(fontSize: 20),
                )
              ],
            );
          }
        },
      )),
    );
  }
}
