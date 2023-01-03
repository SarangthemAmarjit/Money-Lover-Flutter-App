import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:moneylover/services/serviceapi.dart';
import "package:collection/collection.dart";
part 'querydatathismonth_state.dart';

class QuerydatathismonthCubit extends Cubit<QuerydatathismonthState> {
  QuerydatathismonthCubit()
      : super(const QuerydatathismonthState(
            expensetotalamountthismonth: 0,
            incometotalamountlastmonth: 0,
            categoryidlist: [],
            categoyname: [],
            datelist: [],
            grouptransaction: {},
            transaction: [])) {
    getthismonthquery();
  }
  Future getthismonthquery() async {
    DateTime dateTime = DateTime.now();
    String date = dateTime.day.toString();
    int month = dateTime.month;
    int lastday = DateTime(dateTime.year, month, 0).day;
    String year = dateTime.year.toString();
    var start = DateTime.parse("$year-0${month.toString()}-01");
    var end =
        DateTime.parse("$year-0${month.toString()}-${lastday.toString()}");
    var finalstart = Timestamp.fromDate(start);
    var finalend = Timestamp.fromDate(end);

    log(start.toString());
    log(end.toString());
    FirebaseFirestore.instance
        .collection("transaction")
        .where('date', isGreaterThanOrEqualTo: finalstart)
        .where('date', isLessThanOrEqualTo: finalend)
        .orderBy('date', descending: true)
        .snapshots()
        .listen((event) async {
      List cateogoryname = [];
      List transaction = [];

      List datelist = [];
      List categoryidlist = [];
      int totalamountexthismonth = 0;
      int incomeamountexthismonth = 0;
      for (var message in event.docs) {
        var data = await ServiceApi()
            .getspecificcategory(id: message.data()['category_id']);
        if (data.data() != null) {
          if (data.data()!['type'] == 'Expense') {
            totalamountexthismonth =
                totalamountexthismonth + message.data()['amount'] as int;

            log('Expense');
          } else {
            incomeamountexthismonth =
                incomeamountexthismonth + message.data()['amount'] as int;

            log('Income query');
          }
          transaction.add(message.data());
          cateogoryname.add(data.data()!['name']);

          categoryidlist.add(message['category_id']);
        }
      }
      var result = Map.fromIterables(categoryidlist, cateogoryname);
      log('this month${transaction.toString()}');
      for (Map element in transaction) {
        element.update('category_id', (value) => result[value]);
      }

      var grouptransaction = groupBy(transaction, ((m) {
        Timestamp date = m['date'];

        if (date.toDate().month.toString().length < 2 &&
            date.toDate().day.toString().length < 2) {
          String date2 =
              '${date.toDate().year}-0${date.toDate().month}-0${date.toDate().day}';
          return date2;
        } else if (date.toDate().month.toString().length < 2) {
          String date2 =
              '${date.toDate().year}-0${date.toDate().month}-${date.toDate().day}';
          return date2;
        } else if (date.toDate().day.toString().length < 2) {
          String date2 =
              '${date.toDate().year}-${date.toDate().month}-0${date.toDate().day}';
          return date2;
        } else {
          String date2 =
              '${date.toDate().year}-${date.toDate().month}-${date.toDate().day}';
          return date2;
        }
      }));
      log(grouptransaction.toString());

      grouptransaction.forEach((key, value) {
        datelist.add(key);
      });
      emit(QuerydatathismonthState(
        transaction: transaction,
        categoyname: cateogoryname,
        categoryidlist: categoryidlist,
        grouptransaction: grouptransaction,
        datelist: datelist,
        expensetotalamountthismonth: totalamountexthismonth,
        incometotalamountlastmonth: incomeamountexthismonth,
      ));
    });
  }
}
