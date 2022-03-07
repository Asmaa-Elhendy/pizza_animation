import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
class PriceProvider extends ChangeNotifier{
  double total=15;
  addPrice(){
    total++;
    notifyListeners();
  }

}