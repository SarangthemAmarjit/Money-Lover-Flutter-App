part of 'querydatalastweek_cubit.dart';

class QuerydatalastweekState extends Equatable {
  const QuerydatalastweekState({
    required this.expensetotalamountthisweek,
  });

  final int expensetotalamountthisweek;

  @override
  List get props => [expensetotalamountthisweek];
}
