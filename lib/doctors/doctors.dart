import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petcom/models/doctor.dart';
import 'package:url_launcher/url_launcher.dart' as l;

//import 'package:get/get.dart';
//import 'dart:html';

class AvalibleDoctors extends StatelessWidget {
  const AvalibleDoctors({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Doctor> doctors = generateDummyDoctors();

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        title: const Text('Available Doctors'),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: doctors.length,
          itemBuilder: (context, index) => DoctorCard(doctor: doctors[index]),
        ),
      )),
    );
  }
}

class DoctorCard extends StatelessWidget {
  final Doctor doctor;
  const DoctorCard({
    Key? key,
    required this.doctor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(top: 20),
      height: 130,
      width: Get.width,
      decoration: BoxDecoration(
          color: const Color.fromRGBO(77, 214, 214, 0.5), //blue container
          borderRadius: BorderRadius.circular(20)),
      child: Stack(
        children: [
          Container(
            height: double.infinity,
            width: 150,
            decoration: BoxDecoration(
              color: Colors.white, //Color.fromRGBO(253, 196, 56, 3), //yellow
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: AssetImage(
                  doctor.image,
                ),
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          Positioned(
            left: 160,
            child: SizedBox(
              child: Row(
                children: [
                  Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Name: ${doctor.name}",
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          Text(doctor.specialization),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(100),
                      bottomLeft: Radius.circular(-20)),
                ),
              ),
              onPressed: () => {
                l.launch("tel:${doctor.contact}"),
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(
                    Icons.call,
                    size: 15,
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Text('Contact now'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
