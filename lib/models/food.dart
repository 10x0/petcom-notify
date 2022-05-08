class Food {
  Food({
    required this.name,
    required this.image,
    required this.price,
  });
  String name, image, price;
}

List<Food> generateDummyFoods() {
  return [
    Food(
      name: "Ram Baran",
      price: "Kutta Specialist",
      image: 'assets/images/pedegree.jpg',
    ),
    Food(
      name: "Ram Baran",
      price: "Kutta Specialist",
      image: 'assets/images/pedegree.jpg',
    ),
    Food(
      name: "Ram Baran",
      price: "Kutta Specialist",
      image: 'assets/images/pedegree.jpg',
    ),
    Food(
      name: "Ram Baran",
      price: "Kutta Specialist",
      image: 'assets/images/pedegree.jpg',
    ),
    Food(
      name: "Ram Baran",
      price: "Kutta Specialist",
      image: 'assets/images/pedegree.jpg',
    )
  ];
}
