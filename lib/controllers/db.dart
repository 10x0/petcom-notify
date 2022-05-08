import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:petcom/models/product.dart';
import 'package:petcom/models/user.dart';
import 'package:uuid/uuid.dart';

class DatabaseServices {
  final _userStore = FirebaseFirestore.instance.collection('/users');
  final _productStore = FirebaseFirestore.instance.collection('/products');
  final _orderStore = FirebaseFirestore.instance.collection('/orders');
  // const timestamp = FirebaseFirestore.instance.;

  getCurrentUser(uid) async {
    try {
      var doc = await _userStore.doc(uid).snapshots().first;
      CustomUser user = CustomUser.fromJson(doc);
      return user;
    } catch (error) {
      Get.offAndToNamed('/register');
      return null;
    }
  }

  createUser(CustomUser user) async {
    try {
      await _userStore.doc(user.uid).set(user.toJson());
      _userStore.doc(user.uid).collection('/cartItems');
    } catch (error) {
      () {};
    }
  }

  createProduct(Product product) async {
    try {
      await _productStore.doc(product.uid).set({
        ...product.toJson(),
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (error) {
      () {};
    }
  }

  Stream<List<Product>> getMyProducts(String uid) {
    return _productStore.where("uploadedBy", isEqualTo: uid).snapshots().map(
      (QuerySnapshot query) {
        List<Product> products = [];
        for (var doc in query.docs) {
          final product = Product.fromSnapshot(doc);
          products.add(product);
        }
        return products;
      },
    );
  }

  Stream<List<Product>> getCategoryProducts({required category}) {
    return _productStore.where("category", isEqualTo: category).snapshots().map(
      (QuerySnapshot query) {
        List<Product> products = [];
        for (var doc in query.docs) {
          final product = Product.fromSnapshot(doc);
          products.add(product);
        }
        return products;
      },
    );
  }

  Stream<List<Product>> getProductsByCategory(String category) {
    return _productStore.where("category", isEqualTo: category).snapshots().map(
      (QuerySnapshot query) {
        List<Product> products = [];
        for (var doc in query.docs) {
          final product = Product.fromSnapshot(doc);
          products.add(product);
        }
        return products;
      },
    );
  }

  addToCart(Product product, CustomUser user) async {
    try {
      await _userStore
          .doc(user.uid)
          .collection('/cartItems')
          .doc(product.uid)
          .set(product.toJson());
    } catch (error) {
      () {};
    }
  }

  createOrder(Product product, String orderedBy) async {
    try {
      var uuid = const Uuid();
      await _orderStore.doc(uuid.v4()).set(
          {"to": product.uploadedBy, "by": orderedBy, ...product.toJson()});
    } catch (error) {
      () {
        print(error);
      };
    }
  }

  removeFromCart(Product product, CustomUser user) async {
    try {
      await _userStore
          .doc(user.uid)
          .collection('/cartItems')
          .doc(product.uid)
          .delete();
    } catch (error) {
      () {
        print('error');
      };
    }
  }

  emptyCart(CustomUser user) async {
    try {
      _userStore.doc(user.uid).collection('/cartItems');
    } catch (e) {
      () {
        print('e');
      };
    }
  }

  Stream<List<Product>> getCartItems(CustomUser user) {
    return _userStore.doc(user.uid).collection('/cartItems').snapshots().map(
      (QuerySnapshot query) {
        List<Product> products = [];
        for (var doc in query.docs) {
          final product = Product.fromSnapshot(doc);
          products.add(product);
        }
        return products;
      },
    );
  }
}
