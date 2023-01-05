import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:moneylover/refactor/snackbar.dart';
import 'package:moneylover/router/router.gr.dart';
import 'package:moneylover/services/serviceapi.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({Key? key}) : super(key: key);

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  // List itm = [
  //   const HomePage(),
  //   const TransactionPage(),
  //   const Text('Add Amount'),
  //   const Text('Planning'),
  //   const Text('Account'),
  // ];
  int currentselectedindex = 0;

  void _ontap(int index) {
    setState(() {
      currentselectedindex = index;
    });
  }

  DateTime onlyDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  var format = DateFormat("dd-MM-yyyy");
  DateTime? initialdate = DateTime(2010);
  Timestamp? datetime2;

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
                hintText: 'Today',
                hintStyle:
                    GoogleFonts.kreon(color: Colors.black26, fontSize: 18),
              ),
              format: format,
              onShowPicker: (context, currentValue) {
                return showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
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

  String resultvalue = 'Select Category';
  String categoryid = '';

  TextEditingController amountcontroller = TextEditingController();
  TextEditingController notecontroller = TextEditingController();

  Future<void> _navigateAndDisplaySelection(BuildContext context) async {
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
        resultvalue = item['name'];
        categoryid = result.toString();
      });
    }

    // ScaffoldMessenger.of(context)
    //   ..removeCurrentSnackBar()
    //   ..showSnackBar(SnackBar(content: Text('$result')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AutoTabsRouter(
      routes: const [
        GroupTab1Router(),
        GroupTab2Router(),
        GroupTab3Router(),
        GroupTab4Router(),
        GroupTab5Router(),
      ],
      duration: const Duration(milliseconds: 400),
      builder: (context, child, animation) {
        final tabsRouter = context.tabsRouter;
        return Scaffold(
          body: FadeTransition(
            opacity: animation,
            child: child,
          ),
          bottomNavigationBar: buildBottomNavigationBar(context, tabsRouter),
        );
      },
    )

        // itm.elementAt(currentselectedindex),
        );
  }

  BottomNavigationBar buildBottomNavigationBar(
      BuildContext context, TabsRouter tabsRouter) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'Home'),
        BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.moneyCheckDollar),
            label: 'Transactions'),
        BottomNavigationBarItem(
            icon: CircleAvatar(
              backgroundColor: Colors.green,
              child: FaIcon(
                FontAwesomeIcons.plus,
                color: Colors.white,
              ),
            ),
            label: ''),
        BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.clipboardList), label: 'Planning'),
        BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.userLarge,
              size: 22,
            ),
            label: 'Account'),
      ],
      type: BottomNavigationBarType.fixed,
      iconSize: 25,
      currentIndex: tabsRouter.activeIndex,
      elevation: 5,
      selectedFontSize: 17,
      selectedItemColor: const Color.fromARGB(255, 7, 7, 7),
      showSelectedLabels: true,
      selectedIconTheme: const IconThemeData(color: Colors.black),
      unselectedIconTheme:
          const IconThemeData(color: Color.fromARGB(115, 123, 121, 121)),
      onTap: ((value) {
        if (value == 2) {
          showModalBottomSheet<void>(
            isScrollControlled: true,
            context: context,
            builder: (BuildContext context) {
              return Scaffold(
                backgroundColor: const Color.fromARGB(26, 250, 250, 250),
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      const SizedBox(
                        height: 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: ListTile(
                          tileColor: Colors.white,
                          leading: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                                setState(() {
                                  resultvalue = 'Select Category';
                                });
                              },
                              child: const Icon(
                                Icons.close,
                                size: 30,
                                color: Colors.black,
                              )),
                          title: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Text(
                              'Add Transaction',
                              style: GoogleFonts.kreon(fontSize: 20),
                            ),
                          ),
                          trailing: TextButton(
                            onPressed: () async {
                              if (amountcontroller.text.isEmpty ||
                                  categoryid.isEmpty) {
                                context.router.pop();
                                CustomSnackBar(
                                    context,
                                    Text(
                                      'All Fields Are Mandatory',
                                      style: GoogleFonts.kreon(),
                                    ),
                                    Colors.red);
                              } else {
                                await ServiceApi().addtransaction(
                                    amount: int.parse(amountcontroller.text),
                                    categoryid: categoryid,
                                    notes: notecontroller.text,
                                    date: datetime2 ??
                                        Timestamp.fromDate(DateTime.now()));
                                Navigator.pop(context);
                                amountcontroller.clear();
                                CustomSnackBar(
                                    context,
                                    const Text(
                                        'Added Transaction Successfully'),
                                    Colors.green);
                                setState(() {
                                  resultvalue = 'Select Category';

                                  categoryid = '';
                                });
                              }
                            },
                            child: Text(
                              'SAVE',
                              style: GoogleFonts.kreon(fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        height: 300,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.white,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, bottom: 10),
                              child: Row(
                                children: [
                                  const FaIcon(
                                    FontAwesomeIcons.sackDollar,
                                    size: 30,
                                  ),
                                  Flexible(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        controller: amountcontroller,
                                        decoration: InputDecoration(
                                            hintStyle: GoogleFonts.kreon(
                                                color: Colors.black26,
                                                fontSize: 18),
                                            hintText: 'Enter Your Amount'),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, bottom: 10),
                              child: Row(
                                children: [
                                  const FaIcon(
                                    FontAwesomeIcons.circleQuestion,
                                    size: 30,
                                  ),
                                  Flexible(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: TextFormField(
                                        showCursor: false,
                                        onTap: () {
                                          _navigateAndDisplaySelection(context);
                                        },
                                        decoration: InputDecoration(
                                            hintStyle: GoogleFonts.kreon(
                                                color: resultvalue ==
                                                        'Select Category'
                                                    ? Colors.black26
                                                    : Colors.black,
                                                fontSize: 18),
                                            hintText: resultvalue),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, bottom: 10),
                              child: Row(
                                children: [
                                  const FaIcon(
                                    FontAwesomeIcons.noteSticky,
                                    size: 30,
                                  ),
                                  Flexible(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: TextFormField(
                                        controller: notecontroller,
                                        decoration: InputDecoration(
                                            hintStyle: GoogleFonts.kreon(
                                                color: Colors.black26,
                                                fontSize: 18),
                                            hintText: 'Write Note'),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                children: [
                                  const FaIcon(
                                    FontAwesomeIcons.calendar,
                                    size: 30,
                                  ),
                                  Flexible(
                                    child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20),
                                        child: _dataofbirth()),
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
            },
          );
        } else {
          tabsRouter.setActiveIndex(value);
        }
      }),
      selectedLabelStyle: GoogleFonts.kreon(),
    );
  }
}
