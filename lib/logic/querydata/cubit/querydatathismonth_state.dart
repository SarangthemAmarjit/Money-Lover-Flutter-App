part of 'querydatathismonth_cubit.dart';

class QuerydatathismonthState extends Equatable {
  const QuerydatathismonthState({
    required this.transactionidlist,
    required this.transaction,
    required this.categoyname,
    required this.grouptransaction,
    required this.categoryidlist,
    required this.datelist,
    required this.expensetotalamountthismonth,
    required this.incometotalamountthismonth,
  });

  final int expensetotalamountthismonth;
  final int incometotalamountthismonth;
  final List transaction;
  final List categoyname;
  final List transactionidlist;
  final Map<String, List<dynamic>> grouptransaction;
  final List categoryidlist;
  final List datelist;

  @override
  List get props => [expensetotalamountthismonth, incometotalamountthismonth];
}
