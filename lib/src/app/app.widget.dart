import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moneylover/core/multiprovider.wrapper.dart';
import 'package:moneylover/router/router.gr.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final _appRouter = AppRouter();
  @override
  Widget build(BuildContext context) {
    return MultiproviderWrapper(
      child: MaterialApp.router(
        routerDelegate: _appRouter.delegate(),
        routeInformationParser: _appRouter.defaultRouteParser(),
        debugShowCheckedModeBanner: false,
        title: 'Moneylover',
        theme: ThemeData(textTheme: GoogleFonts.kreonTextTheme()),
        builder: EasyLoading.init(),
      ),
    );
  }
}
