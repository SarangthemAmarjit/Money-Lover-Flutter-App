part of 'fetchdata_cubit.dart';

class FetchdataState extends Equatable {
  const FetchdataState(
      {required this.expensetotalamount,
      required this.cateogoryname_ex,
      required this.transaction_ex,
      required this.transaction,
      required this.categoyname,
      required this.amount});

  final int amount;
  final int expensetotalamount;
  final List<QueryDocumentSnapshot<Object?>> transaction;
  final List<DocumentSnapshot<Object?>> categoyname;
  final List<DocumentSnapshot<Object?>> cateogoryname_ex;
  final List<QueryDocumentSnapshot<Object?>> transaction_ex;

  @override
  List get props => [amount, transaction, categoyname];
}
