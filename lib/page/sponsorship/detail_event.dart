import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sponsorify/data/datasource/remote_event.dart';
import 'package:sponsorify/data/datasource/remote_proposal.dart';
import 'package:sponsorify/data/datasource/remote_transaction.dart';
import 'package:sponsorify/data/model/event_model.dart';
import 'package:sponsorify/data/model/proposal_sponsorship_model.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';

class DetailEvent extends StatefulWidget {
  const DetailEvent({super.key});

  @override
  State<DetailEvent> createState() => _DetailEventState();
}

class _DetailEventState extends State<DetailEvent> {
  String? token;
  int? idDetailEvent;
  int? idDetailProposal;
  List<ProposalSponsorshipModel> proposalList = [];
  ProposalSponsorshipModel? proposal;

  EventModel? event;
  bool isLoading = false;

  TextEditingController messageController = TextEditingController();
  TextEditingController fundsController = TextEditingController();
  String? message;
  String? funds;

  Future getData() async {
    setState(() {
      isLoading = true;
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString('token');
      idDetailEvent = prefs.getInt('idDetailEvent');
      idDetailProposal = prefs.getInt('idDetailProposal');
    });

    final response = await RemoteEvent().getDetail(token, idDetailEvent);
    setState(() {
      event = response;
      isLoading = false;
    });

    final responseProposal =
        await RemoteProposal().getProposalSponsorship(token);
    setState(() {
      proposalList = responseProposal;

      for (var element in proposalList) {
        if (element.id == idDetailProposal) {
          proposal = element;
        }
      }
    });
  }

  Future addTransaction(
      idEvent, idSponsorship, idProposal, sponsorshipFunds) async {
    final response = await RemoteTransaction().addTransaction(
        token, idEvent, idSponsorship, idProposal, sponsorshipFunds);

    return response;
  }

  Future updateData(idStatus, message, idProposal) async {
    final response = await RemoteProposal().updateProposal(
      token,
      idProposal,
      message,
      idStatus,
    );

    return response;
  }

