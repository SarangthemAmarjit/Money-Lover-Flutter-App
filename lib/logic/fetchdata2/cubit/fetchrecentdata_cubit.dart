import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:moneylover/services/serviceapi.dart';
import "package:collection/collection.dart";
part 'fetchrecentdata_state.dart';

class FetchrecentdataCubit extends Cubit<FetchrecentdataState> {
  FetchrecentdataCubit()
      : super(const FetchrecentdataState(
          categoyname: [],
          transaction: [],
          categoyname2: [],
          transaction2: [],
          categoryidlist: [],
          grouptransaction: {},
          datelist: [],
        )) {
    getdatalist();
  }

  Future getdatalist() async {
    final CollectionReference<Map<String, dynamic>> expenditurelist =
        FirebaseFirestore.instance.collection('transaction');

    try {
      expenditurelist
          .orderBy('date', descending: true)
          .snapshots()
          .listen((event) async {
        List cateogoryname = [];
        List transaction = [];
        List transaction2 = [];
        List cateogoryname2 = [];
        List datelist = [];
        List categoryidlist = [];

        for (var message in event.docs) {
          var data = await ServiceApi()
              .getspecificcategory(id: message.data()['category_id']);
          if (data.data() != null) {
            transaction.add(message.data());
            cateogoryname.add(data.data()!['name']);

            categoryidlist.add(message['category_id']);
          }
        }
        var result = Map.fromIterables(categoryidlist, cateogoryname);
        log(result.toString());
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

        grouptransaction.forEach((key, value) {
          datelist.add(key);
        });

        transaction2 = transaction.sublist(0, 3);
        cateogoryname2 = cateogoryname.sublist(0, 3);
        emit(FetchrecentdataState(
          transaction: transaction,
          categoyname: cateogoryname,
          categoyname2: cateogoryname2,
          transaction2: transaction2,
          categoryidlist: categoryidlist,
          grouptransaction: grouptransaction,
          datelist: datelist,
        ));
      });
    } catch (e) {
      return null;
    }
  }
}
