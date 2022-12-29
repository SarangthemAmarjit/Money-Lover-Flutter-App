import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moneylover/logic/fetchdata/cubit/fetchdata_cubit.dart';
import 'package:moneylover/logic/fetchdata2/cubit/fetchrecentdata_cubit.dart';
import 'package:moneylover/router/router.gr.dart';
import 'package:moneylover/services/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CollectionReference transaction =
      FirebaseFirestore.instance.collection('transaction');
  var currencyformat =
      NumberFormat.currency(locale: 'en_IN', symbol: '₹', decimalDigits: 0);

  IconData? itemicon;
  Color? avatarcolor;
  Color? iconcolor;

  @override
  Widget build(BuildContext context) {
    final s = context.watch<FetchdataCubit>().state;
    final recent = context.watch<FetchrecentdataCubit>().state;
    int totalamount = s.amount;
    List<DocumentSnapshot<Object?>> cateogoryname = recent.categoyname;
    List<QueryDocumentSnapshot<Object?>> transaction = recent.transaction;
    List<DocumentSnapshot<Object?>> cateogorynameEx = s.cateogoryname_ex;
    List<QueryDocumentSnapshot<Object?>> transactionEx = s.transaction_ex;
    int expensetotalamount = s.expensetotalamount;

    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 245, 242, 242),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: SafeArea(
              child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 10,
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
                                      padding: const EdgeInsets.only(left: 10),
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
                                              context.router
                                                  .push(const AuthFlowRoute());
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          currencyformat.format(totalamount),
                          style: GoogleFonts.kreon(fontSize: 30),
                        ),
                        Row(
                          children: [
                            Text(
                              'Total balance',
                              style: GoogleFonts.kreon(
                                  fontSize: 16,
                                  color:
                                      const Color.fromARGB(255, 171, 169, 169)),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 5),
                              child: CircleAvatar(
                                backgroundColor:
                                    Color.fromARGB(255, 196, 195, 195),
                                radius: 8,
                                child: FaIcon(
                                  FontAwesomeIcons.question,
                                  color: Colors.white,
                                  size: 10,
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    const Icon(
                      Icons.notifications,
                      size: 30,
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 115,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Text(
                              'Did you find the Home feature useful to you?',
                              style: GoogleFonts.kreon(fontSize: 16),
                            ),
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 26),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(18),
                                      color: const Color.fromARGB(
                                          255, 222, 237, 247)),
                                  height: 45,
                                  width: 97,
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          const Icon(Icons.thumb_up,
                                              color: Color.fromARGB(
                                                  255, 98, 189, 249)),
                                          Text(
                                            'Yes',
                                            style: GoogleFonts.kreon(
                                                color: const Color.fromARGB(
                                                    255, 98, 189, 249)),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(18),
                                      color: const Color.fromARGB(
                                          255, 247, 229, 222)),
                                  height: 45,
                                  width: 97,
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          const Icon(Icons.thumb_down,
                                              color: Color.fromARGB(
                                                  255, 249, 116, 98)),
                                          Text(
                                            'No',
                                            style: GoogleFonts.kreon(
                                                color: const Color.fromARGB(
                                                    255, 249, 116, 98)),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
                child: Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 115,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 26, right: 26, top: 15, bottom: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'My Wallets',
                                style: GoogleFonts.kreon(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'See all',
                                style: GoogleFonts.kreon(
                                    fontSize: 16,
                                    color:
                                        const Color.fromARGB(255, 63, 180, 67)),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 26),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 1,
                            color: const Color.fromARGB(255, 235, 232, 232),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 26, top: 10, right: 26),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(right: 15),
                                    child: CircleAvatar(
                                        backgroundColor:
                                            Color.fromARGB(255, 43, 56, 96),
                                        radius: 18,
                                        child: FaIcon(
                                          FontAwesomeIcons.wallet,
                                          color:
                                              Color.fromARGB(255, 248, 135, 79),
                                        )),
                                  ),
                                  Text(
                                    'Cash',
                                    style: GoogleFonts.kreon(fontSize: 18),
                                  )
                                ],
                              ),
                              Text(
                                currencyformat.format(totalamount),
                                style: GoogleFonts.kreon(fontSize: 17),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 26),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Spending report',
                      style: GoogleFonts.kreon(
                          fontSize: 17,
                          color: const Color.fromARGB(255, 160, 158, 158)),
                    ),
                    Text(
                      'See reports',
                      style: GoogleFonts.kreon(
                          fontSize: 17,
                          color: const Color.fromARGB(255, 63, 180, 67)),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                child: Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 570,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 270,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 26, bottom: 26),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Top Spending',
                              style: GoogleFonts.kreon(fontSize: 18),
                            ),
                          ),
                        ),
                        ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: cateogorynameEx.length,
                            itemBuilder: ((context, index) {
                              double per = (transactionEx[index]['amount'] /
                                      expensetotalamount) *
                                  100;
                              switch (cateogorynameEx[index]['name']) {
                                case 'Transportation':
                                  itemicon = FontAwesomeIcons.train;
                                  avatarcolor = Colors.yellow;
                                  iconcolor = Colors.blue;

                                  break;
                                case 'Foods and Drink':
                                  itemicon = FontAwesomeIcons.martiniGlass;
                                  avatarcolor =
                                      const Color.fromARGB(255, 95, 208, 249);
                                  iconcolor = Colors.red;

                                  break;
                                case 'Gas Bill':
                                  itemicon = FontAwesomeIcons.gasPump;
                                  avatarcolor = Colors.red;
                                  iconcolor = Colors.white;

                                  break;

                                default:
                                  itemicon = FontAwesomeIcons.fileInvoiceDollar;
                                  avatarcolor =
                                      const Color.fromARGB(255, 209, 54, 244);
                              }

                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: ListTile(
                                  leading: CircleAvatar(
                                      backgroundColor: avatarcolor,
                                      radius: 18,
                                      child:
                                          FaIcon(itemicon, color: iconcolor)),
                                  title: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        cateogorynameEx[index]['name'],
                                        style: GoogleFonts.kreon(fontSize: 18),
                                      ),
                                      Text(
                                        currencyformat.format(
                                            transactionEx[index]['amount']),
                                        style: GoogleFonts.kreon(
                                            fontSize: 15, color: Colors.grey),
                                      )
                                    ],
                                  ),
                                  trailing: Text(
                                    '${per.toInt().toString()}%',
                                    style: GoogleFonts.kreon(
                                        fontSize: 18, color: Colors.red),
                                  ),
                                ),
                              );
                            }))
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 26, right: 26, top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Recent transactions',
                      style: GoogleFonts.kreon(
                          fontSize: 17,
                          color: const Color.fromARGB(255, 160, 158, 158)),
                    ),
                    Text(
                      'See all',
                      style: GoogleFonts.kreon(
                          fontSize: 17,
                          color: const Color.fromARGB(255, 63, 180, 67)),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                child: Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 300,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: cateogoryname.length,
                              itemBuilder: ((context, index) {
                                Timestamp date = transaction[index]['date'];
                                var datetime = date.toDate();
                                var datefinal =
                                    DateFormat.yMMMd().format(datetime);
                                switch (cateogoryname[index]['name']) {
                                  case 'Transportation':
                                    itemicon = FontAwesomeIcons.train;
                                    avatarcolor = Colors.yellow;
                                    iconcolor = Colors.blue;

                                    break;
                                  case 'Foods and Drink':
                                    itemicon = FontAwesomeIcons.martiniGlass;
                                    avatarcolor =
                                        const Color.fromARGB(255, 95, 208, 249);
                                    iconcolor = Colors.red;

                                    break;
                                  case 'Gas Bill':
                                    itemicon = FontAwesomeIcons.gasPump;
                                    avatarcolor = Colors.red;
                                    iconcolor = Colors.white;

                                    break;
                                  case 'Salary':
                                    itemicon = FontAwesomeIcons.coins;
                                    avatarcolor = Colors.yellow;
                                    iconcolor =
                                        const Color.fromARGB(255, 86, 237, 44);

                                    break;

                                  default:
                                    avatarcolor =
                                        const Color.fromARGB(255, 209, 54, 244);
                                    itemicon =
                                        FontAwesomeIcons.fileInvoiceDollar;
                                }

                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: ListTile(
                                    leading: CircleAvatar(
                                        backgroundColor: avatarcolor,
                                        radius: 18,
                                        child:
                                            FaIcon(itemicon, color: iconcolor)),
                                    title: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          cateogoryname[index]['name'],
                                          style:
                                              GoogleFonts.kreon(fontSize: 18),
                                        ),
                                        Text(
                                          datefinal.toString(),
                                          style: GoogleFonts.kreon(
                                              fontSize: 15, color: Colors.grey),
                                        )
                                      ],
                                    ),
                                    trailing: Text(
                                      currencyformat
                                          .format(transaction[index]['amount']),
                                      style: GoogleFonts.kreon(
                                          fontSize: 18,
                                          color: cateogoryname[index]['name'] ==
                                                  'Salary'
                                              ? const Color.fromARGB(
                                                  255, 72, 215, 247)
                                              : Colors.red),
                                    ),
                                  ),
                                );
                              })),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )),
        ));
  }
}
