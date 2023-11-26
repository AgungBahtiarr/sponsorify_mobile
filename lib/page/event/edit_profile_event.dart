import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sponsorify/data/datasource/remote_user.dart';
import 'package:sponsorify/data/model/user_model.dart';

class EditProfileEvent extends StatefulWidget {
  const EditProfileEvent({super.key});

  @override
  State<EditProfileEvent> createState() => _EditProfileEventState();
}

class _EditProfileEventState extends State<EditProfileEvent> {
  String? token = '';

  String? fullName;
  String? email;
  File? imageRaw;

  bool isLoading = false;

  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  UserModel? user;
  Future getData() async {
    setState(() {
      isLoading = !isLoading;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString('token');
    });

    final response = await RemoteUser().getData(token);
    setState(() {
      user = response;
      fullNameController.text = user!.data!.name!;
      emailController.text = user!.data!.email!;
    });
    setState(() {
      isLoading = !isLoading;
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

  Future editData(fullName, email) async {
    if (imageRaw == null) {
      final response = await RemoteUser().editData(token, fullName, email);
      return response;
    } else {
      final response =
          await RemoteUser().editData(token, fullName, email, imageRaw!.path);
      return response;
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 52),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Row(
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
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      (MediaQuery.of(context).size.width / 5)),
                              child: Text(
                                'Edit Profile',
                                style: GoogleFonts.poppins(
                                    fontSize: 18, fontWeight: FontWeight.w700),
                              ),
                            )
                          ],
                        ),
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      'http://10.0.2.2:8080/${user!.data!.profilePhoto}')),
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
                          height: 42,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Your information ",
                              style: GoogleFonts.poppins(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 14),
                                child: Text(
                                  "FullName",
                                  style: GoogleFonts.poppins(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              TextField(
                                controller: fullNameController,
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
                                            color:
                                                Color.fromRGBO(0, 0, 0, 0.612),
                                            width: 2)),
                                    enabledBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        borderSide: BorderSide(
                                            color:
                                                Color.fromRGBO(0, 0, 0, 0.612),
                                            width: 2)),
                                    focusedBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        borderSide: BorderSide(
                                            color:
                                                Color.fromRGBO(0, 0, 0, 0.612),
                                            width: 2))),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 18,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 14),
                                child: Text(
                                  "Email",
                                  style: GoogleFonts.poppins(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
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
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        borderSide: BorderSide(
                                            color:
                                                Color.fromRGBO(0, 0, 0, 0.612),
                                            width: 2)),
                                    enabledBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        borderSide: BorderSide(
                                            color:
                                                Color.fromRGBO(0, 0, 0, 0.612),
                                            width: 2)),
                                    focusedBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        borderSide: BorderSide(
                                            color:
                                                Color.fromRGBO(0, 0, 0, 0.612),
                                            width: 2))),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            minimumSize:
                                Size(MediaQuery.of(context).size.width, 52),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            backgroundColor: const Color(0xff2ED892)),
                        onPressed: () {
                          setState(() {
                            fullName = fullNameController.text;
                            email = emailController.text;
                          });
                          editData(fullName, email);
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text("Success"),
                            backgroundColor: Colors.green,
                          ));
                          getData();
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Save",
                          style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ))
                  ],
                ),
              ),
            ),
    );
  }
}
