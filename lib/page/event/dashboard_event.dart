// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sponsorify/data/datasource/remote_category.dart';
import 'package:sponsorify/data/datasource/remote_saved.dart';
import 'package:sponsorify/data/datasource/remote_sponsorship.dart';
import 'package:sponsorify/data/datasource/remote_user.dart';
import 'package:sponsorify/data/model/category_model.dart';
import 'package:sponsorify/data/model/sponsorship_model.dart';
import 'package:sponsorify/data/model/user_model.dart';

class DashboardEvent extends StatefulWidget {
  const DashboardEvent({super.key});

  @override
  State<DashboardEvent> createState() => _DashboardEventState();
}

class _DashboardEventState extends State<DashboardEvent> {
  List<Sponsorship> sponsorships = [];
  List<CategoryModel> categories = [];

  String? token;
  String? userName = '';
  String? urlPhoto;
  int? idSponsorship;
  UserModel? user;

  bool? isSaved;
  bool isLoading = false;

  int currentPageIndex = 0;

  Future getData() async {
    setState(() {
      isLoading = !isLoading;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString('token');
      userName = prefs.getString('userName');
      urlPhoto = prefs.getString("urlPhoto");
    });

    final userDataResponse = await RemoteUser().getData(token);
    setState(() {
      user = userDataResponse;
    });
    List<Sponsorship> response = await RemoteSponsorship().getData(token);
    List<CategoryModel> responseCategory = await RemoteCategory().getCategory();
    setState(() {
      sponsorships = response;
      categories = responseCategory;
    });

    setState(() {
      isLoading = !isLoading;
    });
  }

  Future addToSaved(id) async {
    final response = await RemoteSaved().addData(token, id);

    return response;
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    height: 345,
                    decoration: const BoxDecoration(
                        color: Color(0xFF37271D),
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(20),
                            bottomLeft: Radius.circular(20))),
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 49),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 42,
                                width: 42,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            'http://10.0.2.2:8080/${user!.data!.profilePhoto}')),
                                    color: Color.fromARGB(115, 127, 127, 127)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 14),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '$userName',
                                      style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white),
                                    ),
                                    Text('Wellcome back',
                                        style: GoogleFonts.poppins(
                                          color: const Color.fromARGB(
                                              142, 255, 255, 255),
                                        ))
                                  ],
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 42,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: const Color(0xFFFEAC7A),
                                borderRadius: BorderRadius.circular(20)),
                            child: Row(
                              children: [
                                Container(
                                  width: 143,
                                  height: 138,
                                  decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 103, 86, 86),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Color(0x3F000000),
                                          blurRadius: 15,
                                          offset: Offset(4, 4),
                                          spreadRadius: 0,
                                        )
                                      ],
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              "http://10.0.2.2:8080/${sponsorships[0].profilePhoto}"))),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        sponsorships[0].name,
                                        style: GoogleFonts.poppins(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white),
                                      ),
                                      Text(
                                        sponsorships[0].category.category,
                                        style: GoogleFonts.poppins(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        width: 127,
                                        child: Text(
                                          sponsorships[0].description,
                                          style: GoogleFonts.poppins(
                                              color: Colors.white, fontSize: 8),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      SizedBox(
                                        height: 24,
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    const Color.fromARGB(
                                                        255, 119, 224, 180)),
                                            onPressed: () {
                                              Navigator.pushNamed(context,
                                                  '/detail_sponsorship',
                                                  arguments: {
                                                    "idSponsorship":
                                                        sponsorships[0].id
                                                  });
                                            },
                                            child: Text(
                                              "Show More",
                                              style: GoogleFonts.poppins(
                                                  color: Colors.black,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600),
                                            )),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 300,
                    child: Container(
                        height: 90,
                        width: 328,
                        decoration: const BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Color(0x3F000000),
                                blurRadius: 4,
                                offset: Offset(0, 4),
                                spreadRadius: 0,
                              )
                            ],
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: ListView.builder(
                          itemCount: categories.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: const Color(0xFF372E1D),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    width: 50,
                                    height: 50,
                                  ),
                                  Text(
                                    categories[index].category,
                                    style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                            );
                          },
                        )),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 72, bottom: 12, left: 34),
                child: Text(
                  "Recommended",
                  style: GoogleFonts.poppins(
                      fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(
                height: 500,
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 32),
                  itemCount: sponsorships.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Container(
                        width: 396,
                        height: 100,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0x3F000000),
                                blurRadius: 16,
                                offset: Offset(0, 4),
                                spreadRadius: -1,
                              )
                            ]),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(6),
                              child: Container(
                                width: 124,
                                height: 88,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    color: Colors.black12,
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            'http://10.0.2.2:8080/${sponsorships[index].profilePhoto}'))),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 18, right: 42),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    sponsorships[index].name,
                                    style: GoogleFonts.poppins(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    sponsorships[index].category.category,
                                    style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  SizedBox(
                                    width: 92,
                                    height: 22,
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            backgroundColor:
                                                const Color(0xFF77E0B5)),
                                        onPressed: () {
                                          Navigator.pushNamed(
                                              context, '/detail_sponsorship',
                                              arguments: {
                                                "idSponsorship":
                                                    sponsorships[index].id
                                              });
                                        },
                                        child: Text(
                                          'Detail',
                                          style: GoogleFonts.poppins(
                                              color: Colors.black,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500),
                                        )),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                bottom: 12,
                              ),
                              child: Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xff604038)),
                                child: IconButton(
                                    padding: EdgeInsets.zero,
                                    color: Colors.white,
                                    onPressed: () async {
                                      await addToSaved(sponsorships[index].id)
                                          .then((value) {
                                        setState(() {
                                          isSaved = value;
                                        });
                                      });
                                      if (isSaved == true) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                backgroundColor: Colors.green,
                                                content:
                                                    Text("Berhasil disimpan")));
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                backgroundColor: Colors.red,
                                                content:
                                                    Text("Gagal disimpan")));
                                      }
                                    },
                                    icon: Icon(Icons.bookmark_add_outlined)),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )
            ]),
          );
  }
}

class SponsorCategory extends StatelessWidget {
  const SponsorCategory({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
              color: const Color(0xFF372E1D),
              borderRadius: BorderRadius.circular(10)),
          width: 50,
          height: 50,
        ),
        Text(
          "Food",
          style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500),
        )
      ],
    );
  }
}
