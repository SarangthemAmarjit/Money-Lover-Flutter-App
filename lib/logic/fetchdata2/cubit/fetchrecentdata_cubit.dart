import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:moneylover/services/serviceapi.dart';
part 'fetchrecentdata_state.dart';

class FetchrecentdataCubit extends Cubit<FetchrecentdataState> {
  FetchrecentdataCubit()
      : super(const FetchrecentdataState(
          transactionidlist: [],
          categoyname: [],
          transaction: [],
          categoyname2: [],
          transaction2: [],
          categoryidlist: [],
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
        List transactionidlist = [];

        for (var message in event.docs) {
          var data = await ServiceApi()
              .getspecificcategory(id: message.data()['category_id']);
          if (data.data() != null) {
            transaction.add(message.data());
            cateogoryname.add(data.data()!['name']);
            transactionidlist.add(message.id);
            categoryidlist.add(message['category_id']);
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
        ));
      });
    } catch (e) {
      return null;
    }
  }
}
