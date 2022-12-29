import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moneylover/logic/Authflow/auth_flow_cubit.dart';
import 'package:moneylover/logic/fetchdata/cubit/fetchdata_cubit.dart';

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
    ], child: child);
  }
}
