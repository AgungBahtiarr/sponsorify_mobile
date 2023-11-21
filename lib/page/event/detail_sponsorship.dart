import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sponsorify/data/datasource/remote_event.dart';
import 'package:sponsorify/data/datasource/remote_proposal.dart';
import 'package:sponsorify/data/datasource/remote_sponsorship.dart';
import 'package:sponsorify/data/model/event_model.dart';
import 'package:sponsorify/data/model/sponsorship_model.dart';

class DetailSponsorship extends StatefulWidget {
  const DetailSponsorship({super.key});

  @override
  State<DetailSponsorship> createState() => _DetailSponsorshipState();
}

class _DetailSponsorshipState extends State<DetailSponsorship> {
  String? token;
  Sponsorship? sponsorship;

  List<EventModel> events = [];
  List<String> eventModel = [];

  String dropDownValue = '';
  int? idSponsorship;
  int? idEvent;
  File? file;
  int? authId;

  bool? isSubmmited;

  Future<bool> addProposal() async {
    final add = await RemoteProposal().addProposal(
        file!.path, token, idSponsorship.toString(), idEvent, authId);

    return add;
  }

  Future getFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        file = File(result.files.single.path!);
        print(file);
      });
    } else {
      // User canceled the picker
    }
  }

  Future getDetail(id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString('token');
      authId = prefs.getInt('authId');
    });
    final response = await RemoteSponsorship().getDetail(token, id);
    final responseEvent = await RemoteEvent().getData(token);

    setState(() {
      sponsorship = response;
      events = responseEvent;

      for (var event in events) {
        eventModel.add(event.name);
      }
    });
  }

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      var args =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      setState(() {
        idSponsorship = args['idSponsorship'];
        getDetail(idSponsorship);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              child: Column(
                children: [
                  Container(
                    decoration: const BoxDecoration(color: Colors.amber),
                    height: 449,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 52),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 42,
                            height: 42,
                            decoration: BoxDecoration(
                                color: const Color(0xffE3E3E3),
                                borderRadius: BorderRadius.circular(10)),
                            child: IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.arrow_back)),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 42, vertical: 8),
                            child: Text(
                              "Detail Sponsorship",
                              style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),
                          ),
                          Container(
                            width: 42,
                            height: 42,
                            decoration: BoxDecoration(
                                color: const Color(0xffE3E3E3),
                                borderRadius: BorderRadius.circular(10)),
                            child: IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.bookmark_border)),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 2,
                  )
                ],
              ),
            ),
            Positioned(
              top: 402,
              child: Container(
                width: MediaQuery.of(context).size.width,
                // height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255),
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(40))),
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 38, left: 32),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              sponsorship!.name,
                              style: GoogleFonts.poppins(
                                  fontSize: 24, fontWeight: FontWeight.w600),
                            ),
                            Text(
                              sponsorship!.category.category,
                              style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xffC2C4C9)),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 44, right: 35),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.location_pin,
                              size: 26,
                              color: Color(0xffE07777),
                            ),
                            Text(
                              sponsorship!.address,
                              style: GoogleFonts.poppins(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 24),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Description",
                              style: GoogleFonts.poppins(
                                  fontSize: 16, fontWeight: FontWeight.w600)),
                          SizedBox(
                            height: 138,
                            child: Text(
                              sponsorship!.description,
                              style: GoogleFonts.poppins(fontSize: 16),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 30),
                    child: ElevatedButton(
                      onPressed: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height / 2,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 32),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const SizedBox(
                                        height: 60,
                                      ),
                                      Text("Select Event",
                                          style: GoogleFonts.poppins(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600)),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 8, bottom: 24),
                                        child: DropdownMenu<String>(
                                          width: 330,
                                          initialSelection: eventModel.first,
                                          onSelected: (String? value) {
                                            setState(() {
                                              dropDownValue = value!;
                                            });
                                          },
                                          dropdownMenuEntries: eventModel
                                              .map<DropdownMenuEntry<String>>(
                                                  (String value) {
                                            return DropdownMenuEntry<String>(
                                                value: value, label: value);
                                          }).toList(),
                                        ),
                                      ),
                                      Text("Upload Proposal",
                                          style: GoogleFonts.poppins(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600)),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 8),
                                        child: GestureDetector(
                                          onTap: () {
                                            getFile();
                                          },
                                          child: Container(
                                            width: 330,
                                            height: 58,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                border: Border.all(
                                                  color: Colors.black,
                                                )),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 24),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "Upload Proposal",
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 14),
                                                  ),
                                                  const Icon(Icons.upload_file)
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 62,
                                      ),
                                      ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              minimumSize: Size(
                                                  MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  42),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              backgroundColor:
                                                  const Color(0xff2ED892)),
                                          onPressed: () async {
                                            for (var event in events) {
                                              if (dropDownValue == event.name) {
                                                print(event.id);

                                                setState(() {
                                                  idEvent = event.id;
                                                });
                                              }
                                            }

                                            await addProposal().then((value) {
                                              setState(() {
                                                isSubmmited = value;
                                              });
                                            });

                                            print("$isSubmmited di bawah");
                                            if (isSubmmited == true) {
                                              print('berhasil');
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                      backgroundColor:
                                                          Colors.green,
                                                      content:
                                                          Text("Berhasil")));

                                              Navigator.pop(context);
                                            } else {
                                              print('gagal');
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                      backgroundColor:
                                                          Colors.red,
                                                      content: Text(
                                                          "Gagal Mengupload proposal, Periksa kembali data anda")));
                                              Navigator.pop(context);
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
                                  ),
                                ),
                              );
                            });
                      },
                      style: ElevatedButton.styleFrom(
                          minimumSize:
                              Size(MediaQuery.of(context).size.width, 42),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          backgroundColor: const Color(0xff2ED892)),
                      child: Text(
                        "Apply Now",
                        style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}