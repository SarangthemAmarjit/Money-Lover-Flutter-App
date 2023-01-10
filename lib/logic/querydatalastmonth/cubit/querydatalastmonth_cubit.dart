import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:moneylover/services/serviceapi.dart';
import "package:collection/collection.dart";
part 'querydatalastmonth_state.dart';

class QuerydatalastmonthCubit extends Cubit<QuerydatalastmonthState> {
  QuerydatalastmonthCubit()
      : super(const QuerydatalastmonthState(
            expensetotalamountlastmonth: 0,
            incometotalamountlastmonth: 0,
            transaction: [],
            categoyname: [],
            grouptransaction: {},
            categoryidlist: [],
            datelist: [])) {
    getlastmonthquery();
  }

  Future getlastmonthquery() async {
    DateTime dateTime = DateTime.now();
    String date = dateTime.day.toString();
    int month = dateTime.month;

    int year = dateTime.year;
    if (month == 1) {
      log('last month');
      int lastday = DateTime(dateTime.year, 01, 0).day;
      var start = DateTime.parse("${(year - 1).toString()}-12-01");
      var end =
          DateTime.parse("${(year - 1).toString()}-12-${lastday.toString()}");
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
        int totalamountexLastmonth = 0;
        int incomeamountexlastmonth = 0;
        List transactionidlist = [];
        for (var message in event.docs) {
          var data = await ServiceApi()
              .getspecificcategory(id: message.data()['category_id']);
          if (data.data() != null) {
            if (data.data()!['type'] == 'Expense') {
              totalamountexLastmonth =
                  totalamountexLastmonth + message.data()['amount'] as int;

              log('Expense');
            } else {
              incomeamountexlastmonth =
                  incomeamountexlastmonth + message.data()['amount'] as int;

              log('Income query');
            }
            transaction.add(message.data());
            cateogoryname.add(data.data()!['name']);
            transactionidlist.add(message.id);
            categoryidlist.add(message['category_id']);
          }
        }

        int i;
        int j;

        for (j = 0; j < transaction.length; j++) {
          for (i = 0; i < transactionidlist.length; i++) {
            transaction[j]['transaction_id'] = transactionidlist[i];
            j++;
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
        emit(QuerydatalastmonthState(
          transaction: transaction,
          categoyname: cateogoryname,
          categoryidlist: categoryidlist,
          grouptransaction: grouptransaction,
          datelist: datelist,
          expensetotalamountlastmonth: totalamountexLastmonth,
          incometotalamountlastmonth: incomeamountexlastmonth,
        ));
      });
    }
  }
}
