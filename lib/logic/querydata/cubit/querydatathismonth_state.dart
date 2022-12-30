part of 'querydatathismonth_cubit.dart';

class QuerydatathismonthState extends Equatable {
  const QuerydatathismonthState({
    required this.expensetotalamountthismonth,
    required this.expensetotalamountlastmonth,
  });

  final int expensetotalamountthismonth;
  final int expensetotalamountlastmonth;

  @override
  List get props => [expensetotalamountthismonth, expensetotalamountlastmonth];
}
