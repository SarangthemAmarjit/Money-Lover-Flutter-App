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

// Future getdatalist() async {
//   final CollectionReference expenditurelist =
//       FirebaseFirestore.instance.collection('transaction');

//   try {
//     expenditurelist
//         .orderBy('amount', descending: true)
//         .snapshots()
//         .listen((event) async {
//       int totalamount = 0;
//       int totalamountex = 0;
//       List<DocumentSnapshot<Object?>> cateogoryname = [];
//       List<QueryDocumentSnapshot<Object?>> transaction = [];
//       List<DocumentSnapshot<Object?>> cateogorynameEx = [];
//       List<QueryDocumentSnapshot<Object?>> transactionEx = [];
//       for (var message in event.docs) {
//         transaction.add(message);
//         var data =
//             await ServiceApi().getspecificcategory(id: message['category_id']);
//         cateogoryname.add(data);
//         emit(QuerydatalastmonthState(
//             amount: 0,
//             transaction: transaction,
//             categoyname: cateogoryname,
//             cateogoryname_ex: const [],
//             transaction_ex: const [],
//             expensetotalamount: 0));
//         cateogoryname.add(data);
//         if (data['type'] == 'Income') {
//           totalamount = totalamount + message['amount'] as int;
//           emit(QuerydatalastmonthState(
//               amount: totalamount,
//               categoyname: cateogoryname,
//               transaction: transaction,
//               cateogoryname_ex: const [],
//               transaction_ex: const [],
//               expensetotalamount: 0));
//           log('Income');
//         } else {
//           totalamount = totalamount - message['amount'] as int;
//           totalamountex = totalamountex + message['amount'] as int;

//           cateogorynameEx.add(data);
//           transactionEx.add(message);
//           log('Expenditure');
//           log(totalamount.toString());
//           emit(QuerydatalastmonthState(
//               amount: totalamount,
//               categoyname: cateogoryname,
//               transaction: transaction,
//               cateogoryname_ex: cateogorynameEx,
//               transaction_ex: transactionEx,
//               expensetotalamount: totalamountex));
//         }
//       }
//     });
//   } catch (e) {
//     return null;
//   }
// }
