import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petcom/controllers/auth_controller.dart';
import 'package:petcom/controllers/product_controller.dart';
import 'package:petcom/screens/seller/add_product.dart';

class SellerHomeScreen extends StatelessWidget {
  const SellerHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthController _auth = Get.put(AuthController());
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () => Get.to(const AddProduct()),
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications))
        ]),
        body: GetX<ProductController>(
          builder: (controller) {
            return Container(
              padding: const EdgeInsets.all(16),
              width: Get.width,
              height: Get.height,
              child: SingleChildScrollView(
                child: SafeArea(
                  child: SizedBox(
                    width: double.infinity,
                    height: Get.height,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        ElevatedButton(
                          onPressed: () => _auth.signOut(),
                          child: const Text('Log Out'),
                        ),
                        Text(_auth.currentUser.value.role),
                        Expanded(
                          child: ListView.builder(
                            itemCount: controller.products.length,
                            itemBuilder: (BuildContext context, int index) {
                              final _product = controller.products[index];
                              return ListTile(
                                title: Text(_product.name),
                                leading: Image.network(_product.image),
                                trailing: Text(_product.price.toString()),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }
}
