import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moneylover/logic/fetchdata2/cubit/fetchrecentdata_cubit.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moneylover/pages/detailpage.dart';

class AllrecentPage extends StatefulWidget {
  const AllrecentPage({super.key});

  @override
  State<AllrecentPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<AllrecentPage> {
  var currencyformat =
      NumberFormat.currency(locale: 'en_IN', symbol: '₹', decimalDigits: 0);

  IconData? itemicon;

  Color? avatarcolor;

  Color? iconcolor;

  ScrollController controller = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final recent = context.watch<FetchrecentdataCubit>().state;
    List cateogoryname = recent.categoyname;
    List cateogoryname2 = recent.categoyname2;
    List transaction = recent.transaction;
    List transaction2 = recent.transaction2;
    List transactionidlist = recent.transactionidlist;
    bool ismoreloading = recent.isloading;
    controller.addListener(() {
      if (controller.position.pixels == controller.position.maxScrollExtent ||
          controller.position.pixels == controller.position.minScrollExtent) {
        BlocProvider.of<FetchrecentdataCubit>(context).getdatalist();
        log('reach buttom');
      }
    });
    return Scaffold(
        body: SafeArea(
            child: Column(children: [
      Expanded(
        flex: 1,
        child: SizedBox(
          child: Padding(
            padding: const EdgeInsets.only(left: 26, right: 26, top: 50),
            child: Text(
              'All Recent transactions',
              style: GoogleFonts.kreon(
                  fontSize: 17,
                  color: const Color.fromARGB(255, 160, 158, 158)),
            ),
          ),
        ),
      ),
      Expanded(
        flex: 9,
        child: SingleChildScrollView(
          controller: controller,
          physics: const BouncingScrollPhysics(),
          child: SizedBox(
            child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 15, bottom: 20),
                          child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: cateogoryname.length,
                              itemBuilder: ((context, index) {
                                Timestamp date = transaction[index]['date'];
                                var datetime = date.toDate();
                                var datefinal =
                                    DateFormat.yMMMd().format(datetime);

                                switch (cateogoryname[index]) {
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
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10, bottom: 20),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => DetailPage(
                                                  amount: transaction[index]
                                                      ['amount'],
                                                  date: datetime,
                                                  categoryname:
                                                      cateogoryname[index],
                                                  categoryid: transaction[index]
                                                      ['category_id'],
                                                  transactionid:
                                                      transactionidlist[index]),
                                              settings: const RouteSettings(
                                                  name: "/detail")));
                                    },
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
                                            transaction[index]['amount']),
                                        style: GoogleFonts.kreon(
                                            fontSize: 18,
                                            color:
                                                cateogoryname[index] == 'Salary'
                                                    ? const Color.fromARGB(
                                                        255, 72, 215, 247)
                                                    : Colors.red),
                                      ),
                                    ),
                                  ),
                                );
                              })),
                        ),
                        Center(
                          child: ismoreloading
                              ? const CircularProgressIndicator()
                              : const SizedBox(),
                        )
                      ],
                    ))),
          ),
        ),
      ),
    ])));
  }
}
