// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sponsorify/data/datasource/remote_category.dart';
import 'package:sponsorify/data/datasource/remote_sponsorship.dart';
import 'package:sponsorify/data/model/category_model.dart';

class AddSponsorship extends StatefulWidget {
  const AddSponsorship({super.key});

  @override
  State<AddSponsorship> createState() => _AddSponsorshipState();
}

class _AddSponsorshipState extends State<AddSponsorship> {
  String? token;

  // Controller

  String? name;
  String? description;
  String? email;
  String? address;
  String? idCategory;
  String? image;

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  File? file;

  bool? isAddSuccess;
  Future addData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString('token');
    });

    final response = await RemoteSponsorship()
        .addData(token, name, email, description, address, idCategory, image);


    return response;
  }

  String? dropdownvalue;
  var categories = [''];
  List<CategoryModel> category = [];

  Future getCategories() async {
    final response = await RemoteCategory().getCategory();
    setState(() {
      category = response;
      categories = [];
      for (var item in category) {
        categories.add(item.category);
      }
    });
  }

  Future getFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        file = File(result.files.single.path!);
        image = file!.path;
      });
    } else {
      // User canceled the picker
    }
  }

  @override
  void initState() {
    getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 42),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 24,
                ),
                Text(
                  "Fill in your sponsorship data here",
                  style: GoogleFonts.poppins(
                      fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 8,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Sponsorship Name",
                      style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xffA3A3A3)),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                          hintText: "Enter Your Sponsorship Name",
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              borderSide:
                                  BorderSide(width: 1, color: Colors.black))),
                    )
                  ],
                ),
                const SizedBox(
                  height: 18,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Sponsorship Description",
                      style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xffA3A3A3)),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    TextField(
                      controller: descriptionController,
                      decoration: const InputDecoration(
                          hintText: "Enter Your Sponsorship Description",
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              borderSide:
                                  BorderSide(width: 1, color: Colors.black))),
                    )
                  ],
                ),
                const SizedBox(
                  height: 18,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Sponsorship Email",
                      style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xffA3A3A3)),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    TextField(
                      controller: emailController,
                      decoration: const InputDecoration(
                          hintText: "Enter Your Sponsorship Email",
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              borderSide:
                                  BorderSide(width: 1, color: Colors.black))),
                    )
                  ],
                ),
                const SizedBox(
                  height: 18,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Sponsorship Address",
                      style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xffA3A3A3)),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    TextField(
                      controller: addressController,
                      decoration: const InputDecoration(
                          hintText: "Enter Your Sponsorship Address",
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              borderSide:
                                  BorderSide(width: 1, color: Colors.black))),
                    )
                  ],
                ),
                const SizedBox(
                  height: 14,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Sponsorship Category",
                      style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xffA3A3A3)),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 64,
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.black),
                          borderRadius: BorderRadius.circular(20)),
                      child: DropdownButtonHideUnderline(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: DropdownButton(
                            hint: const Padding(
                              padding: EdgeInsets.only(left: 14),
                              child: Text('Select your sponsorship category'),
                            ),

                            value: dropdownvalue,

                            icon: const Icon(Icons.keyboard_arrow_down),

                            // Array list of items
                            items: categories.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items),
                              );
                            }).toList(),

                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownvalue = newValue!;
                                for (var element in category) {
                                  if (dropdownvalue == element.category) {
                                    idCategory = '${element.id}';
                                  }
                                }
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 32,
                ),
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        textAlign: TextAlign.center,
                        "Upload Photos Of Your Sponsorship In Here",
                        style: GoogleFonts.poppins(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      GestureDetector(
                        onTap: () {
                          getFile();
                        },
                        child: Container(
                          height: 100,
                          width: 184,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.upload_file,
                                size: 40,
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(
                                "Drag file here to upload",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize:
                            Size(MediaQuery.of(context).size.width, 42),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        backgroundColor: const Color(0xff2ED892)),
                    onPressed: () async {
                      setState(() {
                        name = nameController.text;
                        description = descriptionController.text;
                        email = emailController.text;
                        address = addressController.text;
                      });

                      await addData().then((value) {
                        setState(() {
                          isAddSuccess = value;
                        });
                      });

                      if (isAddSuccess == true) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('Add data success'),
                          backgroundColor: Colors.green,
                        ));
                        Navigator.pushReplacementNamed(
                            context, '/sponsorship_layout');
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('Add data failed'),
                          backgroundColor: Colors.red,
                        ));
                        setState(() {});
                      }
                    },
                    child: Text(
                      "Submit",
                      style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ))
              ],
            )),
      ),
    );
  }
}
