import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:moneylover/services/serviceapi.dart';
part 'querydatathismonth_state.dart';

class QuerydatathismonthCubit extends Cubit<QuerydatathismonthState> {
  QuerydatathismonthCubit()
      : super(const QuerydatathismonthState(
            expensetotalamountlastmonth: 0, expensetotalamountthismonth: 0)) {
    getthismonthquery();
  }
  Future getthismonthquery() async {
    DateTime dateTime = DateTime.now();
    String date = dateTime.day.toString();
    String month = dateTime.month.toString();
    String year = dateTime.year.toString();
    var start = DateTime.parse("$year-$month-01");
    var end = DateTime.parse("$year-$month-31");
    var finalstart = Timestamp.fromDate(start);
    var finalend = Timestamp.fromDate(end);

    FirebaseFirestore.instance
        .collection("transaction")
        .where('date', isGreaterThan: finalstart)
        .where('date', isLessThan: finalend)
        .orderBy('date', descending: true)
        .snapshots()
        .listen((event) async {
      int totalamountexthismonth = 0;
      for (var message in event.docs) {
        var data =
            await ServiceApi().getspecificcategory(id: message['category_id']);
        if (data['type'] == 'Expense') {
          totalamountexthismonth =
              totalamountexthismonth + message['amount'] as int;
          emit(QuerydatathismonthState(
              expensetotalamountlastmonth: 0,
              expensetotalamountthismonth: totalamountexthismonth));
          log('Income');
        } else {
          log('Income query');
        }
      }
    });
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
//         emit(QuerydatathismonthState(
//             amount: 0,
//             transaction: transaction,
//             categoyname: cateogoryname,
//             cateogoryname_ex: const [],
//             transaction_ex: const [],
//             expensetotalamount: 0));
//         cateogoryname.add(data);
//         if (data['type'] == 'Income') {
//           totalamount = totalamount + message['amount'] as int;
//           emit(QuerydatathismonthState(
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
//           emit(QuerydatathismonthState(
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
