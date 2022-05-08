import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petcom/controllers/cart_controller.dart';
import 'package:petcom/models/product.dart';

class ProductCardTile extends StatelessWidget {
  final Product product;

  const ProductCardTile({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
      child: Builder(builder: (context) {
        return Container(
          width: Get.width,
          height: Get.height / 6,
          decoration: BoxDecoration(
            // color: const Color(0x118447FF),
            color: const Color(0xFFE7DFC6),
            borderRadius: BorderRadius.circular(10),
          ),
          child: GetX<CartController>(builder: (controller) {
            return Stack(
              children: [
                Positioned(
                  width: Get.width / 2.74,
                  height: Get.height / 6,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    // ),
                    child: Hero(
                        tag: product.uid,
                        child: Image.network(
                          product.image,
                          fit: BoxFit.fill,
                        )),
                  ),
                ),
                Positioned(
                  left: Get.width / 2.74,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Name: ${product.name}',
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                        Text('Age: ${product.age.toString()}'),
                        Text('Breed: ${product.breed}'),
                        Text('Contact: ${product.contact}'),
                        Text('Price: ${product.price.toString()}'),
                        //Text('Contact: ${product.contact}'),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: controller.items
                              .map((p) => p.uid == product.uid)
                              .contains(true)
                          ? Colors.deepPurpleAccent.shade100
                          : Colors.deepPurpleAccent,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(150),
                          bottomLeft: Radius.circular(-20),
                          bottomRight: Radius.circular(12),
                        ),
                      ),
                    ),
                    onPressed: () {
                      controller.addToCart(product);
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(controller.items
                                .map((p) => p.uid == product.uid)
                                .contains(true)
                            ? 'Added'
                            : 'Add to cart'),
                        const SizedBox(
                          width: 0,
                        ),
                        const Icon(
                          Icons.storefront,
                          size: 15,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),
        );
      }),
    );
  }
}
