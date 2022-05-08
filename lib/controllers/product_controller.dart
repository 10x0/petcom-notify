import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:petcom/controllers/auth_controller.dart';
import 'package:petcom/controllers/db.dart';
import 'package:petcom/models/product.dart';
import 'package:uuid/uuid.dart';

class ProductController extends GetxController {
  final _database = DatabaseServices();
  AuthController? _auth;
  Rx<List<Product>> productList = Rx<List<Product>>([]);
  Rx<List<Product>> dogList = Rx<List<Product>>([]);
  Rx<List<Product>> catList = Rx<List<Product>>([]);
  Rx<List<Product>> cattleList = Rx<List<Product>>([]);
  Rx<List<Product>> birdList = Rx<List<Product>>([]);
  Rx<List<Product>> fishList = Rx<List<Product>>([]);
  Rx<List<Product>> horseList = Rx<List<Product>>([]);
  Rx<List<Product>> foodList = Rx<List<Product>>([]);
  List<Product> get products => productList.value;
  List<Product> get dogProducts => dogList.value;
  List<Product> get catProducts => catList.value;
  List<Product> get cattleProducts => cattleList.value;
  List<Product> get birdProducts => birdList.value;
  List<Product> get fishProducts => fishList.value;
  List<Product> get horseProducts => horseList.value;
  List<Product> get foodProducts => foodList.value;

  @override
  onInit() {
    super.onInit();
    _auth = Get.find<AuthController>();
    productList
        .bindStream(_database.getMyProducts(_auth!.currentUser.value.uid));
    dogList.bindStream(_database.getCategoryProducts(category: "Dog"));
    catList.bindStream(_database.getCategoryProducts(category: "Cat"));
    cattleList
        .bindStream(_database.getCategoryProducts(category: "Farm Animal"));
    birdList.bindStream(_database.getCategoryProducts(category: "Bird"));
    fishList.bindStream(_database.getCategoryProducts(category: "Fish"));
    horseList.bindStream(_database.getCategoryProducts(category: "Horse"));
    foodList.bindStream(_database.getCategoryProducts(category: "Food"));
  }

  // @override
  // onReady() {
  //   productList.bindStream(_database.getMyProducts(_auth!.currentUser.value.uid));
  // }

  addNewProduct({
    required String name,
    required String breed,
    required String category,
    required int age,
    required num price,
    required File image,
  }) async {
    try {
      final imageId = DateTime.now().toString();
      final ref = FirebaseStorage.instance.ref().child('images/$imageId');
      await ref.putFile(image);
      final url = await ref.getDownloadURL();
      var uuid = const Uuid();

      Product product = Product(
        uid: uuid.v4(),
        name: name,
        price: price,
        breed: breed,
        category: category,
        age: age,
        image: url,
        contact: _auth!.currentUser.value.phoneNumber,
        uploadedBy: _auth!.currentUser.value.uid,
      );
      await _database.createProduct(product);
      Get.back();
    } catch (error) {
      Get.snackbar('OOPS!', 'Something went wrong!');
    }
  }
}
