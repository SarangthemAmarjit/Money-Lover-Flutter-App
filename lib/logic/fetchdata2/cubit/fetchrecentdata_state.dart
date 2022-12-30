part of 'fetchrecentdata_cubit.dart';

class FetchrecentdataState extends Equatable {
  const FetchrecentdataState({
    required this.transaction,
    required this.categoyname,
  });

  final List transaction;
  final List<DocumentSnapshot<Object?>> categoyname;

  @override
  List get props => [transaction, categoyname];
}
