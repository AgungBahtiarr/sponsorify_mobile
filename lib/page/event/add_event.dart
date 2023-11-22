// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sponsorify/data/datasource/remote_event.dart';

class AddEvent extends StatefulWidget {
  const AddEvent({super.key});

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  bool? isCreated;

  File? image;
  String? name;
  String? description;
  String? email;
  String? token;

  Future getFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        image = File(result.files.single.path!);
      });
    } else {
      // User canceled the picker
    }
  }

  Future getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString('token');
    });
  }

  Future addEvent(token, name, email, description, image) async {
    final response =
        await RemoteEvent().addData(token, name, email, description, image);

    return response;
  }

  TextEditingController eventNameController = TextEditingController();
  TextEditingController eventDescriptonController = TextEditingController();
  TextEditingController eventEmailController = TextEditingController();

  @override
  void initState() {
    getToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 42),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 24,
              ),
              Text(
                "Fill in your event data here",
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
                    "Event Name",
                    style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xffA3A3A3)),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  TextField(
                    controller: eventNameController,
                    decoration: const InputDecoration(
                        hintText: "Enter Your Event Name",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
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
                    "Event Description",
                    style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xffA3A3A3)),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  TextField(
                    controller: eventDescriptonController,
                    decoration: const InputDecoration(
                        hintText: "Enter Your Event Description",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
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
                    "Event Email",
                    style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xffA3A3A3)),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  TextField(
                    controller: eventEmailController,
                    decoration: const InputDecoration(
                        hintText: "Enter Your Event Email",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide:
                                BorderSide(width: 1, color: Colors.black))),
                  )
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
                      "Upload Photos of Event In Here",
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
                      minimumSize: Size(MediaQuery.of(context).size.width, 42),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      backgroundColor: const Color(0xff2ED892)),
                  onPressed: () async {
                    setState(() {
                      name = eventNameController.text;
                      description = eventDescriptonController.text;
                      email = eventEmailController.text;
                    });
                    // print('$image');
                    await addEvent(token, name, email, description, image!.path)
                        .then((value) {
                      setState(() {
                        isCreated = value;
                      });
                    });

                    if (isCreated == true) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          backgroundColor: Colors.green,
                          content: Text("Berhasil Menambahkan data")));
                      setState(() {
                        eventNameController.text = '';
                        eventDescriptonController.text = '';
                        eventEmailController.text = '';
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          backgroundColor: Colors.red,
                          content: Text(
                              "Gagal Menambahkan data, periksa kembali inputan anda!")));
                      setState(() {
                        eventNameController.text = '';
                        eventDescriptonController.text = '';
                        eventEmailController.text = '';
                      });
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
    );
  }
}
