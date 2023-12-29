import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sponsorify/data/datasource/remote_proposal.dart';
import 'package:sponsorify/data/datasource/remote_saved.dart';
import 'package:sponsorify/data/model/proposal_model.dart';
import 'package:sponsorify/data/model/saved_model.dart';

class SavedEvent extends StatefulWidget {
  const SavedEvent({super.key});

  @override
  State<SavedEvent> createState() => _SavedEventState();
}

List<SavedModel> saveds = [];
List<ProposalModel> proposals = [];
String? token;

class _SavedEventState extends State<SavedEvent> {
  Future getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString('token');
    });
    final response = await RemoteSaved().getData(token);
    final responseProposal = await RemoteProposal().getData(token);
    setState(() {
      saveds = response;
      proposals = responseProposal;
    });
  }

  Future deleteData(id) async {
    await RemoteSaved().deleteData(token, id);
    getData();
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(200),
          child: AppBar(
            leadingWidth: 32,
            toolbarHeight: 200,
            leading: Container(),
            bottom: TabBar(
              indicatorColor: const Color(0xff372E1D),
              tabs: [
                Tab(
                    child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 56, vertical: 10),
                  decoration: BoxDecoration(
                      color: const Color(0xff372E1D),
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    "Saved",
                    style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                )),
                Tab(
                    child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 56, vertical: 10),
                  decoration: BoxDecoration(
                      color: const Color(0xff372E1D),
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    "Status",
                    style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                )),
              ],
            ),
            titleTextStyle: GoogleFonts.poppins(
                fontSize: 26, fontWeight: FontWeight.bold, color: Colors.black),
            title: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Track Your",
                ),
                Text("Submission,")
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 32, right: 32, top: 32),
              child: ListView.builder(
                  itemCount: saveds.length,
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
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(20)),
                                    color: Colors.black12,
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            'http://10.0.2.2:8080/${saveds[index].sponsorship!.profilePhoto}'))),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 18, right: 42),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 130,
                                    child: Text(
                                      overflow: TextOverflow.ellipsis,
                                      '${saveds[index].sponsorship!.name}',
                                      style: GoogleFonts.poppins(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  Text(
                                    'Apply Now',
                                    style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        // width: 92,
                                        height: 22,
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8)),
                                                backgroundColor:
                                                    const Color(0xFF77E0B5)),
                                            onPressed: () {
                                              Navigator.pushNamed(context,
                                                  '/detail_sponsorship',
                                                  arguments: {
                                                    "idSponsorship":
                                                        saveds[index]
                                                            .idSponsorship
                                                  });
                                            },
                                            child: Text(
                                              'Detail',
                                              style: GoogleFonts.poppins(
                                                  color: Colors.black,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500),
                                            )),
                                      ),
                                      IconButton(
                                          onPressed: () async {
                                            deleteData(saveds[index].id);
                                            setState(() {});
                                          },
                                          icon: const Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ))
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
            Container(
              padding: const EdgeInsets.only(left: 32, right: 32, top: 18),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Container(
                      height: 62,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: 2, color: Colors.amber)),
                      child: Center(
                          child: Text(
                        textAlign: TextAlign.center,
                        "Note: After Status Accepted Please wait email from sponsorship",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      )),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 2,
                    child: ListView.builder(
                        itemCount: proposals.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Container(
                              width: 396,
                              height: 100,
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
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
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(20)),
                                          color: Colors.black12,
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                  'http://10.0.2.2:8080/${proposals[index].sponsorship!.profilePhoto}'))),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 18, right: 42),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: 130,
                                          child: Text(
                                            overflow: TextOverflow.ellipsis,
                                            "${proposals[index].sponsorship!.name}",
                                            style: GoogleFonts.poppins(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 130,
                                          child: Text(
                                            // overflow: TextOverflow.ellipsis,
                                            "Status: ${proposals[index].status!.status}",
                                            style: GoogleFonts.poppins(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
