import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:moneylover/services/serviceapi.dart';
part 'fetchrecentdata_state.dart';

class FetchrecentdataCubit extends Cubit<FetchrecentdataState> {
  FetchrecentdataCubit()
      : super(const FetchrecentdataState(
          isloading: true,
          transactionidlist: [],
          categoyname: [],
          transaction: [],
          categoyname2: [],
          transaction2: [],
          categoryidlist: [],
        )) {
    getdatalist();
  }
  DocumentSnapshot? lastdocument;

  bool isMoredata = true;
  int datalimit = 0;

  void getdatalist() async {
    final CollectionReference<Map<String, dynamic>> expenditurelist =
        FirebaseFirestore.instance.collection('transaction');

    try {
      if (isMoredata) {
        if (lastdocument != null) {
          log('last');
          log(datalimit.toString());
          expenditurelist
              .limit(datalimit = datalimit + 12)
              .orderBy('date', descending: true)
              .snapshots()
              .listen((event) async {
            List transaction2 = [];
            List cateogoryname2 = [];
            List datelist = [];
            List categoryidlist = [];
            List transactionidlist = [];
            List cateogoryname = [];
            List transaction = [];

            for (var message in event.docs) {
              var data = await ServiceApi()
                  .getspecificcategory(id: message.data()['category_id']);
              if (data.data() != null) {
                transaction.add(message.data());
                cateogoryname.add(data.data()!['name']);
                transactionidlist.add(message.id);
                categoryidlist.add(message['category_id']);
              }
              lastdocument = event.docs.last;
              log('lastdocument${lastdocument!.data().toString()}');
              log(event.docs.length.toString());
              if (event.docs.length < datalimit) {
                log('item is lesss than $datalimit');
                isMoredata = false;
              }
            }

            transaction2 = transaction.sublist(0, 3);
            cateogoryname2 = cateogoryname.sublist(0, 3);
            emit(FetchrecentdataState(
              transaction: transaction,
              categoyname: cateogoryname,
              categoyname2: cateogoryname2,
              transaction2: transaction2,
              categoryidlist: categoryidlist,
              transactionidlist: transactionidlist,
              isloading: isMoredata,
            ));
          });
        } else {
          log('Initial');
          expenditurelist
              .limit(datalimit = datalimit + 12)
              .orderBy('date', descending: true)
              .snapshots()
              .listen((event) async {
            List transaction2 = [];
            List cateogoryname2 = [];
            List datelist = [];
            List categoryidlist = [];
            List transactionidlist = [];
            List cateogoryname = [];
            List transaction = [];

            for (var message in event.docs) {
              var data = await ServiceApi()
                  .getspecificcategory(id: message.data()['category_id']);
              if (data.data() != null) {
                transaction.add(message.data());
                cateogoryname.add(data.data()!['name']);
                transactionidlist.add(message.id);
                categoryidlist.add(message['category_id']);
              }
              lastdocument = event.docs.last;
              log('lastdocument${lastdocument!.data().toString()}');
              log(event.docs.length.toString());
              if (event.docs.length < 12) {
                log('item is lesss than 12');
                isMoredata = false;
              }
            }

            transaction2 = transaction.sublist(0, 3);
            cateogoryname2 = cateogoryname.sublist(0, 3);
            emit(FetchrecentdataState(
              transaction: transaction,
              categoyname: cateogoryname,
              categoyname2: cateogoryname2,
              transaction2: transaction2,
              categoryidlist: categoryidlist,
              transactionidlist: transactionidlist,
              isloading: isMoredata,
            ));
          });
        }
      } else {
        log('No More Data');
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
