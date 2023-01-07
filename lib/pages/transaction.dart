import 'dart:developer';

import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moneylover/logic/fetchdata/cubit/fetchdata_cubit.dart';
import 'package:moneylover/logic/querydata/cubit/querydatathismonth_cubit.dart';
import 'package:moneylover/logic/querydatalastmonth/cubit/querydatalastmonth_cubit.dart';
import 'package:intl/intl.dart';
import 'package:moneylover/refactor/tabbartransaction.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage>
    with TickerProviderStateMixin {
  var currencyformat =
      NumberFormat.currency(locale: 'en_IN', symbol: '₹', decimalDigits: 0);

  @override
  Widget build(BuildContext context) {
    final s = context.watch<FetchdataCubit>().state;
    final thismonth = context.watch<QuerydatathismonthCubit>().state;
    final lastmonth = context.watch<QuerydatalastmonthCubit>().state;

    int totalamount = s.amount;

    //thismonth transaction
    List categoryidlist = thismonth.categoryidlist;
    List transactionidlist = thismonth.transactionidlist;
    List datelistthismonth = thismonth.datelist;
    int incomeamountthismonth = thismonth.incometotalamountthismonth;
    int expenseamountthismonth = thismonth.expensetotalamountthismonth;
    Map<String, List<dynamic>> grouptransactionthismonth =
        thismonth.grouptransaction;
    //last month transaction
    List datelistlastmonth = lastmonth.datelist;
    int incomeamountlastmonth = lastmonth.incometotalamountlastmonth;
    int expenseamountlastmonth = lastmonth.expensetotalamountlastmonth;
    Map<String, List<dynamic>> grouptransactionlastmonth =
        lastmonth.grouptransaction;
    log(transactionidlist.toString());

    TabController tabController = TabController(
      initialIndex: 10,
      length: 12,
      vsync: this,
    );
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
                            Tab(text: "03/2022"),
                            Tab(text: "04/2022"),
                            Tab(text: "05/2022"),
                            Tab(text: "06/2022"),
                            Tab(text: "07/2022"),
                            Tab(text: "08/2022"),
                            Tab(text: "09/2022"),
                            Tab(text: "10/2022"),
                            Tab(text: "11/2022"),
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
                  TabbartransactionPage(
                    incomeamount: incomeamountlastmonth,
                    expenseamount: expenseamountlastmonth,
                    grouptransaction: grouptransactionlastmonth,
                    datelist: datelistlastmonth,
                    categoryidlist: const [],
                    transactionidlist: const [],
                  ),
                  TabbartransactionPage(
                    incomeamount: incomeamountthismonth,
                    expenseamount: expenseamountthismonth,
                    grouptransaction: grouptransactionthismonth,
                    datelist: datelistthismonth,
                    categoryidlist: categoryidlist,
                    transactionidlist: transactionidlist,
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
