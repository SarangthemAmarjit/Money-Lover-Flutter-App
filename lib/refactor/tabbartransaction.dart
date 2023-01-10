import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:moneylover/pages/detailpage.dart';

class TabbartransactionPage extends StatelessWidget {
  final int incomeamount;
  final int expenseamount;
  final Map<String, List<dynamic>> grouptransaction;
  final List datelist;
  final List categoryidlist;

  TabbartransactionPage({
    super.key,
    required this.incomeamount,
    required this.expenseamount,
    required this.grouptransaction,
    required this.datelist,
    required this.categoryidlist,
  });

  var currencyformat =
      NumberFormat.currency(locale: 'en_IN', symbol: '', decimalDigits: 0);

  IconData? itemicon;
  Color? avatarcolor;
  Color? iconcolor;

  final now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                  style: GoogleFonts.kreon(fontSize: 18, color: Colors.grey),
                ),
                Text(
                  currencyformat.format(incomeamount),
                  style: GoogleFonts.kreon(
                      fontSize: 18,
                      color: const Color.fromARGB(255, 74, 198, 239)),
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
                  style: GoogleFonts.kreon(fontSize: 18, color: Colors.grey),
                ),
                Text(
                  currencyformat.format(expenseamount),
                  style: GoogleFonts.kreon(fontSize: 18, color: Colors.red),
                )
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 220, right: 20, top: 5, bottom: 5),
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
                  currencyformat.format(incomeamount - expenseamount),
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
                final aDate = DateTime(
                    checkingdate.year, checkingdate.month, checkingdate.day);

                var datetime = DateTime.parse(date);
                var monthyear = DateFormat.yMMMM().format(datetime);
                var day = DateFormat('EEEE').format(datetime);
                var dateonly = DateFormat.d().format(datetime);
                final today = DateTime(now.year, now.month, now.day);
                final yesterday = DateTime(now.year, now.month, now.day - 1);
                final tomorrow = DateTime(now.year, now.month, now.day + 1);
                if (aDate == today) {
                  day = 'Today';
                } else if (aDate == yesterday) {
                  day = 'Yesterday';
                } else if (aDate == tomorrow) {
                  day = 'Tomorrow';
                } else {}
                int totalamountthismonth = incomeamount + expenseamount;
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
                  padding: const EdgeInsets.symmetric(horizontal: 5),
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
                              padding: const EdgeInsets.only(right: 14),
                              child: Text(
                                dateonly.length < 2 ? '0$dateonly' : dateonly,
                                style: GoogleFonts.kreon(fontSize: 38),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(day),
                                Text(
                                  monthyear.toString(),
                                  style: GoogleFonts.kreon(color: Colors.grey),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Container(
                          color: Colors.grey,
                          height: 1,
                          width: MediaQuery.of(context).size.width,
                        ),
                      ),
                      ListView.builder(
                          physics: const ClampingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: grouptransaction[date]!.length,
                          itemBuilder: ((context, index2) {
                            switch (grouptransaction[date]![index2]
                                ['category_id']) {
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
                                itemicon = FontAwesomeIcons.fileInvoiceDollar;
                            }
                            return InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: ((context) => DetailPage(
                                        amount: grouptransaction[date]![index2]
                                            ['amount'],
                                        date: datetime,
                                        categoryname:
                                            grouptransaction[date]![index2]
                                                ['category_id'],
                                        categoryid: categoryidlist[index2],
                                        transactionid:
                                            grouptransaction[date]![index2]
                                                ['transaction_id']))));
                              },
                              child: ListTile(
                                leading: Stack(
                                  alignment: Alignment.bottomRight,
                                  children: [
                                    CircleAvatar(
                                        backgroundColor: avatarcolor,
                                        radius: 18,
                                        child:
                                            FaIcon(itemicon, color: iconcolor)),
                                    const CircleAvatar(
                                        backgroundColor:
                                            Color.fromARGB(255, 43, 56, 96),
                                        radius: 6,
                                        child: FaIcon(
                                          FontAwesomeIcons.wallet,
                                          size: 8,
                                          color:
                                              Color.fromARGB(255, 248, 135, 79),
                                        )),
                                  ],
                                ),
                                trailing: Text(
                                  currencyformat.format(
                                      grouptransaction[date]![index2]
                                          ['amount']),
                                  style: GoogleFonts.kreon(
                                      fontSize: 18,
                                      color: grouptransaction[date]![index2]
                                                  ['category_id'] ==
                                              'Salary'
                                          ? const Color.fromARGB(
                                              255, 74, 198, 239)
                                          : Colors.red),
                                ),
                                title: Text(grouptransaction[date]![index2]
                                        ['category_id']
                                    .toString()),
                              ),
                            );
                          }))
                    ],
                  ),
                );
              })),
        ],
      ),
    );
  }
}
