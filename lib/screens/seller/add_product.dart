import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petcom/controllers/product_controller.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final ProductController _productController = Get.find<ProductController>();
  final _formKey = GlobalKey<FormState>();

  File? _image;

  final picker = ImagePicker();
  Image? _imageWidget;

  String? _name;
  String? _breed;
  String? _category;
  int? _age;
  num? _price;

  Future _pickImage() async {
    final image = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = File(image!.path);
      _imageWidget = Image.file(_image!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        width: Get.width,
        height: Get.height,
        child: SingleChildScrollView(
          child: SafeArea(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      hintText: 'Enter name.',
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    cursorColor: Colors.deepPurpleAccent,
                    style: const TextStyle(fontSize: 20),
                    validator: (value) {
                      if (value == null) {
                        return 'Please provide pet\'s name.!';
                      }
                      setState(() {
                        _name = value;
                      });
                      return null;
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    // inputFormatters: <TextInputFormatter>[
                    //   FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    // ],
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      hintText: 'Enter age.',
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    cursorColor: Colors.deepPurpleAccent,
                    style: const TextStyle(fontSize: 20),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please provide pet\'s age.!';
                      }
                      setState(() {
                        _age = int.parse(value);
                      });
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      hintText: 'Enter breed.',
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    cursorColor: Colors.deepPurpleAccent,
                    style: const TextStyle(fontSize: 20),
                    validator: (value) {
                      if (value == null) {
                        return 'Please provide pet\'s breed.!';
                      }
                      setState(() {
                        _breed = value;
                      });
                      return null;
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      hintText: 'Enter price.',
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    cursorColor: Colors.deepPurpleAccent,
                    style: const TextStyle(fontSize: 20),
                    validator: (value) {
                      if (value == null) {
                        return 'Please provide pet\'s price.!';
                      }
                      setState(() {
                        _price = double.parse(value);
                      });
                      return null;
                    },
                  ),

// START
                  DropdownButton<String>(
                    hint: const Text('Select category'),
                    value: _category,
                    items: <String>[
                      'Cat',
                      'Dog',
                      'Bird',
                      'Fish',
                      'Farm Animal',
                      'Horse'
                    ].map((value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _category = value;
                      });
                    },
                  ),
// STOP
                  Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: _imageWidget,
                  ),
                  TextButton(
                    onPressed: () async {
                      await _pickImage();
                    },
                    child: const Text('Select image'),
                  ),
                  Container(
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.deepPurpleAccent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            _productController.addNewProduct(
                              name: _name!,
                              breed: _breed!,
                              category: _category!,
                              age: _age!,
                              price: _price!,
                              image: _image!,
                            );
                          }
                        },
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          alignment: Alignment.center,
                          child: const Text(
                            "Add for sale 💰",
                            style: TextStyle(
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
              ),
            ),
          ),
        ),
      ),
    );
  }
}
