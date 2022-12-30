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
    "Sunday": 0,
    "Monday": 1,
    "Tuesday": 2,
    "Wednesday": 3,
    "Thursday": 4,
    "Friday": 5,
    "Saturday": 6
  };
  Future getthisweekquery() async {
    DateTime dateTime = DateTime.now();
    var dayname = DateFormat('EEEE').format(dateTime);
    int weekstart = week[dayname];
    int weekend = 6 - weekstart;
    int date = dateTime.day;
    String month = dateTime.month.toString();
    String year = dateTime.year.toString();
    var start = DateTime.parse("$year-$month-${(date - weekstart).toString()}");
    var end = DateTime.parse("$year-$month-${(date + weekend).toString()}");
    var finalstart = Timestamp.fromDate(start);
    var finalend = Timestamp.fromDate(end);

    log(dayname);

    FirebaseFirestore.instance
        .collection("transaction")
        .where('date', isGreaterThan: finalstart)
        .where('date', isLessThan: finalend)
        .orderBy('date', descending: true)
        .snapshots()
        .listen((event) async {
      int totalamountexthisweek = 0;
      for (var message in event.docs) {
        var data =
            await ServiceApi().getspecificcategory(id: message['category_id']);
        if (data['type'] == 'Expense') {
          totalamountexthisweek =
              totalamountexthisweek + message['amount'] as int;
          emit(QuerydatathisweekState(
              expensetotalamountthisweek: totalamountexthisweek));
          log('Income');
        } else {
          log('Income query');
        }
      }
    });
  }
}
