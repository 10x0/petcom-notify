import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:petcom/controllers/cart_controller.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => CartController());

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
      ),
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey.shade100,
      body: Builder(
        builder: (context) {
          return GetX<CartController>(builder: (controller) {
            return ListView(
              children: <Widget>[
                createHeader(),
                createSubTitle(controller.count),
                if (controller.count > 0) createCartList(controller),
                if (controller.count > 0)
                  footer(context: context, controller: controller)
              ],
            );
          });
        },
      ),
    );
  }

  final config = PaymentConfig(
    amount: 10000, // Amount should be in paisa
    productIdentity: 'dell-g5-g5510-2021',
    productName: 'Dell G5 G5510 2021',
    productUrl: 'https://www.khalti.com/#/bazaar',
    additionalData: {
      // Not mandatory; can be used for reporting purpose
      'vendor': 'Khalti Bazaar',
    },
  );

  footer({required BuildContext context, required CartController controller}) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(left: 30),
                child: const Text(
                  "Total",
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 30),
                child: Text(
                  "NPR. ${controller.totalCost}",
                  style: const TextStyle(
                      color: Color.fromARGB(255, 10, 205, 91), fontSize: 14),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          KhaltiButton(
            config: config,
            preferences: const [
              PaymentPreference.khalti,
            ],
            onSuccess: (successModel) async {
              // Perform Server Verification
              await controller.removeAll();
            },
            onFailure: (failureModel) {
              // What to do on failure?
            },
            onCancel: () {
              // User manually cancelled the transaction
            },
          ),
          const SizedBox(height: 8),
        ],
      ),
      margin: const EdgeInsets.only(top: 16),
    );
  }

  createHeader() {
    return Container(
      alignment: Alignment.topLeft,
      child: const Text(
        "SHOPPING CART",
        style: TextStyle(fontSize: 16, color: Colors.black),
      ),
      margin: const EdgeInsets.only(left: 12, top: 12),
    );
  }

  createSubTitle(int count) {
    return Container(
      alignment: Alignment.topLeft,
      child: Text(
        "Total($count) Items",
        style: const TextStyle(fontSize: 12, color: Colors.grey),
      ),
      margin: const EdgeInsets.only(left: 12, top: 4),
    );
  }

  createCartList(CartController controller) {
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemBuilder: (context, position) {
        return createCartListItem(controller, position);
      },
      itemCount: controller.items.length,
    );
  }

  createCartListItem(CartController controller, int position) {
    return Stack(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(16))),
          child: Row(
            children: <Widget>[
              Container(
                margin:
                    const EdgeInsets.only(right: 8, left: 8, top: 8, bottom: 8),
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(14)),
                  color: Colors.blue.shade200,
                  image: DecorationImage(
                    image: NetworkImage(controller.items[position].image),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.only(right: 8, top: 4),
                        child: Text(
                          controller.items[position].name,
                          maxLines: 2,
                          softWrap: true,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        controller.items[position].category,
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "NPR. ${controller.items[position].price.toString()}",
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                flex: 100,
              )
            ],
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: GestureDetector(
            onTap: () => controller.removeFromCart(controller.items[position]),
            child: Container(
              width: 24,
              height: 24,
              alignment: Alignment.center,
              margin: const EdgeInsets.only(right: 10, top: 8),
              child: const Icon(
                Icons.close,
                color: Colors.white,
                size: 20,
              ),
              decoration: const BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.all(Radius.circular(4)),
              ),
            ),
          ),
        )
      ],
    );
  }
}
