import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pizza_animations/model/ingredient.dart';

class PizzaIngredients extends StatelessWidget {
  const PizzaIngredients({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
        itemCount: ingredients.length,
        itemBuilder: (context,int index){
          return IngredientItem(ingredient: ingredients[index]);
        });
  }
}

class IngredientItem extends StatelessWidget {
Ingredient ingredient;
IngredientItem({required this.ingredient});

  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;
  final   child=Padding(
      padding: EdgeInsets.symmetric(horizontal: width*.018),
  child:Container(
      padding: EdgeInsets.all(width*.009),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xFFF5EED3),
      ),child: Container(
        width: width*.12
        ,height: height*.1,
        child: Image.asset("${ingredient.image}",))),
    );
    return  Draggable<Ingredient>(
          feedback: child,
          data: ingredient,
          child: child);
  }

}
