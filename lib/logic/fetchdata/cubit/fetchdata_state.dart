part of 'fetchdata_cubit.dart';

class FetchdataState extends Equatable {
  const FetchdataState(
      {required this.top3transaction,
      required this.top3categoryname,
      required this.expensetotalamount,
      required this.cateogoryname_ex,
      required this.transaction_ex,
      required this.amount});

  final int amount;
  final int expensetotalamount;
  final List top3transaction;
  final List top3categoryname;
  final List cateogoryname_ex;
  final List transaction_ex;

  @override
  List get props => [amount, cateogoryname_ex, transaction_ex];
}
