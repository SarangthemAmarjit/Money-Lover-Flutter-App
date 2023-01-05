part of 'querydatalastmonth_cubit.dart';

class QuerydatalastmonthState extends Equatable {
  const QuerydatalastmonthState({
    required this.expensetotalamountlastmonth,
    required this.incometotalamountlastmonth,
    required this.transaction,
    required this.categoyname,
    required this.grouptransaction,
    required this.categoryidlist,
    required this.datelist,
  });

  final int expensetotalamountlastmonth;
  final int incometotalamountlastmonth;
  final List transaction;
  final List categoyname;

  final Map<String, List<dynamic>> grouptransaction;
  final List categoryidlist;
  final List datelist;

  @override
  List get props => [
        expensetotalamountlastmonth,
        incometotalamountlastmonth,
        transaction,
        categoyname,
        grouptransaction,
        categoryidlist,
        datelist
      ];
}
