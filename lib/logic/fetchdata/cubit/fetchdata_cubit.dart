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
      FirebaseFirestore.instance
          .collection('transaction')
          .orderBy('amount', descending: true)
          .snapshots()
          .listen((event) async {
        int totalamount = 0;
        int totalamountex = 0;

        List cateogorynameEx = [];
        List<int> transactionEx = [];
        List categoryidlist = [];
        for (var message in event.docs) {
          await ServiceApi()
              .getspecificcategory(id: message.data()['category_id'])
              .then((value) {
            if (value['type'] == 'Income') {
              totalamount = totalamount + message['amount'] as int;

              log('Income');
            } else {
              totalamount = totalamount - message['amount'] as int;

              totalamountex = totalamountex + message['amount'] as int;
              if (categoryidlist.contains(message['category_id'])) {
                int index = categoryidlist.indexOf(message['category_id']);
                transactionEx[index] =
                    transactionEx[index] + message['amount'] as int;
              } else {
                cateogorynameEx.add(value['name']);
                categoryidlist.add(message['category_id']);
                transactionEx.add(message['amount']);
              }
            }
          }).catchError(onError);
        }
        transactionEx.sort((b, a) => a.compareTo(b));
        List top3transaction = transactionEx.sublist(0, 3);
        List top3categoryname = cateogorynameEx.sublist(0, 3);

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
      log(e.toString());
    }
  }
}
