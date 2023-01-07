import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:moneylover/services/serviceapi.dart';
import 'package:intl/intl.dart';
part 'querydatathisweek_state.dart';

class QuerydatathisweekCubit extends Cubit<QuerydatathisweekState> {
  QuerydatathisweekCubit()
      : super(const QuerydatathisweekState(expensetotalamountthisweek: 0)) {
    getthisweekquery();
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
  Future getthisweekquery() async {
    DateTime dateTime = DateTime.now();
    var dayname = DateFormat('EEEE').format(dateTime);
    int weekstart = week[dayname];
    int weekend = 6 - weekstart;
    int date = dateTime.day;
    String month = dateTime.month.toString();
    int year = dateTime.year;

    int finaldatestart = 0;
    String finalmonth = '';
    int finaldateend = 0;
    DateTime endee;
    DateTime startdate;
    log(date.toString());
    log(month.toString());
    log(year.toString());

    if (month == '1') {
      switch (date) {
        case 1:
          log('case 1');
          finaldatestart = 31 - (weekstart - 1);
          finaldateend = date - weekend;

          startdate = DateTime.parse(
              "${(year - 1).toString()}-12-${finaldatestart.toString()}");

          endee = DateTime.parse(
              "${year.toString()}-0$month-0${finaldateend.toString()}");
          log(endee.toString());

          break;
        case 2:
          finaldatestart = date - weekstart;
          finaldateend = date + weekend;
          startdate = DateTime.parse(
              "${year.toString()}-0$month-0${finaldatestart.toString()}");
          endee = DateTime.parse(
              "${year.toString()}-0$month-0${finaldateend.toString()}");

          break;
        case 3:
          finaldatestart = date - weekstart;
          finaldateend = date + weekend;
          startdate = DateTime.parse(
              "${year.toString()}-0$month-0${finaldatestart.toString()}");
          endee = DateTime.parse(
              "${year.toString()}-0$month-0${finaldateend.toString()}");

          break;
        case 4:
          finaldatestart = date - weekstart;
          finaldateend = date + weekend;
          startdate = DateTime.parse(
              "${year.toString()}-0$month-0${finaldatestart.toString()}");
          endee = DateTime.parse(
              "${year.toString()}-0$month-0${finaldateend.toString()}");

          break;
        case 5:
          finaldatestart = date - weekstart;
          finaldateend = date + weekend;
          startdate = DateTime.parse(
              "${year.toString()}-0$month-0${finaldatestart.toString()}");
          endee = DateTime.parse(
              "${year.toString()}-0$month-0${finaldateend.toString()}");

          break;
        case 6:
          finaldatestart = date - weekstart;
          finaldateend = date + weekend;
          startdate = DateTime.parse(
              "${year.toString()}-0$month-0${finaldatestart.toString()}");
          endee = DateTime.parse(
              "${year.toString()}-0$month-0${finaldateend.toString()}");

          break;

        default:
          finaldatestart = date - weekstart;
          finaldateend = date + weekend;
          startdate = DateTime.parse(
              "${year.toString()}-0$month-0${finaldatestart.toString()}");
          endee = DateTime.parse(
              "${year.toString()}-0$month-0${finaldateend.toString()}");
      }

      var finalstart = Timestamp.fromDate(startdate);
      var finalend = Timestamp.fromDate(endee);

      log("Start$finalstart");
      log(finalend.toString());

      FirebaseFirestore.instance
          .collection("transaction")
          .where('date', isGreaterThan: finalstart)
          .where('date', isLessThan: finalend)
          .orderBy('date', descending: true)
          .snapshots()
          .listen((event) async {
        int totalamountexthisweek = 0;
        for (var message in event.docs) {
          var data = await ServiceApi()
              .getspecificcategory(id: message['category_id']);
          if (data.data() != null) {
            if (data.data()!['type'] == 'Expense') {
              totalamountexthisweek =
                  totalamountexthisweek + message['amount'] as int;
              emit(QuerydatathisweekState(
                  expensetotalamountthisweek: totalamountexthisweek));
              log('Income');
            } else {
              log('Income query');
            }
          }
        }
      });
    }
  }
}
