import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petcom/animals/animals.dart';
import 'package:petcom/controllers/auth_controller.dart';
import 'package:petcom/controllers/cart_controller.dart';
import 'package:petcom/doctors/doctors.dart';
import 'package:petcom/foods/food.dart';

class BuyerHomeScreen extends StatelessWidget {
  const BuyerHomeScreen({Key? key}) : super(key: key);
  final int index = 2;
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => CartController());
    AuthController _auth = Get.find<AuthController>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(
              Icons.menu_rounded,
              color: Colors.black,
            ),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.shopping_cart_outlined,
              color: Colors.black,
            ),
            onPressed: () => Get.toNamed('/cart'),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
                title: const Text('Meet with Doctors'),
                leading: const Icon(Icons.medical_services_outlined),
                onTap: () {
                  Get.to(const AvalibleDoctors());
                }),
            ListTile(
              title: const Text('Food Items'),
              leading: const Icon(Icons.food_bank),
              onTap: () {
                Get.to(
                  const FoodScreen(),
                );
                // ...
              },
            ),
            ListTile(
                title: const Text('LogOut'),
                leading: const Icon(Icons.medical_services_outlined),
                onTap: () => _auth.signOut()),
          ],
        ),
      ),
      body: GridView(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 40,
          mainAxisSpacing: 40,
          crossAxisCount: 2,
        ),
        children: const [
          Dogggy(
            background: "assets/images/menus/cat.png",
            goto: CatItems(),
            color: Colors.red,
            title: 'Cat',
          ),
          Dogggy(
            background: "assets/images/menus/dog.png",
            goto: DogItems(),
            color: Colors.amber,
            title: 'Dog',
          ),
          Dogggy(
            background: "assets/images/menus/fish.png",
            goto: FishItems(),
            color: Colors.red,
            title: 'Fish',
          ),
          Dogggy(
            background: "assets/images/menus/bird.png",
            goto: BirdItems(),
            color: Colors.amber,
            title: 'Bird',
          ),
          Dogggy(
            background: "assets/images/menus/farm.png",
            goto: FarmItems(),
            color: Colors.amber,
            title: 'Farm Animals',
          ),
          Dogggy(
            background: "assets/images/menus/food.png",
            goto: FoodScreen(),
            color: Colors.amber,
            title: 'Food Items',
          ),
        ],
      ),
    );
  }
}

class Dogggy extends StatelessWidget {
  final String title;
  final Color color;
  final Widget goto;
  final String background;
  const Dogggy(
      {Key? key,
      required this.title,
      required this.color,
      required this.background,
      required this.goto})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => goto),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: const Color(0xFFE7DFC6),
            boxShadow: const [
              BoxShadow(
                color: Color(0x99E7DFC6),
                blurRadius: 15,
                spreadRadius: -5,
                offset: Offset(0, 10),
              )
            ]),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomRight,
              child: SizedBox(
                height: Get.height / 10,
                child: Image.asset(background),
              ),
            ),
            Container(
              width: Get.width / 4,
              padding: const EdgeInsets.all(16.0),
              child: Text(
                title,
                textAlign: TextAlign.start,
                style: const TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
