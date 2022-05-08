import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:petcom/controllers/auth_controller.dart';
import 'package:petcom/controllers/db.dart';
import 'package:petcom/models/product.dart';
import 'package:petcom/models/user.dart';

class CartController extends GetxController {
  final _database = DatabaseServices();
  AuthController? _auth;
  Rx<List<Product>> cartList = Rx<List<Product>>([]);
  List<Product> get items => cartList.value;
  int get count => items.length;
  double get totalCost => items.fold(0, (sum, item) => sum + item.price);

  @override
  onInit() {
    super.onInit();
    _auth = Get.find<AuthController>();
    cartList.bindStream(_database.getCartItems(_auth!.currentUser.value));
  }

  addToCart(Product product) async {
    try {
      await _database.addToCart(product, _auth!.currentUser.value);
    } catch (error) {
      Get.snackbar('OOPS!', 'Something went wrong!');
    }
  }

  removeFromCart(Product product) async {
    try {
      await _database.removeFromCart(product, _auth!.currentUser.value);
    } catch (error) {
      Get.snackbar('OOPS!', 'Something went wrong!');
    }
  }

  Future<http.Response> sendNotification(List<String> tokenIdList,
      String contents, String heading, String image) async {
    return await http.post(
      Uri.parse('https://onesignal.com/api/v1/notifications'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "app_id":
            '76077b27-f650-4193-baf5-71b671e57c08', //kAppId is the App Id that one get from the OneSignal When the application is registered.

        "include_player_ids":
            tokenIdList, //tokenIdList Is the List of All the Token Id to to Whom notification must be sent.

        // android_accent_color reprsent the color of the heading text in the notifiction
        "android_accent_color": "FF9976D2",

        "small_icon": "ic_stat_onesignal_default",

        "large_icon": image,

        "headings": {"en": heading},

        "contents": {"en": contents},
      }),
    );
  }

  removeAll() async {
    try {
      for (var product in cartList.value) {
        await _database.createOrder(product, _auth!.currentUser.value.uid);
        await _database.removeFromCart(product, _auth!.currentUser.value);
        CustomUser user = await _database.getCurrentUser(product.uploadedBy);
        print(user.phoneNumber);
        var res = await sendNotification([
          user.token
        ], '${_auth!.currentUser.value.name} has paid for your ${product.name}.',
            'PETCOM: Customer found.', product.image);
        print(res.body);
      }

      Get.snackbar('Thank you!', "We'll contact you soon.");
    } catch (error) {
      Get.snackbar('OOPS!', 'Something went wrong!');
    }
  }
}
