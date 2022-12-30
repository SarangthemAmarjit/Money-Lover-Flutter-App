part of 'querydatathisweek_cubit.dart';

class QuerydatathisweekState extends Equatable {
  const QuerydatathisweekState({
    required this.expensetotalamountthisweek,
  });

  final int expensetotalamountthisweek;

  @override
  List get props => [expensetotalamountthisweek];
}
