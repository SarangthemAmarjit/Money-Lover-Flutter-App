part of 'querydatalastweek_cubit.dart';

class QuerydatalastweekState extends Equatable {
  const QuerydatalastweekState({
    required this.expensetotalamountlastweek,
  });

  final int expensetotalamountlastweek;

  @override
  List get props => [expensetotalamountlastweek];
}
