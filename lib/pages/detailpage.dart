import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:moneylover/refactor/snackbar.dart';
import 'package:moneylover/router/router.gr.dart';
import 'package:moneylover/services/serviceapi.dart';

class DetailPage extends StatefulWidget {
  final String transactionid;
  final String categoryid;
  final String categoryname;
  final int amount;
  final DateTime date;
  const DetailPage(
      {super.key,
      required this.categoryname,
      required this.amount,
      required this.date,
      required this.transactionid,
      required this.categoryid});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  IconData? itemicon;

  Color? avatarcolor;

  Color? iconcolor;
  String resultvalue = 'Select Category';
  String categoryid = '';

  var currencyformat =
      NumberFormat.currency(locale: 'en_IN', symbol: '₹', decimalDigits: 0);

  TextEditingController amountcontroller = TextEditingController();

  TextEditingController notecontroller = TextEditingController();

  var format = DateFormat("dd-MM-yyyy");
  DateTime? initialdate = DateTime(2010);
  Timestamp? datetime2;
  String datetimefordisplay = 'Today';

  Future<void> _navigateAndDisplaySelection(
      BuildContext context, void Function(void Function()) setState) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final result = await context.router.push(const SelectionRoute());

    // When a BuildContext is used from a StatefulWidget, the mounted property
    // must be checked after an asynchronous gap.
    if (!mounted) return;

    // After the Selection Screen returns a result, hide any previous snackbars
    // and show the new result.
    if (result != null) {
      var item = await ServiceApi().getspecificcategory(id: result.toString());
      setState(() {
        resultvalue = item.data()!['name'];
        categoryid = result.toString();
      });
      log(resultvalue);
    }

