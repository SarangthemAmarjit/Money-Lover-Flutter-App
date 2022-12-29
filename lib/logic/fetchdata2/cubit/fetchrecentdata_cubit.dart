import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:moneylover/services/serviceapi.dart';

part 'fetchrecentdata_state.dart';

class FetchrecentdataCubit extends Cubit<FetchrecentdataState> {
  FetchrecentdataCubit()
      : super(const FetchrecentdataState(
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
          .orderBy('date', descending: true)
          .snapshots()
          .listen((event) async {
        List<DocumentSnapshot<Object?>> cateogoryname = [];
        List<QueryDocumentSnapshot<Object?>> transaction = [];

        for (var message in event.docs) {
          transaction.add(message);
          var data = await ServiceApi()
              .getspecificcategory(id: message['category_id']);
          cateogoryname.add(data);

          emit(FetchrecentdataState(
            transaction: transaction,
            categoyname: cateogoryname,
          ));
        }
      });
    } catch (e) {
      return null;
    }
  }
}
