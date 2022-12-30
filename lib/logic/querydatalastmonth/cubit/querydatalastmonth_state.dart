part of 'querydatalastmonth_cubit.dart';

class QuerydatalastmonthState extends Equatable {
  const QuerydatalastmonthState({
    required this.expensetotalamountlastmonth,
  });

  final int expensetotalamountlastmonth;

  @override
  List get props => [expensetotalamountlastmonth];
}
