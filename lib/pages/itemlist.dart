import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moneylover/refactor/snackbar.dart';
import 'package:moneylover/refactor/type.dart';
import 'package:moneylover/services/serviceapi.dart';

class SelectionPage extends StatefulWidget {
  const SelectionPage({super.key});

  @override
  State<SelectionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<SelectionPage> {
  final CollectionReference categorylist =
      FirebaseFirestore.instance.collection('category');
  TextEditingController categorynamecontroller = TextEditingController();
  TextEditingController addcategorynamecontroller = TextEditingController();
  List number = [1, 2, 3, 4, 5, 6, 7, 8];
  type categorytype = type.Income;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black, // <-- SEE HERE
        ),
        backgroundColor: Colors.white,
        actions: [
          Flexible(
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 60, top: 7, bottom: 7, right: 12),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: const Color.fromARGB(255, 246, 242, 242),
                ),
                height: 30,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: TextFormField(
                      cursorHeight: 22,
                      decoration: InputDecoration.collapsed(
                        hintText: 'Type a category\'s name',
                        hintStyle: GoogleFonts.kreon(),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 245, 243, 243),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 20,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Container(
                  child: Column(
                    children: [
                      StreamBuilder(
                        stream: categorylist.snapshots(),
                        builder: (context, streamsnapshot) {
                          if (streamsnapshot.hasData) {
                            return ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                itemCount: streamsnapshot.data!.docs.length,
                                shrinkWrap: true,
                                itemBuilder: ((context, index) {
                                  final DocumentSnapshot documentSnapshot =
                                      streamsnapshot.data!.docs[index];

                                  return InkWell(
                                    onTap: () {
                                      Navigator.pop(
                                        context,
                                        streamsnapshot.data!.docs[index].id
                                            .toString(),
                                      );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(bottom: 2),
                                      child: ListTile(
                                        tileColor: Colors.white,
                                        title: Text(
                                          documentSnapshot['name'],
                                          style:
                                              GoogleFonts.kreon(fontSize: 18),
                                        ),
                                      ),
                                    ),
                                  );
                                }));
                          } else {
                            return Container(
                              child: const CircularProgressIndicator(),
                            );
                          }
                        },
                      ),
                      InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            builder: (BuildContext context) {
                              return StatefulBuilder(
                                  builder: ((context, setState) {
                                return Scaffold(
                                  backgroundColor:
                                      const Color.fromARGB(26, 250, 250, 250),
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
                                          padding: const EdgeInsets.symmetric(
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
                                              padding: const EdgeInsets.only(
                                                  left: 15),
                                              child: Text(
                                                'New Category',
                                                style: GoogleFonts.kreon(
                                                    fontSize: 20),
                                              ),
                                            ),
                                            trailing: InkWell(
                                              onTap: () async {
                                                await ServiceApi().addcategoryitem(
                                                    name:
                                                        addcategorynamecontroller
                                                            .text,
                                                    type: categorytype.name);
                                                Navigator.pop(context);
                                                CustomSnackBar(
                                                    context,
                                                    const Text(
                                                        'Added Category Successfully'),
                                                    Colors.green);
                                                addcategorynamecontroller
                                                    .clear();

                                                categorytype = type.Income;
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
                                          width:
                                              MediaQuery.of(context).size.width,
                                          color: Colors.white,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
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
                                                                .only(left: 20),
                                                        child: TextFormField(
                                                          controller:
                                                              addcategorynamecontroller,
                                                          decoration: InputDecoration(
                                                              hintStyle: GoogleFonts
                                                                  .kreon(
                                                                      color: Colors
                                                                          .black26,
                                                                      fontSize:
                                                                          18),
                                                              hintText:
                                                                  'Enter Category Name'),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 20,
                                                    right: 20,
                                                    bottom: 10),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      'Type :',
                                                      style: GoogleFonts.kreon(
                                                          fontSize: 18),
                                                    ),
                                                    Flexible(
                                                      child: RadioListTile(
                                                          toggleable: true,
                                                          title: Text(
                                                            "Income",
                                                            style: GoogleFonts
                                                                .kreon(),
                                                          ),
                                                          value: type.Income,
                                                          groupValue:
                                                              categorytype,
                                                          onChanged: (value) {
                                                            setState(() {
                                                              categorytype =
                                                                  value as type;
                                                            });
                                                          }),
                                                    ),
                                                    Flexible(
                                                      child: RadioListTile(
                                                          title: Text(
                                                            "Expense",
                                                            style: GoogleFonts
                                                                .kreon(),
                                                          ),
                                                          value: type.Expense,
                                                          groupValue:
                                                              categorytype,
                                                          onChanged: (value) {
                                                            setState(() {
                                                              categorytype =
                                                                  value as type;
                                                            });
                                                          }),
                                                    ),
                                                  ],
                                                ),
                                              ),
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
                        child: ListTile(
                          tileColor: Colors.white,
                          leading: const CircleAvatar(
                              backgroundColor: Color.fromARGB(255, 90, 203, 94),
                              radius: 10,
                              child: FaIcon(
                                FontAwesomeIcons.plus,
                                size: 12,
                                color: Colors.white,
                              )),
                          title: Text(
                            'NEW CATEGORY',
                            style: GoogleFonts.kreon(
                              fontSize: 14,
                              color: const Color.fromARGB(255, 90, 203, 94),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
