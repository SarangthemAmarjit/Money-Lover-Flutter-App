import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moneylover/logic/Authflow/auth_flow_cubit.dart';
import 'package:moneylover/logic/fetchdata/cubit/fetchdata_cubit.dart';
import 'package:moneylover/logic/fetchdata2/cubit/fetchrecentdata_cubit.dart';
import 'package:moneylover/logic/querydata/cubit/querydatathismonth_cubit.dart';
import 'package:moneylover/logic/querydatalastmonth/cubit/querydatalastmonth_cubit.dart';
import 'package:moneylover/logic/querydatalastweek/cubit/querydatalastweek_cubit.dart';
import 'package:moneylover/logic/querydatathisweek/cubit/querydatathisweek_cubit.dart';

class MultiproviderWrapper extends StatelessWidget {
  final Widget child;
  const MultiproviderWrapper({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
        create: (context) => AuthFlowCubit(),
      ),
      BlocProvider(
        create: (context) => FetchdataCubit(),
      ),
      BlocProvider(
        create: (context) => FetchrecentdataCubit(),
      ),
      BlocProvider(
        create: (context) => QuerydatathismonthCubit(),
      ),
      BlocProvider(
        create: (context) => QuerydatalastmonthCubit(),
      ),
      BlocProvider(
        create: (context) => QuerydatathisweekCubit(),
      ),
      BlocProvider(
        create: (context) => QuerydatalastweekCubit(),
      ),
    ], child: child);
  }
}
