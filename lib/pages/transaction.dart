import 'dart:developer';

import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moneylover/logic/fetchdata/cubit/fetchdata_cubit.dart';
import 'package:moneylover/logic/fetchdata2/cubit/fetchrecentdata_cubit.dart';
import 'package:moneylover/logic/querydata/cubit/querydatathismonth_cubit.dart';
import 'package:moneylover/logic/querydatalastmonth/cubit/querydatalastmonth_cubit.dart';
import 'package:intl/intl.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage>
    with TickerProviderStateMixin {
  var currencyformat =
      NumberFormat.currency(locale: 'en_IN', symbol: '₹', decimalDigits: 0);

  IconData? itemicon;
  Color? avatarcolor;
  Color? iconcolor;

  final now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final s = context.watch<FetchdataCubit>().state;
    final recent = context.watch<FetchrecentdataCubit>().state;
    final thismonth = context.watch<QuerydatathismonthCubit>().state;
    final lastmonth = context.watch<QuerydatalastmonthCubit>().state;

    int totalamount = s.amount;
    List cateogoryname = recent.categoyname;
    List categoryidlist = recent.categoryidlist;
    List cateogoryname2 = recent.categoyname2;
    List transaction = recent.transaction;
    List datelist = thismonth.datelist;
    int incomeamountthismonth = thismonth.incometotalamountlastmonth;
    int expenseamountthismonth = thismonth.expensetotalamountthismonth;
    Map<String, List<dynamic>> grouptransaction = thismonth.grouptransaction;
    List transaction2 = recent.transaction2;
    List cateogorynameEx = s.cateogoryname_ex;
    List transactionEx = s.transaction_ex;
    int expensetotalamount = s.expensetotalamount;

    int lastmonthExpenditure = lastmonth.expensetotalamountlastmonth;
    log(grouptransaction.toString());

    TabController tabController = TabController(
        initialIndex: 10,
        length: 12,
        vsync: this,
        animationDuration: Duration.zero);
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          children: [
            Expanded(
              flex: 30,
              child: SizedBox(
                child: Column(children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Balance',
                    style: GoogleFonts.kreon(fontSize: 18, color: Colors.grey),
                  ),
                  Text(
                    currencyformat.format(totalamount),
                    style: GoogleFonts.kreon(fontSize: 20),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                ]),
              ),
            ),
            Expanded(
              flex: 10,
              child: SizedBox(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50.0,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(83, 229, 228, 228),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: TabBar(
                          onTap: (value) {},
                          physics: const BouncingScrollPhysics(),
                          isScrollable: true,
                          indicatorSize: TabBarIndicatorSize.tab,
                          indicator: const BubbleTabIndicator(
                            indicatorRadius: 10,
                            indicatorHeight: 33.0,
                            indicatorColor: Colors.white,
                            tabBarIndicatorSize: TabBarIndicatorSize.tab,
                          ),
                          labelColor: Colors.black,
                          unselectedLabelColor:
                              const Color.fromARGB(255, 152, 151, 151),
                          labelStyle: GoogleFonts.kreon(fontSize: 16),
                          unselectedLabelStyle: GoogleFonts.kreon(),
                          controller: tabController,
                          automaticIndicatorColorAdjustment: true,
                          tabs: const [
                            Tab(text: "Week"),
                            Tab(text: "Month"),
                            Tab(text: "Week"),
                            Tab(text: "Month"),
                            Tab(text: "Week"),
                            Tab(text: "Month"),
                            Tab(text: "Week"),
                            Tab(text: "Month"),
                            Tab(text: "Week"),
                            Tab(text: "LAST MONTH"),
                            Tab(text: "THIS MONTH"),
                            Tab(text: "FUTURE")
                          ]),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 120,
              child: SizedBox(
                width: double.maxFinite,
                height: 600,
                child: TabBarView(controller: tabController, children: [
                  const Text('fdf'),
                  const Text('fdf'),
                  const Text('fdf'),
                  const Text('fdf'),
                  const Text('fdf'),
                  const Text('fdf'),
                  const Text('fdf'),
                  const Text('fdf'),
                  const Text('fdf'),
                  const Text('fdf'),
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Inflow',
                                style: GoogleFonts.kreon(
                                    fontSize: 18, color: Colors.grey),
                              ),
                              Text(
                                currencyformat.format(incomeamountthismonth),
                                style: GoogleFonts.kreon(
                                    fontSize: 18,
                                    color: const Color.fromARGB(
                                        255, 74, 198, 239)),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Outflow',
                                style: GoogleFonts.kreon(
                                    fontSize: 18, color: Colors.grey),
                              ),
                              Text(
                                currencyformat.format(expenseamountthismonth),
                                style: GoogleFonts.kreon(
                                    fontSize: 18, color: Colors.red),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 220, right: 20, top: 5, bottom: 5),
                          child: Container(
                            color: const Color.fromARGB(255, 193, 192, 192),
                            height: 1,
                            width: MediaQuery.of(context).size.width,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                currencyformat.format(incomeamountthismonth -
                                    expenseamountthismonth),
                                style: GoogleFonts.kreon(fontSize: 18),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: const Color.fromARGB(255, 236, 246, 236)),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 14, right: 14, top: 10, bottom: 10),
                            child: Text(
                              'View report for this period',
                              style: GoogleFonts.kreon(
                                  color: const Color.fromARGB(255, 75, 174, 78),
                                  fontSize: 16),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          color: const Color.fromARGB(255, 243, 241, 241),
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                        ),
                        ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: datelist.length,
                            shrinkWrap: true,
                            itemBuilder: ((context, index1) {
                              String date = datelist[index1];
                              DateTime checkingdate = DateTime.parse(date);
                              final aDate = DateTime(checkingdate.year,
                                  checkingdate.month, checkingdate.day);

                              var datetime = DateTime.parse(date);
                              var monthyear =
                                  DateFormat.yMMMM().format(datetime);
                              var day = DateFormat('EEEE').format(datetime);
                              var dateonly = DateFormat.d().format(datetime);
                              final today =
                                  DateTime(now.year, now.month, now.day);
                              final yesterday =
                                  DateTime(now.year, now.month, now.day - 1);
                              final tomorrow =
                                  DateTime(now.year, now.month, now.day + 1);
                              if (aDate == today) {
                                day = 'Today';
                              } else if (aDate == yesterday) {
                                day = 'Yesterday';
                              } else if (aDate == tomorrow) {
                                day = 'Tomorrow';
                              } else {}
                              int totalamountthismonth = incomeamountthismonth +
                                  expenseamountthismonth;
                              log(totalamountthismonth.toString());
                              int total = 0;
                              for (var element in grouptransaction[date]!) {
                                if (element['category_id'] == 'Salary') {
                                  total = total + element['amount'] as int;
                                } else {
                                  total = total - element['amount'] as int;
                                }
                              }

                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: Column(
                                  children: [
                                    ListTile(
                                      trailing: Text(
                                        currencyformat.format(total),
                                        style: GoogleFonts.kreon(fontSize: 18),
                                      ),
                                      tileColor: Colors.white,
                                      title: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 14),
                                            child: Text(
                                              dateonly.length < 2
                                                  ? '0$dateonly'
                                                  : dateonly,
                                              style: GoogleFonts.kreon(
                                                  fontSize: 38),
                                            ),
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(day),
                                              Text(
                                                monthyear.toString(),
                                                style: GoogleFonts.kreon(
                                                    color: Colors.grey),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      child: Container(
                                        color: Colors.grey,
                                        height: 1,
                                        width:
                                            MediaQuery.of(context).size.width,
                                      ),
                                    ),
                                    ListView.builder(
                                        physics: const ClampingScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount:
                                            grouptransaction[date]!.length,
                                        itemBuilder: ((context, index2) {
                                          switch (
                                              grouptransaction[date]![index2]
                                                  ['category_id']) {
                                            case 'Transportation':
                                              itemicon = FontAwesomeIcons.train;
                                              avatarcolor = Colors.yellow;
                                              iconcolor = Colors.blue;

                                              break;
                                            case 'Foods and Drink':
                                              itemicon =
                                                  FontAwesomeIcons.martiniGlass;
                                              avatarcolor =
                                                  const Color.fromARGB(
                                                      255, 95, 208, 249);
                                              iconcolor = Colors.red;

                                              break;
                                            case 'Gas Bill':
                                              itemicon =
                                                  FontAwesomeIcons.gasPump;
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
                                              avatarcolor =
                                                  const Color.fromARGB(
                                                      255, 209, 54, 244);
                                              itemicon = FontAwesomeIcons
                                                  .fileInvoiceDollar;
                                          }
                                          return ListTile(
                                            leading: Stack(
                                              alignment: Alignment.bottomRight,
                                              children: [
                                                CircleAvatar(
                                                    backgroundColor:
                                                        avatarcolor,
                                                    radius: 18,
                                                    child: FaIcon(itemicon,
                                                        color: iconcolor)),
                                                const CircleAvatar(
                                                    backgroundColor:
                                                        Color.fromARGB(
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
                                            trailing: Text(
                                              currencyformat.format(
                                                  grouptransaction[date]![
                                                      index2]['amount']),
                                              style: GoogleFonts.kreon(
                                                  fontSize: 18,
                                                  color: grouptransaction[
                                                                  date]![index2]
                                                              ['category_id'] ==
                                                          'Salary'
                                                      ? const Color.fromARGB(
                                                          255, 74, 198, 239)
                                                      : Colors.red),
                                            ),
                                            title: Text(
                                                grouptransaction[date]![index2]
                                                        ['category_id']
                                                    .toString()),
                                          );
                                        }))
                                  ],
                                ),
                              );
                            })),
                      ],
                    ),
                  ),
                  const Text('fdf'),
                ]),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