    // ScaffoldMessenger.of(context)
    //   ..removeCurrentSnackBar()
    //   ..showSnackBar(SnackBar(content: Text('$result')));
  }

  Widget _dataofbirth() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(top: 10),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: DateTimeField(
              decoration: InputDecoration(
                hintText: datetimefordisplay,
                hintStyle: GoogleFonts.kreon(color: Colors.black, fontSize: 18),
              ),
              format: format,
              onShowPicker: (context, currentValue) {
                return showDatePicker(
                        context: context,
                        initialDate: widget.date,
                        firstDate: DateTime(2010),
                        lastDate: DateTime(2025),
                        helpText: "SELECT DATE OF BIRTH",
                        cancelText: "CANCEL",
                        confirmText: "OK",
                        fieldHintText: "DATE/MONTH/YEAR",
                        fieldLabelText: "ENTER YOUR DATE OF BIRTH",
                        errorFormatText: "Enter a Valid Date",
                        errorInvalidText: "Date Out of Range")
                    .then((value) {
                  datetime2 = Timestamp.fromDate(value!);

                  log(value.toString());

                  return value;
                });
              },
            ),
          ),
        ]);
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.categoryname) {
      case 'Transportation':
        itemicon = FontAwesomeIcons.train;
        avatarcolor = Colors.yellow;
        iconcolor = Colors.blue;

        break;
      case 'Foods and Drink':
        itemicon = FontAwesomeIcons.martiniGlass;
        avatarcolor = const Color.fromARGB(255, 95, 208, 249);
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
        iconcolor = const Color.fromARGB(255, 86, 237, 44);

        break;

      default:
        avatarcolor = const Color.fromARGB(255, 209, 54, 244);
        itemicon = FontAwesomeIcons.fileInvoiceDollar;
    }
    var day = DateFormat('EEEE').format(widget.date);

    return Scaffold(
      body: SafeArea(
        child: Card(
          child: SizedBox(
            height: 270,
            child: Column(
              children: [
                ListTile(
                  tileColor: Colors.white,

                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.close,
                            size: 30,
                            color: Colors.black,
                          )),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                amountcontroller.text =
                                    widget.amount.toString();
                                resultvalue = widget.categoryname;
                                datetimefordisplay =
                                    '${widget.date.day}-${widget.date.month}-${widget.date.year}';
                                categoryid = widget.categoryid;
                              });
                              log(resultvalue);
                              showModalBottomSheet<void>(
                                isScrollControlled: true,
                                context: context,
                                builder: (BuildContext context2) {
                                  return StatefulBuilder(
                                      builder: ((context, setState) {
                                    return Scaffold(
                                      backgroundColor: const Color.fromARGB(
                                          26, 250, 250, 250),
                                      body: Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            const SizedBox(
                                              height: 40,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              child: ListTile(
                                                tileColor: Colors.white,
                                                leading: InkWell(
                                                    onTap: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Icon(
                                                      Icons.close,
                                                      size: 30,
                                                      color: Colors.black,
                                                    )),
                                                title: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15),
                                                  child: Text(
                                                    'Edit Transaction',
                                                    style: GoogleFonts.kreon(
                                                        fontSize: 20),
                                                  ),
                                                ),
                                                trailing: TextButton(
                                                  onPressed: () async {
                                                    if (amountcontroller
                                                            .text.isEmpty ||
                                                        categoryid.isEmpty) {
                                                      context.router.pop();
                                                      CustomSnackBar(
                                                          context,
                                                          Text(
                                                            'All Fields Are Mandatory',
                                                            style: GoogleFonts
                                                                .kreon(),
                                                          ),
                                                          Colors.red);
                                                    } else {
                                                      await ServiceApi()
                                                          .updatetransaction(
                                                              amount: int.parse(
                                                                  amountcontroller
                                                                      .text),
                                                              categoryid:
                                                                  categoryid,
                                                              notes:
                                                                  notecontroller
                                                                      .text,
                                                              date: Timestamp
                                                                  .fromDate(
                                                                      widget
                                                                          .date),
                                                              id: widget
                                                                  .transactionid);
                                                      Navigator.pop(context2);
                                                      Navigator.pop(context);
                                                      amountcontroller.clear();
                                                      CustomSnackBar(
                                                          context,
                                                          const Text(
                                                              'Updated Transaction Successfully'),
                                                          Colors.green);
                                                      setState(() {
                                                        resultvalue =
                                                            'Select Category';

                                                        categoryid = '';
                                                      });
                                                    }
                                                  },
                                                  child: Text(
                                                    'SAVE',
                                                    style: GoogleFonts.kreon(
                                                        fontSize: 18),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 30,
                                            ),
                                            Container(
                                              height: 300,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              color: Colors.white,
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 20,
                                                            right: 20,
                                                            bottom: 10),
                                                    child: Row(
                                                      children: [
                                                        const FaIcon(
                                                          FontAwesomeIcons
                                                              .sackDollar,
                                                          size: 30,
                                                        ),
                                                        Flexible(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 20),
                                                            child:
                                                                TextFormField(
                                                              keyboardType:
                                                                  TextInputType
                                                                      .number,
                                                              controller:
                                                                  amountcontroller,
                                                              decoration: InputDecoration(
                                                                  hintStyle: GoogleFonts.kreon(
                                                                      color: Colors
                                                                          .black26,
                                                                      fontSize:
                                                                          18),
                                                                  hintText:
                                                                      'Enter Your Amount'),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 20,
                                                            right: 20,
                                                            bottom: 10),
                                                    child: Row(
                                                      children: [
                                                        const FaIcon(
                                                          FontAwesomeIcons
                                                              .circleQuestion,
                                                          size: 30,
                                                        ),
                                                        Flexible(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 20),
                                                            child:
                                                                TextFormField(
                                                              showCursor: false,
                                                              onTap: () {
                                                                _navigateAndDisplaySelection(
                                                                    context,
                                                                    setState);
                                                              },
                                                              decoration: InputDecoration(
                                                                  hintStyle: GoogleFonts.kreon(
                                                                      color: resultvalue ==
                                                                              'Select Category'
                                                                          ? Colors
                                                                              .black26
                                                                          : Colors
                                                                              .black,
                                                                      fontSize:
                                                                          18),
                                                                  hintText:
                                                                      resultvalue),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 20,
                                                            right: 20,
                                                            bottom: 10),
                                                    child: Row(
                                                      children: [
                                                        const FaIcon(
                                                          FontAwesomeIcons
                                                              .noteSticky,
                                                          size: 30,
                                                        ),
                                                        Flexible(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 20),
                                                            child:
                                                                TextFormField(
                                                              controller:
                                                                  notecontroller,
                                                              decoration: InputDecoration(
                                                                  hintStyle: GoogleFonts.kreon(
                                                                      color: Colors
                                                                          .black26,
                                                                      fontSize:
                                                                          18),
                                                                  hintText:
                                                                      'Write Note'),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 20),
                                                    child: Row(
                                                      children: [
                                                        const FaIcon(
                                                          FontAwesomeIcons
                                                              .calendar,
                                                          size: 30,
                                                        ),
                                                        Flexible(
                                                          child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 20),
                                                              child:
                                                                  _dataofbirth()),
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  }));
                                },
                              );
                            },
                            child: const Icon(
                              Icons.edit,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(
                            width: 25,
                          ),
                          InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                  anchorPoint: Offset.fromDirection(1),
                                  constraints:
                                      const BoxConstraints(maxHeight: 100),
                                  context: context,
                                  builder: ((context) {
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10, top: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Delete this transaction?',
                                              style: GoogleFonts.kreon(
                                                  fontSize: 20)),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.grey,
                                                    side: const BorderSide(
                                                        color: Colors.red),
                                                  ),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(
                                                    "CANCEL",
                                                    style: GoogleFonts.kreon(),
                                                  )),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10),
                                                child: ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            backgroundColor:
                                                                Colors.green),
                                                    onPressed: () async {
                                                      EasyLoading.show(
                                                          status: 'Deleting..');
                                                      await ServiceApi()
                                                          .deletetransaction(
                                                              id: widget
                                                                  .transactionid)
                                                          .whenComplete(() {
                                                        EasyLoading.dismiss();
                                                        Navigator.pop(context);
                                                        Navigator.pop(context);
                                                      });
                                                    },
                                                    child: Text("YES",
                                                        style: GoogleFonts
                                                            .kreon())),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  }));
                            },
                            child: const Icon(
                              Icons.delete,
                              color: Colors.black,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  // trailing: Row(
                  //   children: const [],
                  // ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 15, right: 15, bottom: 30),
                  child: Row(
                    children: [
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                              backgroundColor: avatarcolor,
                              radius: 20,
                              child: FaIcon(itemicon, color: iconcolor)),
                          const CircleAvatar(
                              backgroundColor: Color.fromARGB(255, 43, 56, 96),
                              radius: 6,
                              child: FaIcon(
                                FontAwesomeIcons.wallet,
                                size: 8,
                                color: Color.fromARGB(255, 248, 135, 79),
                              )),
                        ],
                      ),
                      const SizedBox(
                        width: 25,
                      ),
                      Text(
                        widget.categoryname,
                        style: GoogleFonts.kreon(
                            fontSize: 27,
                            color: const Color.fromARGB(255, 77, 77, 77)),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 75, right: 15, bottom: 30),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      currencyformat.format(widget.amount),
                      style: GoogleFonts.kreon(
                          fontSize: 25,
                          color: widget.categoryname == 'Salary'
                              ? const Color.fromARGB(255, 74, 198, 239)
                              : Colors.red),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.date_range_sharp,
                        size: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 35,
                          right: 15,
                        ),
                        child: Text(
                          '$day, ${widget.date.day}/${widget.date.month}/${widget.date.year}',
                          style: GoogleFonts.kreon(fontSize: 19),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
