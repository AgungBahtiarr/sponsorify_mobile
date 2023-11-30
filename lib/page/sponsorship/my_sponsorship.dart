// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sponsorify/data/datasource/remote_sponsorship.dart';
import 'package:sponsorify/data/model/sponsorship_model.dart';

class MySponsorship extends StatefulWidget {
  const MySponsorship({super.key});

  @override
  State<MySponsorship> createState() => _MySponsorshipState();
}

class _MySponsorshipState extends State<MySponsorship> {
  String? token;
  bool isLoading = false;
  bool? isSuccess;

  String? name;
  String? email;
  String? description;
  String? address;
  File? imageRaw;
  String? image;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  SponsorshipModel? sponsorship;
  Future getData() async {
    setState(() {
      isLoading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString('token');
    });

    final response = await RemoteSponsorship().getAuthDetail(token);
    setState(() {
      sponsorship = response;
      nameController.text = sponsorship!.name;
      emailController.text = sponsorship!.email;
      descriptionController.text = sponsorship!.description;
      addressController.text = sponsorship!.address;
      isLoading = false;
    });
  }

  Future getFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        imageRaw = File(result.files.single.path!);
      });
    } else {
      // User canceled the picker
    }
  }

  Future editData(
      token, idSponsorship, name, email, description, address, idCategory,
      [profilPhoto]) async {
    final response = await RemoteSponsorship().editData(token, idSponsorship,
        name, email, description, address, idCategory, profilPhoto);

    setState(() {
      isSuccess = response;
    });

    if (isSuccess == true) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Update Succes"),
        backgroundColor: Colors.green,
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Update failed'),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            body: SingleChildScrollView(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 42),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                          color: const Color(0xffE3E3E3),
                          borderRadius: BorderRadius.circular(10)),
                      child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.arrow_back)),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    SizedBox(
                      width: 296,
                      child: Text(
                        "Manage your sponsorship profile",
                        style: GoogleFonts.poppins(
                            fontSize: 25, fontWeight: FontWeight.w700),
                      ),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      'http://10.0.2.2:8080/${sponsorship!.profilePhoto}')),
                              color: Colors.amber,
                              shape: BoxShape.circle),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                width: 52,
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        width: 4, color: Colors.white)),
                                child: IconButton(
                                  onPressed: () {
                                    getFile();
                                  },
                                  icon: const Icon(
                                    Icons.edit,
                                  ),
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 14),
                              child: Text(
                                "Sponsorship Name",
                                style: GoogleFonts.poppins(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                            ),
                            TextField(
                              controller: nameController,
                              enabled: true,
                              decoration: InputDecoration(
                                  prefix: const SizedBox(
                                    width: 25,
                                  ),
                                  hintStyle: GoogleFonts.poppins(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                  border: const OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 2)),
                                  enabledBorder: const OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 2)),
                                  focusedBorder: const OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 2))),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 14),
                              child: Text(
                                "Sponsorship Email",
                                style: GoogleFonts.poppins(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                            ),
                            TextField(
                              controller: emailController,
                              enabled: true,
                              decoration: InputDecoration(
                                  prefix: const SizedBox(
                                    width: 25,
                                  ),
                                  hintStyle: GoogleFonts.poppins(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                  border: const OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 2)),
                                  enabledBorder: const OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 2)),
                                  focusedBorder: const OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 2))),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 14),
                              child: Text(
                                "Sponsorship Description",
                                style: GoogleFonts.poppins(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                            ),
                            TextField(
                              controller: descriptionController,
                              enabled: true,
                              decoration: InputDecoration(
                                  prefix: const SizedBox(
                                    width: 25,
                                  ),
                                  hintStyle: GoogleFonts.poppins(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                  border: const OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 2)),
                                  enabledBorder: const OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 2)),
                                  focusedBorder: const OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 2))),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 14),
                                  child: Text(
                                    "Sponsorship Address",
                                    style: GoogleFonts.poppins(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                TextField(
                                  controller: addressController,
                                  enabled: true,
                                  decoration: InputDecoration(
                                      prefix: const SizedBox(
                                        width: 25,
                                      ),
                                      hintStyle: GoogleFonts.poppins(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500),
                                      border: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          borderSide: BorderSide(
                                              color: Colors.black, width: 2)),
                                      enabledBorder: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          borderSide: BorderSide(
                                              color: Colors.black, width: 2)),
                                      focusedBorder: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          borderSide: BorderSide(
                                              color: Colors.black, width: 2))),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            minimumSize:
                                Size(MediaQuery.of(context).size.width, 52),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            backgroundColor: const Color(0xff2ED892)),
                        onPressed: () async {
                          setState(() {
                            name = nameController.text;
                            email = emailController.text;
                            description = descriptionController.text;
                            address = addressController.text;
                            if (imageRaw == null) {
                              editData(
                                  token,
                                  sponsorship!.id,
                                  name,
                                  email,
                                  description,
                                  address,
                                  sponsorship!.idCategory);
                            } else {
                              image = imageRaw!.path;
                              editData(
                                  token,
                                  sponsorship!.id,
                                  name,
                                  email,
                                  description,
                                  address,
                                  sponsorship!.idCategory,
                                  image);
                            }
                          });
                          Navigator.pushReplacementNamed(
                              context, '/my_sponsorship');
                        },
                        child: Text(
                          "Save",
                          style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        )),
                  ],
                ),
              ),
            ),
          );
  }
}
