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
        )) {
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
        List<DocumentSnapshot<Object?>> cateogoryname = [];
        List<QueryDocumentSnapshot<Object?>> transaction = [];
        for (var message in event.docs) {
          transaction.add(message);
          var data = await ServiceApi()
              .getspecificcategory(id: message['category_id']);
          emit(FetchdataState(
              amount: 0, transaction: transaction, categoyname: cateogoryname));
          cateogoryname.add(data);
          if (data['type'] == 'Income') {
            totalamount = totalamount + message['amount'] as int;
            emit(FetchdataState(
                amount: totalamount,
                categoyname: cateogoryname,
                transaction: transaction));
            log('Income');
          } else {
            totalamount = totalamount - message['amount'] as int;

            log('Expenditure');
            log(totalamount.toString());
            emit(FetchdataState(
                amount: totalamount,
                categoyname: cateogoryname,
                transaction: transaction));
          }
        }
      });
    } catch (e) {
      return null;
    }
  }
}
