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
            cateogoryname_ex: [],
            transaction_ex: [],
            expensetotalamount: 0,
            top3categoryname: [],
            top3transaction: [])) {
    getdatalist();
  }

  Future getdatalist() async {
    try {
      int totalamount = 0;
      int totalamountex = 0;
      List top3transaction = [];
      List top3categoryname = [];
      List cateogorynameEx = [];
      List transactionEx = [];
      List categoryidlist = [];
      FirebaseFirestore.instance
          .collection('transaction')
          .orderBy('amount', descending: true)
          .snapshots()
          .listen((event) async {
        for (var message in event.docs) {
          var data = await ServiceApi()
              .getspecificcategory(id: message['category_id']);
          if (data.data() != null) {
            if (data.data()!['type'] == 'Income') {
              totalamount = totalamount + message['amount'] as int;

              log('Income');
            } else {
              totalamount = totalamount - message['amount'] as int;

              totalamountex = totalamountex + message['amount'] as int;
              if (categoryidlist.contains(message['category_id'])) {
                int index = categoryidlist.indexOf(message['category_id']);
                transactionEx[index] = transactionEx[index] + message['amount'];
              } else {
                cateogorynameEx.add(data['name']);
                categoryidlist.add(message['category_id']);
                transactionEx.add(message['amount']);
              }
            }
          }
        }
        top3transaction = transactionEx.sublist(0, 3);
        top3categoryname = cateogorynameEx.sublist(0, 3);
        log('Expenditure');
        log(cateogorynameEx.toString());
        log(transactionEx.toString());
        emit(FetchdataState(
            amount: totalamount,
            cateogoryname_ex: cateogorynameEx,
            transaction_ex: transactionEx,
            expensetotalamount: totalamountex,
            top3categoryname: top3categoryname,
            top3transaction: top3transaction));
      });
    } catch (e) {
      return null;
    }
  }
}
