part of 'fetchdata_cubit.dart';

class FetchdataState extends Equatable {
  const FetchdataState(
      {required this.transaction,
      required this.categoyname,
      required this.amount});

  final int amount;
  final List<QueryDocumentSnapshot<Object?>> transaction;
  final List<DocumentSnapshot<Object?>> categoyname;

  @override
  List get props => [amount, transaction, categoyname];
}
