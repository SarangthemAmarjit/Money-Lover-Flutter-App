import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:moneylover/services/serviceapi.dart';

part 'fetchdata_state.dart';

class FetchdataCubit extends Cubit<FetchdataState> {
  FetchdataCubit()
      : super(const FetchdataState(
            amount: 0,
            categoyname: [],
            transaction: [],
            cateogoryname_ex: [],
            transaction_ex: [],
            expensetotalamount: 0)) {
    getdatalist();
  }

  Future getdatalist() async {
    final CollectionReference expenditurelist =
        FirebaseFirestore.instance.collection('transaction');

    try {
      expenditurelist
          .orderBy('amount', descending: true)
          .snapshots()
          .listen((event) async {
        int totalamount = 0;
        int totalamountex = 0;
        List<DocumentSnapshot<Object?>> cateogoryname = [];
        List<QueryDocumentSnapshot<Object?>> transaction = [];
        List<DocumentSnapshot<Object?>> cateogorynameEx = [];
        List<QueryDocumentSnapshot<Object?>> transactionEx = [];
        for (var message in event.docs) {
          transaction.add(message);
          var data = await ServiceApi()
              .getspecificcategory(id: message['category_id']);
          cateogoryname.add(data);
          emit(FetchdataState(
              amount: 0,
              transaction: transaction,
              categoyname: cateogoryname,
              cateogoryname_ex: const [],
              transaction_ex: const [],
              expensetotalamount: 0));
          cateogoryname.add(data);
          if (data['type'] == 'Income') {
            totalamount = totalamount + message['amount'] as int;
            emit(FetchdataState(
                amount: totalamount,
                categoyname: cateogoryname,
                transaction: transaction,
                cateogoryname_ex: const [],
                transaction_ex: const [],
                expensetotalamount: 0));
            log('Income');
          } else {
            totalamount = totalamount - message['amount'] as int;
            totalamountex = totalamountex + message['amount'] as int;

            cateogorynameEx.add(data);
            transactionEx.add(message);
            log('Expenditure');
            log(totalamount.toString());
            emit(FetchdataState(
                amount: totalamount,
                categoyname: cateogoryname,
                transaction: transaction,
                cateogoryname_ex: cateogorynameEx,
                transaction_ex: transactionEx,
                expensetotalamount: totalamountex));
          }
        }
      });
    } catch (e) {
      return null;
    }
  }
}
