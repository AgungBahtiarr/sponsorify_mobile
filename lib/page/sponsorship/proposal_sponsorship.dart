import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sponsorify/data/datasource/remote_proposal.dart';
import 'package:sponsorify/data/model/proposal_sponsorship_model.dart';

class ProposalSponsorship extends StatefulWidget {
  const ProposalSponsorship({super.key});

  @override
  State<ProposalSponsorship> createState() => _ProposalSponsorshipState();
}

class _ProposalSponsorshipState extends State<ProposalSponsorship> {
  String? token;
  List<ProposalSponsorshipModel> proposal = [];
  List<ProposalSponsorshipModel> proposalPending = [];

  bool isLoading = false;

  Future getData() async {
    setState(() {
      isLoading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString('token');
    });
    final response = await RemoteProposal().getProposalSponsorship(token);
    setState(() {
      proposal = response;
      for (var item in proposal) {
        if (item.idStatus == 1) {
          proposalPending.add(item);
        }
      }
      isLoading = false;
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 42),
        child: Column(children: [
          Text(
            "Incoming Proposal List",
            style:
                GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 32,
          ),
          isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : SizedBox(
                  height: MediaQuery.of(context).size.height / 1.3,
                  child: ListView.builder(
                      itemCount: proposalPending.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color(0xFF000000),
                                    blurRadius: 0,
                                    offset: Offset(2, 3),
                                    spreadRadius: -1,
                                  )
                                ]),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 18, vertical: 12),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    width: 78,
                                    height: 78,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                'http://10.0.2.2:8080/${proposalPending[index].event!.profilePhoto}')),
                                        shape: BoxShape.circle,
                                        color: const Color(0xffD9D9D9)),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 140,
                                        child: Text(
                                          overflow: TextOverflow.ellipsis,
                                          "${proposalPending[index].event!.name}",
                                          style: GoogleFonts.poppins(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 150,
                                        child: Text(
                                            overflow: TextOverflow.ellipsis,
                                            "${proposalPending[index].event!.description}"),
                                      ),
                                      const SizedBox(
                                        height: 12,
                                      ),
                                      SizedBox(
                                        height: 28,
                                        child: ElevatedButton(
                                            onPressed: () async {
                                              SharedPreferences prefs =
                                                  await SharedPreferences
                                                      .getInstance();
                                              prefs.setInt(
                                                  'idDetailEvent',
                                                  proposalPending[index]
                                                      .idEvent!);
                                              prefs.setInt('idDetailProposal',
                                                  proposalPending[index].id!);

                                              // ignore: use_build_context_synchronously
                                              Navigator.pushNamed(
                                                  context, '/detail_event');
                                            },
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    const Color(0xff77E0B5)),
                                            child: Text(
                                              'Detail',
                                              style: GoogleFonts.poppins(
                                                  fontSize: 12,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600),
                                            )),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ),
        ]),
      ),
    );
  }
}
