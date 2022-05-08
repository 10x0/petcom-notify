import 'package:flutter/material.dart';
import 'package:petcom/models/food.dart';

class FoodScreen extends StatelessWidget {
  const FoodScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Food> foods = generateDummyFoods();
    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black,
          title: const Text('Food Items'),
        ),
        body: SafeArea(
            child: GridView.builder(
          itemCount: foods.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemBuilder: (context, index) => FoodItem(food: foods[index]),
          //Doctors(doctor: doctors[index]),
        )));
  }
}

class FoodItem extends StatelessWidget {
  final Food food;
  const FoodItem({
    Key? key,
    required this.food,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(30),
          height: 100,
          width: 110,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(food.image),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(10),
            color: const Color.fromARGB(255, 59, 66, 85),
          ),
        ),
        Text(food.price),
        Text(food.name),
        ElevatedButton(onPressed: () {}, child: const Text('Add to cart')),
      ],
    );
  }
}
