class Doctor {
  Doctor({
    required this.name,
    required this.image,
    required this.specialization,
    required this.contact,
  });
  String name, image, contact, specialization;
}

List<Doctor> generateDummyDoctors() {
  return [
    Doctor(
      name: "Ram Baran",
      specialization: "Behaviour  Specialist",
      image: 'assets/images/doctors/doctor1.jpg',
      contact: "9800000000",
    ),
    Doctor(
      name: "Ram Baran",
      specialization: "internal Medicine  Specialist",
      image: 'assets/images/doctors/doctor2.jpg',
      contact: "9800000000",
    ),
    Doctor(
      name: "Ram Baran",
      specialization: "Kutta Dentistry Specialist",
      image: 'assets/images/doctors/doctor3.jpg',
      contact: "9800000000",
    ),
    Doctor(
      name: "Ram Baran",
      specialization: "Kutta Specialist",
      image: 'assets/images/doctors/doctor4.jpg',
      contact: "9800000000",
    ),
    Doctor(
      name: "Ram Baran",
      specialization: "Kutta Specialist",
      image: 'assets/images/doctors/doctor5.jpg',
      contact: "9800000000",
    ),
    Doctor(
      name: "Ram Baran",
      specialization: "Kutta Specialist",
      image: 'assets/images/doctors/doctor6.jpg',
      contact: "9800000000",
    )
  ];
}
