import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sponsorify/data/datasource/remote_proposal.dart';
import 'package:sponsorify/data/datasource/remote_sponsorship.dart';
import 'package:sponsorify/data/datasource/remote_user.dart';
import 'package:sponsorify/data/model/proposal_sponsorship_model.dart';
import 'package:sponsorify/data/model/sponsorship_model.dart';
import 'package:sponsorify/data/model/user_model.dart';

class DashboardSponsorship extends StatefulWidget {
  const DashboardSponsorship({super.key});

  @override
  State<DashboardSponsorship> createState() => _DashboardSponsorshipState();
}

class _DashboardSponsorshipState extends State<DashboardSponsorship> {
  String? token;
  UserModel? user;
  SponsorshipModel? sponsorship;
  List<ProposalSponsorshipModel> proposal = [];
  List<ProposalSponsorshipModel> proposalHistory = [];

  bool isLoading = false;
  bool isLoadingCount = false;

  var count = 0;
  getData() async {
    setState(() {
      isLoading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString('token');
      print(token);
    });

    final responseUser = await RemoteUser().getData(token);
    setState(() {
      user = responseUser;
    });
    final responseSponsor = await RemoteSponsorship().getAuthDetail(token);
    setState(() {
      sponsorship = responseSponsor;
      isLoading = false;
    });

    final responseProposal =
        await RemoteProposal().getProposalSponsorship(token);

    setState(() {
      proposal = responseProposal;

      for (var event in proposal) {
        if (event.idStatus == 2 || event.idStatus == 3) {
          proposalHistory.add(event);
        }
      }
    });
  }

  getCountProposal() async {
    setState(() {
      isLoadingCount = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString('token');
    });

    final response = await RemoteProposal().countProposal(token);
    setState(() {
      count = response;
      isLoadingCount = false;
    });
  }

  @override
  void initState() {
    getData();
    getCountProposal();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 42),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Good Morning 👋",
                    style: GoogleFonts.poppins(
                        fontSize: 24, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 28,
                  ),
                  Container(
                    height: 124,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xff37271D),
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 12, left: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  isLoadingCount
                                      ? 'Loading...'
                                      : 'Wellcome, ${user!.data!.name}',
                                  style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                Text(
                                  sponsorship!.name,
                                  style: GoogleFonts.poppins(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                Text(
                                  sponsorship!.email,
                                  style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xff9B938E)),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 12),
                            child: Container(
                              height: 78,
                              width: 78,
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          'https://picsum.photos/200')),
                                  shape: BoxShape.circle,
                                  color: Color(0xff5f524a)),
                            ),
                          )
                        ]),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xff37271D)),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Column(children: [
                        Text(
                          "Incoming Proposal",
                          style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                        Text(
                          "$count",
                          style: GoogleFonts.poppins(
                              fontSize: 38,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        )
                      ]),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 32),
                    child: Text(
                      "History",
                      style: GoogleFonts.poppins(
                          fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 2,
                    child: ListView.builder(
                      itemCount: proposalHistory.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.black)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height: 52,
                                    width: 52,
                                    decoration: const BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                'https://picsum.photos/200')),
                                        shape: BoxShape.circle,
                                        color: Color(0xff5f524a)),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 120,
                                        child: Text(
                                          overflow: TextOverflow.ellipsis,
                                          "${proposalHistory[index].event!.name}",
                                          style: GoogleFonts.poppins(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 120,
                                        child: Text(
                                          overflow: TextOverflow.ellipsis,
                                          "${proposalHistory[index].event!.description}",
                                          style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      )
                                    ],
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: const Color(0xff77E0B5),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 6),
                                      child: Text(
                                        "${proposalHistory[index].status!.status}",
                                        style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          );
  }
}