  // Download File
  Future fileDownload(
    name,
  ) async {
    await FileDownloader.downloadFile(
        url: 'http://10.0.2.2:8080/${proposal!.proposal}',
        name: name,
        downloadDestination: DownloadDestinations.appFiles,
        onProgress: (String? fileName, double progress) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Loading..."),
            backgroundColor: Colors.amber,
          ));
        },
        onDownloadCompleted: (String path) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Download Complete'),
            backgroundColor: Colors.green,
          ));
        },
        onDownloadError: (String error) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Download failed, $error'),
            backgroundColor: Colors.red,
          ));
        });
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
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.amber,
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      'http://10.0.2.2:8080/${event!.profilePhoto}'))),
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
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      icon: const Icon(Icons.arrow_back)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 82, vertical: 8),
                                  child: Text(
                                    "Detail Event",
                                    style: GoogleFonts.poppins(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                                  ),
                                ),
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
                                    overflow: TextOverflow.ellipsis,
                                    event!.name,
                                    style: GoogleFonts.poppins(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Description",
                                    style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600)),
                                SizedBox(
                                  height: 88,
                                  child: Text(
                                    event!.description,
                                    style: GoogleFonts.poppins(fontSize: 16),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 32, vertical: 42),
                          child: SizedBox(
                            height: 58,
                            child: ElevatedButton(
                                onPressed: () {
                                  fileDownload('${proposal!.event!.name}');
                                },
                                style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    backgroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    side: const BorderSide(
                                        color: Colors.black, width: 1)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 18),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Tap here to Download file',
                                        style: GoogleFonts.poppins(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black),
                                      ),
                                      const Icon(Icons.download)
                                    ],
                                  ),
                                )),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  showModalMessageReject(context);
                                },
                                style: ElevatedButton.styleFrom(
                                    fixedSize: const Size(132, 38),
                                    backgroundColor: const Color(0xffF43737)),
                                child: Text(
                                  "Reject",
                                  style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  showModalMessageAccept(context);
                                },
                                style: ElevatedButton.styleFrom(
                                    fixedSize: const Size(132, 38),
                                    backgroundColor: const Color(0xff2ED892)),
                                child: Text(
                                  "Accept",
                                  style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white),
                                ),
                              )
                            ],
                          ),
                        )
                      ]),
                    ),
                  )
                ],
              ),
            ),
          );
  }

  Future<dynamic> showModalMessageReject(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  Text("Message",
                      style: GoogleFonts.poppins(
                          fontSize: 18, fontWeight: FontWeight.w600)),
                  const SizedBox(
                    height: 8,
                  ),
                  TextField(
                    controller: messageController,
                    enabled: true,
                    decoration: const InputDecoration(
                        hintText: "Enter your message for event",
                        prefix: SizedBox(
                          width: 25,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                                color: Color.fromRGBO(0, 0, 0, 0.612),
                                width: 2)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                                color: Color.fromRGBO(0, 0, 0, 0.612),
                                width: 2)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                                color: Color.fromRGBO(0, 0, 0, 0.612),
                                width: 2))),
                  ),
                  const SizedBox(
                    height: 24,
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
                          message = messageController.text;
                        });
                        await updateData(3, message, proposal!.id);
                        await addTransaction(idDetailEvent,
                            proposal!.idSponsorship, idDetailProposal, funds);
                        // ignore: use_build_context_synchronously
                        Navigator.pushReplacementNamed(
                            context, '/sponsorship_layout');
                      },
                      child: Text(
                        "Confirm",
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
  }

  Future<dynamic> showModalMessageAccept(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return SingleChildScrollView(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Text("Message",
                        style: GoogleFonts.poppins(
                            fontSize: 18, fontWeight: FontWeight.w600)),
                    const SizedBox(
                      height: 8,
                    ),
                    TextField(
                      controller: messageController,
                      enabled: true,
                      decoration: const InputDecoration(
                          hintText: "Enter your message for event",
                          prefix: SizedBox(
                            width: 25,
                          ),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(0, 0, 0, 0.612),
                                  width: 2)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(0, 0, 0, 0.612),
                                  width: 2)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(0, 0, 0, 0.612),
                                  width: 2))),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text("Budget Plan",
                        style: GoogleFonts.poppins(
                            fontSize: 18, fontWeight: FontWeight.w600)),
                    const SizedBox(
                      height: 8,
                    ),
                    TextField(
                      controller: fundsController,
                      enabled: true,
                      decoration: const InputDecoration(
                          hintText: "Plan for the amount of budget",
                          prefix: SizedBox(
                            width: 25,
                          ),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(0, 0, 0, 0.612),
                                  width: 2)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(0, 0, 0, 0.612),
                                  width: 2)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(0, 0, 0, 0.612),
                                  width: 2))),
                    ),
                    const SizedBox(
                      height: 24,
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
                            message = messageController.text;
                            funds = fundsController.text;
                          });
                          await updateData(2, message, proposal!.id);
                          await addTransaction(idDetailEvent,
                              proposal!.idSponsorship, idDetailProposal, funds);
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context).showMaterialBanner(
                            MaterialBanner(
                              content: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 18),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.amber,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Please send an email to this address for further processing',
                                          style:
                                              GoogleFonts.poppins(fontSize: 18),
                                        ),
                                        Text(
                                          "${proposal!.event!.email}",
                                          style: GoogleFonts.poppins(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              actions: <Widget>[
                                Builder(builder: (context) {
                                  return TextButton(
                                    onPressed: () {
                                      ScaffoldMessenger.of(context)
                                          .clearMaterialBanners();
                                    },
                                    child: Text(
                                      'DISMISS',
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  );
                                }),
                              ],
                            ),
                          );
                          // ignore: use_build_context_synchronously
                          Navigator.pushReplacementNamed(
                              context, '/sponsorship_layout');
                        },
                        child: Text(
                          "Confirm",
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
        });
  }
}
