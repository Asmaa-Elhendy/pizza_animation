import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pizza_animations/view/pizza_order_home.dart';

class Primary extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(gi
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset('assets/64809-pizza-loading.json'),
          InkWell(onTap: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (_)=>PizzaOrderHome()));

          }, child:Text('Go',style: TextStyle(color: Colors.orange,fontWeight: FontWeight.bold,fontSize: 24),))
        ],),
    );
  }
}
