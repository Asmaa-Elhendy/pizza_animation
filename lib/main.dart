import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pizza_animations/controller/price_provider.dart';
import 'package:pizza_animations/view/pizza_order_home.dart';
import 'package:pizza_animations/view/primary.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context)=>PriceProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(

          primarySwatch: Colors.blue,
        ),
        home:Primary()


      ),
    );
  }
}

