import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:moneylover/services/serviceapi.dart';
import 'package:intl/intl.dart';
part 'querydatalastweek_state.dart';

class QuerydatalastweekCubit extends Cubit<QuerydatalastweekState> {
  QuerydatalastweekCubit()
      : super(const QuerydatalastweekState(expensetotalamountlastweek: 0)) {
    getlastweekquery();
  }

  Map<String, dynamic> week = {
    "Monday": 0,
    "Tuesday": 1,
    "Wednesday": 2,
    "Thursday": 3,
    "Friday": 4,
    "Saturday": 5,
    "Sunday": 6,
  };
  Future getlastweekquery() async {
    DateTime dateTime = DateTime.now();
    var dayname = DateFormat('EEEE').format(dateTime);
    int weekstart = week[dayname] + 6;
    int weekend = week[dayname];
    int date = dateTime.day;
    String month = dateTime.month.toString();
    int year = dateTime.year;
    int finaldatestart = 0;
    String finalmonth = '';
    int finaldateend = 0;
    DateTime endee;
    DateTime startdate;

    if (month == '1') {
      switch (date) {
        case 1:
          finaldatestart = 31 - weekstart - 0;
          finaldateend = 31 - weekend;
          startdate = DateTime.parse(
              "${(year - 1).toString()}-12-${finaldatestart.toString()}");
          endee = DateTime.parse(
              "${(year - 1).toString()}-12-${finaldateend.toString()}");

          break;
        case 2:
          finaldatestart = 31 - (weekstart - 1);
          finaldateend = date - (weekend + 1);
          startdate = DateTime.parse(
              "${(year - 1).toString()}-12-${finaldatestart.toString()}");
          endee = DateTime.parse(
              "${year.toString()}-0$month-0${finaldateend.toString()}");

          break;
        case 3:
          finaldatestart = 31 - (weekstart - 2);
          finaldateend = date - (weekend + 1);
          startdate = DateTime.parse(
              "${(year - 1).toString()}-12-${finaldatestart.toString()}");
          endee = DateTime.parse(
              "${year.toString()}-0$month-0${finaldateend.toString()}");

          break;
        case 4:
          finaldatestart = 31 - (weekstart - 3);
          finaldateend = date - (weekend + 1);
          startdate = DateTime.parse(
              "${(year - 1).toString()}-12-${finaldatestart.toString()}");
          endee = DateTime.parse(
              "${year.toString()}-0$month-0${finaldateend.toString()}");

          break;
        case 5:
          finaldatestart = 31 - (weekstart - 4);
          finaldateend = date - (weekend + 1);
          startdate = DateTime.parse(
              "${(year - 1).toString()}-12-${finaldatestart.toString()}");
          endee = DateTime.parse(
              "${year.toString()}-0$month-0${finaldateend.toString()}");

          break;
        case 6:
          finaldatestart = 31 - (weekstart - 5);
          finaldateend = date - (weekend + 1);
          startdate = DateTime.parse(
              "${(year - 1).toString()}-12-${finaldatestart.toString()}");
          endee = DateTime.parse(
              "${year.toString()}-0$month-0${finaldateend.toString()}");

          break;

        default:
          finaldatestart = date - (weekstart - 1);
          finaldateend = date - (weekend + 1);
          startdate = DateTime.parse(
              "${year.toString()}-$month-${finaldatestart.toString()}");
          endee = DateTime.parse(
              "${year.toString()}-0$month-0${finaldateend.toString()}");
      }

      var finalstart = Timestamp.fromDate(startdate);
      var finalend = Timestamp.fromDate(endee);

      log("Week$startdate");
      log(endee.toString());

      FirebaseFirestore.instance
          .collection("transaction")
          .where('date', isGreaterThan: finalstart)
          .where('date', isLessThan: finalend)
          .orderBy('date', descending: true)
          .snapshots()
          .listen((event) async {
        int totalamountexlastweek = 0;
        for (var message in event.docs) {
          var data = await ServiceApi()
              .getspecificcategory(id: message['category_id']);
          if (data['type'] == 'Expense') {
            totalamountexlastweek =
                totalamountexlastweek + message['amount'] as int;
            emit(QuerydatalastweekState(
                expensetotalamountlastweek: totalamountexlastweek));
            log('Income');
          } else {
            log('Income query');
          }
        }
      });
    }
  }
}
