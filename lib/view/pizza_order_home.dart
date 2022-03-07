import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:pizza_animations/controller/price_provider.dart';
import 'package:pizza_animations/model/ingredient.dart';
import 'package:pizza_animations/view/widgets/pizza_ingredients.dart';
import 'package:provider/provider.dart';

class PizzaOrderHome extends StatefulWidget {
  const PizzaOrderHome({Key? key}) : super(key: key);

  @override
  State<PizzaOrderHome> createState() => _PizzaOrderHomeState();
}

class _PizzaOrderHomeState extends State<PizzaOrderHome>{



  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('New Pizza Order',style: TextStyle(color: Colors.brown),),
        elevation: 0,
        backgroundColor: Colors.white,
        actions: [IconButton(onPressed: (){}, icon: const Icon(Icons.shopping_cart_rounded,color: Colors.brown,))],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            bottom: height*.10,
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              elevation: 8,
              child: Column(
                children: [
                Expanded(
                          flex: 8,
                          child: _PizzaDetails()),

                  const Expanded(
                      flex: 2,
                      child: PizzaIngredients())
                ],
              ),
            ),
          ),
          Positioned(
            bottom: height*.09,
            child: const _PizzaButton())
        ],
      ),
    );
  }
}

class _PizzaDetails extends StatefulWidget{
  @override
  State<_PizzaDetails> createState() => _PizzaDetailsState();
}

class _PizzaDetailsState extends State<_PizzaDetails> with SingleTickerProviderStateMixin{
 late List<Ingredient> _ingredientofSelectedPizzaList=[];

