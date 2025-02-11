import 'package:employeedata/bloc/employee_bloc.dart';
import 'package:employeedata/bloc/employee_event.dart';
import 'package:employeedata/screens/employee_list_screen.dart';
import 'package:employeedata/utils/appColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: AppColors.mainDarkColor, // Change to your desired color
    statusBarIconBrightness: Brightness.light, // White icons
  ));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          EmployeeBloc()..add(LoadEmployees()), // Load data at start
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Employee Management',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: AppColors.mainColor,
          appBarTheme: AppBarTheme(
            backgroundColor: AppColors.mainColor, // AppBar color
            foregroundColor: AppColors.mainWhiteColor, // Text & icon color
            elevation: 2, // Shadow effect

          ),
          useMaterial3: true,
        ),
        // theme: ThemeData(
        //   // This is the theme of your application.
        //   //
        //   // TRY THIS: Try running your application with "flutter run". You'll see
        //   // the application has a purple toolbar. Then, without quitting the app,
        //   // try changing the seedColor in the colorScheme below to Colors.green
        //   // and then invoke "hot reload" (save your changes or press the "hot
        //   // reload" button in a Flutter-supported IDE, or press "r" if you used
        //   // the command line to start the app).
        //   //
        //   // Notice that the counter didn't reset back to zero; the application
        //   // state is not lost during the reload. To reset the state, use hot
        //   // restart instead.
        //   //
        //   // This works for code too, not just values: Most code changes can be
        //   // tested with just a hot reload.
        //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        //   useMaterial3: true,
        // ),
        home: EmployeeListScreen(),
      ),
    );
  }
}
