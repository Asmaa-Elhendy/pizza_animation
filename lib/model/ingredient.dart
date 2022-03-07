import 'package:flutter/cupertino.dart';

class Ingredient{
  String image;
  List<Offset> positions;
  Ingredient(this.image,this.positions);

   compare(Ingredient ingredient)=>ingredient.image==image;
}

List<Ingredient> ingredients=[
  Ingredient("assets/images/part1/chili.png",const
  [Offset(0.2,0.2),Offset(0.6,0.2),Offset(0.4, 0.25),Offset(0.5, 0.3),Offset(0.4, 0.65)]
  ),
  Ingredient("assets/images/part1/garlic.png",const [Offset(0.2,0.35),Offset(0.65,0.35),Offset(0.3, 0.23),Offset(0.5, 0.2), Offset(0.3, 0.5)]),
  Ingredient("assets/images/part1/olive.png", const [Offset(0.25,0.5),Offset(0.65,0.6),Offset(0.2, 0.3),Offset(0.4, 0.2),Offset(0.2, 0.6)]),
  Ingredient("assets/images/part1/onion.png",const[Offset(0.2,0.65),Offset(0.65,0.3),Offset(0.25, 0.25),Offset(0.45, 0.35),Offset(0.4, 0.65)]),
  Ingredient("assets/images/part1/pea.png", const [Offset(0.2,0.35),Offset(0.65,0.35),Offset(0.3, 0.23),Offset(0.5, 0.2),Offset(0.3, 0.5)]),
  // اخر اتنين لا
  Ingredient("assets/images/part1/pickle.png",const  [Offset(0.2,0.2),Offset(0.6,0.2),Offset(0.4, 0.25),Offset(0.5, 0.3),Offset(0.4, 0.65)]),
  Ingredient("assets/images/part1/potato.png",const[Offset(0.2,0.2),Offset(0.6,0.2),Offset(0.4, 0.25),Offset(0.5, 0.3),Offset(0.4, 0.65)]),
];