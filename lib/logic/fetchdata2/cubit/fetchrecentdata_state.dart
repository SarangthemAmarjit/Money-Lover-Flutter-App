part of 'fetchrecentdata_cubit.dart';

class FetchrecentdataState extends Equatable {
  const FetchrecentdataState({
    required this.datelist,
    required this.grouptransaction,
    required this.categoryidlist,
    required this.transaction2,
    required this.categoyname2,
    required this.transaction,
    required this.categoyname,
  });

  final List transaction;
  final List categoyname;
  final List transaction2;
  final List categoyname2;
  final Map<String, List<dynamic>> grouptransaction;
  final List categoryidlist;
  final List datelist;

  @override
  List get props => [
        transaction,
        categoyname,
        categoyname2,
        transaction2,
        categoryidlist,
        grouptransaction
      ];
}
