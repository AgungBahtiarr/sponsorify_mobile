import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DashboardEvent extends StatelessWidget {
  const DashboardEvent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.bottomCenter,
            children: [
              const TopSection(),
              Positioned(
                top: 400,
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
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
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
                            style: GoogleFonts.poppins(
                                fontSize: 12, fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                      Column(
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
                            style: GoogleFonts.poppins(
                                fontSize: 12, fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                      Column(
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
                            style: GoogleFonts.poppins(
                                fontSize: 12, fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                      Column(
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
                            style: GoogleFonts.poppins(
                                fontSize: 12, fontWeight: FontWeight.w500),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 72, bottom: 12, left: 34),
            child: Text(
              "Recomended",
              style: GoogleFonts.poppins(
                  fontSize: 15, fontWeight: FontWeight.w600),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 34),
            child: Column(
              children: [
                Container(
                  width: 140,
                  // height: 154,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x3F000000),
                          blurRadius: 14,
                          offset: Offset(0, 4),
                          spreadRadius: -4,
                        )
                      ]),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 80,
                            width: 127,
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                color: Colors.black26),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Nescafe",
                                style: GoogleFonts.poppins(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Category",
                                style: GoogleFonts.poppins(
                                    fontSize: 10, fontWeight: FontWeight.w500),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 4, bottom: 10),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      height: 15,
                                      // width: 46,
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(),
                                          onPressed: () {},
                                          child: Text(
                                            "Detail",
                                            style: GoogleFonts.poppins(
                                                fontSize: 7),
                                          )),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ]),
                )
              ],
            ),
          )
        ]),
      ),
    );
  }
}

class TopSection extends StatelessWidget {
  const TopSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 445,
      decoration: const BoxDecoration(
          color: Color(0xFF37271D),
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(20),
              bottomLeft: Radius.circular(20))),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 49),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  height: 42,
                  width: 42,
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(115, 127, 127, 127)),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Agung Bahtiar',
                        style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                      Text('Wellcome back',
                          style: GoogleFonts.poppins(
                            color: const Color.fromARGB(142, 255, 255, 255),
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
                    decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x3F000000),
                            blurRadius: 15,
                            offset: Offset(4, 4),
                            spreadRadius: 0,
                          )
                        ],
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        image: DecorationImage(
                            image: NetworkImage(
                                "https://via.placeholder.com/143x138"))),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Company",
                          style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        ),
                        Text(
                          "Category",
                          style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          width: 127,
                          child: Text(
                            "Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet...",
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
                                      const Color.fromARGB(255, 119, 224, 180)),
                              onPressed: () {},
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
    );
  }
}