 bool issmall=false;
 bool ismediam=false;
 bool islarge=true;
 late AnimationController _animationController;
 late Animation animation;
List<Animation> _animationList=[];
late BoxConstraints _pizzaconstraints;
int selectedindex=0;

void _buildIngredientsAnimations(){
  _animationList.clear();
  _animationList.add(CurvedAnimation(parent: _animationController, curve: Interval(0.0,0.8,curve: Curves.decelerate)));
      _animationList.add(CurvedAnimation(parent: _animationController, curve: Interval(0.2,0.8,curve: Curves.decelerate)));
  _animationList.add(CurvedAnimation(parent: _animationController, curve: Interval(0.4,1.0,curve: Curves.decelerate)));
  _animationList.add(CurvedAnimation(parent: _animationController, curve: Interval(0.1,0.7,curve: Curves.decelerate)));
  _animationList.add(CurvedAnimation(parent: _animationController, curve: Interval(0.3,1.0,curve: Curves.decelerate)));
}

List pizzaimages=["assets/images/part1/pizza-1.png","assets/images/part1/pizza-2.png","assets/images/part1/pizza-5.png","assets/images/part1/pizza-3.png"];
Widget _buildIngredientsWidget(){
  List<Widget> elements =[];
  if(_animationList.isNotEmpty){
    for(int i=0;i<_ingredientofSelectedPizzaList.length;i++){
      Ingredient ingredient =_ingredientofSelectedPizzaList[i];
      final ingredientwidget= Image.asset(ingredient.image, height: 40,);
      for(int j=0;j<ingredient.positions.length;j++){
        final anomation =_animationList[j];
        final position=ingredient.positions[j];
        final positionX=position.dx;
        final positionY=position.dy;
        if(i<_ingredientofSelectedPizzaList.length-1) {
          double fromx = 0.0,
              fromy = 0.0;
          if (j < 1) {
            fromx = _pizzaconstraints.maxWidth * (1 - anomation.value);
          } else if (j < 2) {
            fromx = _pizzaconstraints.maxWidth * (1 - anomation.value);
          } else if (j < 4) {
            fromy = _pizzaconstraints.maxHeight * (1 - anomation.value);
          } else {
            fromy = _pizzaconstraints.maxHeight * (1 - anomation.value);
          }
          if (animation.value > 0) {
            elements.add(Transform(
              transform: Matrix4.identity()
                ..translate(
                    fromx + _pizzaconstraints.maxWidth * positionX,
                    fromy + _pizzaconstraints.maxHeight * positionY)
              , child: ingredientwidget
            ));
          }
        }else{
          elements.add(Transform(
            transform: Matrix4.identity()
              ..translate(
                 _pizzaconstraints.maxWidth * positionX,
                  _pizzaconstraints.maxHeight * positionY)
            , child: ingredientwidget
          ));
        }
      }}
      return Stack(
          children: elements
      );
    }
     return SizedBox.fromSize();
}

 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController=AnimationController(vsync: this,duration: Duration(milliseconds: 900));
  animation=  CurvedAnimation(parent: _animationController, curve: Interval(0.0,0.0,curve: Curves.decelerate));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _animationController.dispose();
  }
 addtolist(Ingredient ingredient){

    _ingredientofSelectedPizzaList.add(ingredient);
    print(_ingredientofSelectedPizzaList);

 }
  @override
  Widget build(BuildContext context) {
   double width=MediaQuery.of(context).size.width;
   double height=MediaQuery.of(context).size.height;
   bool _focused=false;
   PriceProvider priceProvider=Provider.of<PriceProvider>(context,listen: false);
    return Stack(
      children: [
        Column(
          children: [
            Expanded(
              child: DragTarget<Ingredient>(
                onAccept: (ingredient){
                    _focused=false;
                    priceProvider.addPrice();



                  print('on accept');
                },
                onLeave:  (ingredient){
                    _focused=false;

                  print('on leave');
                },
              onWillAccept:  (ingredient){
                  _focused=true;
                  priceProvider.addPrice();

                 addtolist(ingredient!);
                 _buildIngredientsAnimations();
                 _animationController.forward(from: 2);


                print('on will accept');

                for(Ingredient i in _ingredientofSelectedPizzaList){
                  if(i.compare(i)){
                    return false;
                  }
                }
                return true;
              },
                builder: (BuildContext context, List<Object?> candidateData, List<dynamic> rejectedData) {
                  return LayoutBuilder(
                    builder: (BuildContext context, BoxConstraints constraints) {
                      _pizzaconstraints=constraints;
                      return  PageView.builder(
                        onPageChanged: (index){
                        setState(() {
                          selectedindex=index;
                        });
                        },
                          itemCount: pizzaimages.length,
                          itemBuilder: (context,int index){
                        return   pizzatype(pizzaimages[index],constraints,_focused,width*.04);
                      }
                      );
                    }
                  );
                },
              ),
            ),SizedBox(height: height*.009,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Container(height: 18,width: 18,
                child: Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),),color:selectedindex==0?Colors.black:Colors.grey,),
              ),Container(height: 18,width: 18,
                child: Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),),color:selectedindex==1?Colors.black:Colors.grey,),
              ),Container(height: 18,width: 18,
                child: Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),),color:selectedindex==2?Colors.black:Colors.grey,),
              )
         ,Container(height: 18,width: 18,
     child: Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),),color:selectedindex==3?Colors.black:Colors.grey,),
    )
            ],),
            SizedBox(height: height*.01,),
            Consumer<PriceProvider>(
              builder: (context, provider,_){
                return
                  Text('\$ ${priceProvider.total}',style: const TextStyle(color: Colors.brown,fontWeight: FontWeight.bold,fontSize:21));
        },),
            Center(child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: (){
                    setState(() {
                      issmall=true;
                      ismediam=false;
                      islarge=false;
                      priceProvider.total=5;
                    });
                  },
                  child: Card(
                    color: const Color(0xFFF5EED3),
                    elevation: 3,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(child: Text('s',style: TextStyle(fontSize: 20,color: Colors.brown),),),
                    ),),
                ),
                InkWell(
                  onTap: (){
                    setState(() {
                      issmall=false;
                      ismediam=true;
                      islarge=false;
                      priceProvider.total=10;
                    });
                  },
                  child: Card(
                    color: const Color(0xFFF5EED3),
                    elevation: 3,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(child: Text('m',style: TextStyle(fontSize: 20,color: Colors.brown),),),
                  ),),
                ),
                InkWell(
                  onTap: (){
                    setState(() {
                      issmall=false;
                      ismediam=false;
                      islarge=true;
                      priceProvider.total=15;
                    });
                  },
                  child: Card(
                    color: const Color(0xFFF5EED3),
                    elevation: 3,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(child: Text('l',style: TextStyle(fontSize: 20,color: Colors.brown),)),
                  ),),
                ),
              ],
            ),)
          ],
        ),
        AnimatedBuilder(
        animation: _animationController,
        builder:(context,_){
         return _buildIngredientsWidget();
    }
        )
      ],
    );
  }


  Widget pizzatype(String image,BoxConstraints constraints,_focused,paddingvalue){
    return Center(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        height: _focused?constraints.maxHeight:islarge?constraints.maxHeight-30:ismediam?constraints.maxHeight-70:issmall?constraints.maxHeight-100:constraints.maxHeight-30,//1
        child: Stack(
          children: [
            Image.asset("assets/images/part1/dish.png"),
            Padding(
              padding:  EdgeInsets.all(paddingvalue),
              child: Image.asset(image),
            )
          ],
        ),
      ),
    );
  }

}
class _PizzaButton extends StatelessWidget {
  const _PizzaButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: width*.43),
      height: height*.06,
      width: width*.15,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.orange.withOpacity(0.5),
            Colors.orange
          ]
        ),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(20)
      ),child: const Icon(Icons.shopping_cart_outlined,color: Colors.white,),
    );
  }
}
