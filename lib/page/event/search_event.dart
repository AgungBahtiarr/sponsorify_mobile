import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sponsorify/data/datasource/remote_category.dart';
import 'package:sponsorify/data/datasource/remote_sponsorship.dart';
import 'package:sponsorify/data/model/category_model.dart';

class SearchEvent extends StatefulWidget {
  const SearchEvent({super.key});

  @override
  State<SearchEvent> createState() => _SearchEventState();
}

class _SearchEventState extends State<SearchEvent> {
  List<CategoryModel> listCategory = [];
  List<dynamic> listSponsorship = [];

  String? token = '';

  Future getData() async {
    final responCategory = await RemoteCategory().getCategory();
    setState(() {
      listCategory = responCategory;
    });
  }

  Future getDataSponsorshipWithCategory(id) async {
    final response = await RemoteSponsorship().getDataWithCategory(token, id);
    setState(() {
      listSponsorship = response;
    });
  }

  @override
  void initState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString('token');
    });
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 42),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            width: 296,
            child: Text(
              "Find your best ekspresion",
              style: GoogleFonts.poppins(
                  fontSize: 25, fontWeight: FontWeight.w700),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: Text(
              "Category",
              style: GoogleFonts.poppins(
                  fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 50,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: listCategory.length,
                itemBuilder: (context, index) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff372E1D)),
                          onPressed: () {
                            getDataSponsorshipWithCategory(
                                listCategory[index].id);
                          },
                          child: Text(
                            listCategory[index].category,
                            style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          )),
                    ),
                  );
                }),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height,
            // width: MediaQuery.of(context).size.width,
            child: ListView.builder(
                itemCount: listSponsorship.length,
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
                              decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  color: Colors.black12,
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          'https://picsum.photos/200/300'))),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 18, right: 42),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  listSponsorship[index].name,
                                  style: GoogleFonts.poppins(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  listSponsorship[index].category.category,
                                  style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(
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
                                                  listSponsorship[index].id
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
                            padding: const EdgeInsets.only(
                              bottom: 12,
                            ),
                            child: Container(
                              width: 32,
                              height: 32,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xff604038)),
                              child: IconButton(
                                  padding: EdgeInsets.zero,
                                  color: Colors.white,
                                  onPressed: () {},
                                  icon:
                                      const Icon(Icons.bookmark_add_outlined)),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }),
          )
        ]),
      ),
    );
  }
}
