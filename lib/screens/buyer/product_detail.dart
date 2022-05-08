import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petcom/controllers/cart_controller.dart';
import 'package:petcom/models/product.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;
  const ProductDetailScreen({Key? key, required this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => CartController());
    var controller = Get.put(CartController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Obx(() {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: product.uid,
                  child: Container(
                    width: double.infinity,
                    height: Get.height / 2,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE7DFC6),
                      borderRadius: BorderRadius.circular(16),
                      image: DecorationImage(
                        image: NetworkImage(product.image),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 32,
                    horizontal: 16.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Detail(label: 'Name', value: product.name),
                      Detail(label: 'Age', value: product.age.toString()),
                      Detail(label: 'Breed', value: product.name),
                      Detail(
                          label: 'Price',
                          value: 'NPR. ${product.price.toString()}'),
                      Detail(label: 'Contact', value: product.name),
                    ],
                  ),
                )),
                Container(
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    color: controller.items
                            .map((p) => p.uid == product.uid)
                            .contains(true)
                        ? Colors.deepPurpleAccent.shade100
                        : Colors.deepPurpleAccent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => controller.items
                              .map((p) => p.uid == product.uid)
                              .contains(true)
                          ? controller.removeFromCart(product)
                          : controller.addToCart(product),
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          controller.items
                                  .map((p) => p.uid == product.uid)
                                  .contains(true)
                              ? 'Remove'
                              : 'Add to cart',
                          style: const TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            letterSpacing: 1.4,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            );
          }),
        ),
      ),
    );
  }
}

class Detail extends StatelessWidget {
  final String label, value;

  const Detail({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: '$label: ',
        style: const TextStyle(
          color: Colors.black,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        children: <TextSpan>[
          TextSpan(
            text: value,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.normal,
            ),
          )
        ],
      ),
    );
  }
}
