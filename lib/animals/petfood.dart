import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petcom/animals/widget/card.dart';
import 'package:petcom/screens/buyer/product_detail.dart';
import 'package:petcom/controllers/product_controller.dart';

class Petitemitem extends StatelessWidget {
  const Petitemitem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0,
        title: const Text('Pet Food Items'),
      ),
      body: SafeArea(
        child: Obx(() {
          return ListView.builder(
              itemCount: controller.foodProducts.length,
              itemBuilder: (BuildContext context, int index) {
                var product = controller.foodProducts[index];
                return GestureDetector(
                  onTap: () => Get.to(ProductDetailScreen(product: product)),
                  child: ProductCardTile(product: product),
                );
              });
        }),
      ),
    );
  }
}
