import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moneylover/logic/fetchdata/cubit/fetchdata_cubit.dart';
import 'package:moneylover/logic/fetchdata2/cubit/fetchrecentdata_cubit.dart';
import 'package:moneylover/logic/querydata/cubit/querydatathismonth_cubit.dart';
import 'package:moneylover/logic/querydatalastmonth/cubit/querydatalastmonth_cubit.dart';
import 'package:moneylover/logic/querydatalastweek/cubit/querydatalastweek_cubit.dart';
import 'package:moneylover/logic/querydatathisweek/cubit/querydatathisweek_cubit.dart';
import 'package:moneylover/refactor/plotchart.dart';
import 'package:moneylover/router/router.gr.dart';
import 'package:moneylover/services/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
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
    final thismonth = context.watch<QuerydatathismonthCubit>().state;
    final lastmonth = context.watch<QuerydatalastmonthCubit>().state;
    final thisweek = context.watch<QuerydatathisweekCubit>().state;
    final lastweek = context.watch<QuerydatalastweekCubit>().state;
    int totalamount = s.amount;
    List cateogoryname = recent.categoyname;
    List cateogoryname2 = recent.categoyname2;
    List transaction = recent.transaction;
    List transaction2 = recent.transaction2;
    List cateogorynameEx = s.top3categoryname;
    List transactionEx = s.top3transaction;
    int expensetotalamount = s.expensetotalamount;
    int thismonthExpenditure = thismonth.expensetotalamountthismonth;
    int lastmonthExpenditure = lastmonth.expensetotalamountlastmonth;
    int thisweekExpenditure = thisweek.expensetotalamountthisweek;
    int lastweekExpenditure = lastweek.expensetotalamountlastweek;

    TabController tabController =
        TabController(length: 2, vsync: this, animationDuration: Duration.zero);

    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 245, 242, 242),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                    right: 10,
                  ),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10),
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
                                                  backgroundColor:
                                                      Colors.green),
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
                                    color: const Color.fromARGB(
                                        255, 171, 169, 169)),
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
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'See all',
                                  style: GoogleFonts.kreon(
                                      fontSize: 16,
                                      color: const Color.fromARGB(
                                          255, 63, 180, 67)),
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
                                            color: Color.fromARGB(
                                                255, 248, 135, 79),
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
                      TextButton(
                        onPressed: () {
                          context.router.push(const TransactionRoute());
                        },
                        child: Text(
                          'See reports',
                          style: GoogleFonts.kreon(
                              fontSize: 17,
                              color: const Color.fromARGB(255, 63, 180, 67)),
                        ),
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
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: 300.0,
                            height: 40.0,
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(83, 229, 228, 228),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: TabBar(
                                  indicatorSize: TabBarIndicatorSize.tab,
                                  indicator: const BubbleTabIndicator(
                                    indicatorRadius: 10,
                                    indicatorHeight: 33.0,
                                    indicatorColor: Colors.white,
                                    tabBarIndicatorSize:
                                        TabBarIndicatorSize.tab,
                                  ),
                                  labelColor: Colors.black,
                                  unselectedLabelColor:
                                      const Color.fromARGB(255, 152, 151, 151),
                                  labelStyle: GoogleFonts.kreon(),
                                  unselectedLabelStyle: GoogleFonts.kreon(),
                                  controller: tabController,
                                  automaticIndicatorColorAdjustment: true,
                                  tabs: const [
                                    Tab(text: "Week"),
                                    Tab(text: "Month")
                                  ]),
                            ),
                          ),
                          SizedBox(
                            width: double.maxFinite,
                            height: 250,
                            child: TabBarView(
                                physics: const NeverScrollableScrollPhysics(),
                                controller: tabController,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 26, right: 26, top: 20),
                                        child: Container(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                currencyformat.format(
                                                    thisweekExpenditure),
                                                style: GoogleFonts.kreon(
                                                    fontSize: 25),
                                              ),
                                              Text(
                                                'Total spend this week',
                                                style: GoogleFonts.kreon(
                                                    fontSize: 15,
                                                    color: Colors.grey),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      BargraphPage(
                                        thismonthamount: thisweekExpenditure,
                                        text1: 'Last Week',
                                        text2: 'This Week',
                                        lastmonthamount: lastweekExpenditure,
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 26, right: 26, top: 20),
                                        child: Container(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                currencyformat.format(
                                                    thismonthExpenditure),
                                                style: GoogleFonts.kreon(
                                                    fontSize: 25),
                                              ),
                                              Text(
                                                'Total spend this month',
                                                style: GoogleFonts.kreon(
                                                    fontSize: 15,
                                                    color: Colors.grey),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      BargraphPage(
                                        thismonthamount: thismonthExpenditure,
                                        text1: 'Last Month',
                                        text2: 'This Month',
                                        lastmonthamount: lastmonthExpenditure,
                                      ),
                                    ],
                                  ),
                                ]),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 26, bottom: 26),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Top Spending',
                                style: GoogleFonts.kreon(fontSize: 18),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: cateogorynameEx.length,
                                itemBuilder: ((context, index) {
                                  double per = (transactionEx[index] /
                                          expensetotalamount) *
                                      100;
                                  switch (cateogorynameEx[index]) {
                                    case 'Transportation':
                                      itemicon = FontAwesomeIcons.train;
                                      avatarcolor = Colors.yellow;
                                      iconcolor = Colors.blue;

                                      break;
                                    case 'Foods and Drink':
                                      itemicon = FontAwesomeIcons.martiniGlass;
                                      avatarcolor = const Color.fromARGB(
                                          255, 95, 208, 249);
                                      iconcolor = Colors.red;

                                      break;
                                    case 'Gas Bill':
                                      itemicon = FontAwesomeIcons.gasPump;
                                      avatarcolor = Colors.red;
                                      iconcolor = Colors.white;

                                      break;

                                    default:
                                      itemicon =
                                          FontAwesomeIcons.fileInvoiceDollar;
                                      avatarcolor = const Color.fromARGB(
                                          255, 209, 54, 244);
                                  }

                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: ListTile(
                                      leading: Stack(
                                        alignment: Alignment.bottomRight,
                                        children: [
                                          CircleAvatar(
                                              backgroundColor: avatarcolor,
                                              radius: 18,
                                              child: FaIcon(itemicon,
                                                  color: iconcolor)),
                                          const CircleAvatar(
                                              backgroundColor: Color.fromARGB(
                                                  255, 43, 56, 96),
                                              radius: 6,
                                              child: FaIcon(
                                                FontAwesomeIcons.wallet,
                                                size: 8,
                                                color: Color.fromARGB(
                                                    255, 248, 135, 79),
                                              )),
                                        ],
                                      ),
                                      title: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            cateogorynameEx[index],
                                            style:
                                                GoogleFonts.kreon(fontSize: 18),
                                          ),
                                          Text(
                                            currencyformat
                                                .format(transactionEx[index]),
                                            style: GoogleFonts.kreon(
                                                fontSize: 15,
                                                color: Colors.grey),
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
                                })),
                          )
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
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 15, bottom: 20),
                            child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: cateogoryname2.length,
                                itemBuilder: ((context, index) {
                                  Timestamp date = transaction2[index]['date'];
                                  var datetime = date.toDate();
                                  var datefinal =
                                      DateFormat.yMMMd().format(datetime);

                                  switch (cateogoryname2[index]) {
                                    case 'Transportation':
                                      itemicon = FontAwesomeIcons.train;
                                      avatarcolor = Colors.yellow;
                                      iconcolor = Colors.blue;

                                      break;
                                    case 'Foods and Drink':
                                      itemicon = FontAwesomeIcons.martiniGlass;
                                      avatarcolor = const Color.fromARGB(
                                          255, 95, 208, 249);
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
                                      iconcolor = const Color.fromARGB(
                                          255, 86, 237, 44);

                                      break;

                                    default:
                                      avatarcolor = const Color.fromARGB(
                                          255, 209, 54, 244);
                                      itemicon =
                                          FontAwesomeIcons.fileInvoiceDollar;
                                  }

                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: ListTile(
                                      leading: Stack(
                                        alignment: Alignment.bottomRight,
                                        children: [
                                          CircleAvatar(
                                              backgroundColor: avatarcolor,
                                              radius: 18,
                                              child: FaIcon(itemicon,
                                                  color: iconcolor)),
                                          const CircleAvatar(
                                              backgroundColor: Color.fromARGB(
                                                  255, 43, 56, 96),
                                              radius: 6,
                                              child: FaIcon(
                                                FontAwesomeIcons.wallet,
                                                size: 8,
                                                color: Color.fromARGB(
                                                    255, 248, 135, 79),
                                              )),
                                        ],
                                      ),
                                      title: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            cateogoryname[index],
                                            style:
                                                GoogleFonts.kreon(fontSize: 18),
                                          ),
                                          Text(
                                            datefinal.toString(),
                                            style: GoogleFonts.kreon(
                                                fontSize: 15,
                                                color: Colors.grey),
                                          )
                                        ],
                                      ),
                                      trailing: Text(
                                        currencyformat.format(
                                            transaction2[index]['amount']),
                                        style: GoogleFonts.kreon(
                                            fontSize: 18,
                                            color: cateogoryname2[index] ==
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
            ),
          ),
        ));
  }
}
