import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailSponsorship extends StatefulWidget {
  const DetailSponsorship({super.key});

  @override
  State<DetailSponsorship> createState() => _DetailSponsorshipState();
}

class _DetailSponsorshipState extends State<DetailSponsorship> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              child: Container(
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
            ),
            Positioned(
              top: 402,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
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
                              "Floridina",
                              style: GoogleFonts.poppins(
                                  fontSize: 24, fontWeight: FontWeight.w600),
                            ),
                            Text(
                              "Category",
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
                              "Kalibaru",
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Description",
                            style: GoogleFonts.poppins(
                                fontSize: 16, fontWeight: FontWeight.w600)),
                        Text(
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum sed ornare ipsum. Nunc ligula diam, gravida eget lacus vel, lacinia pharetra enim. Class aptent taciti sociosqu ad.",
                          style: GoogleFonts.poppins(fontSize: 16),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 30),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          minimumSize:
                              Size(MediaQuery.of(context).size.width, 42),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          backgroundColor: const Color(0xff2ED892)),
                      child: Text(
                        "Apply Now",
                        style: GoogleFonts.poppins(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
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
}
