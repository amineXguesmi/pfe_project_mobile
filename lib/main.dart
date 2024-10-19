import 'package:flutter/material.dart';
import 'package:mobile_app/ui/views/splash_screen.dart';
import 'package:provider/provider.dart';

import 'core/viewmodels/componay_view_model.dart';
import 'core/viewmodels/employee_view_model.dart';
import 'core/viewmodels/offer_view_model.dart';

void main() async {
  //  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(
    ChangeNotifierProvider(
      create: (context) => CompanyViewModel(),
      child: ChangeNotifierProvider(
        create: (context) => EmployeeViewModel(),
        child: ChangeNotifierProvider(
          create: (context) => OfferViewModel(),
          child: const CareerHiveApp(),
        ),
      ),
    ),
  );
}

class CareerHiveApp extends StatelessWidget {
  const CareerHiveApp({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    return MaterialApp(
      //for run
      title: 'CareerHive',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const SplashScreen(),
    );
  }
}
