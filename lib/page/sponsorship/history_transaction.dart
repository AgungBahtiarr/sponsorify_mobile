import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sponsorify/data/datasource/remote_transaction.dart';
import 'package:sponsorify/data/model/transaction_model.dart';

class HistoryTransaction extends StatefulWidget {
  const HistoryTransaction({super.key});

  @override
  State<HistoryTransaction> createState() => _HistoryTransactionState();
}

class _HistoryTransactionState extends State<HistoryTransaction> {
  String? token;
  int? idSponsorship;
  List<Transaction> rawTransactions = [];
  List<Transaction> transactions = [];

  Future getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString('token');
      idSponsorship = prefs.getInt('id_sponsorship');
    });
    final response = await RemoteTransaction().getTransaction(token);
    setState(() {
      rawTransactions = response;
      for (var element in rawTransactions) {
        if (element.idSponsorship == idSponsorship) {
          transactions.add(element);
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();

    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 42),
          child: Column(children: [
            Text(
              "Transaction History",
              style: GoogleFonts.poppins(
                  fontSize: 24, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 32,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 1.2,
              child: ListView.builder(
                  itemCount: transactions.length,
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
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                width: 78,
                                height: 78,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            'http://10.0.2.2:8080/${transactions[index].event!.profilePhoto}')),
                                    shape: BoxShape.circle,
                                    color: Color(0xffD9D9D9)),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 140,
                                    child: Text(
                                      overflow: TextOverflow.ellipsis,
                                      "${transactions[index].event!.name}",
                                      style: GoogleFonts.poppins(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600),
                                    ),
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
                                              'idDetailEventTransaction',
                                              transactions[index].event!.id!);
                                          prefs.setInt(
                                              'idDetailProposalTransaction',
                                              transactions[index]
                                                  .proposal!
                                                  .id!);
                                          prefs.setInt('idDetailTransaction',
                                              transactions[index].id!);
                                          // ignore: use_build_context_synchronously
                                          Navigator.pushNamed(
                                              context, '/detail_transaction');
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
      ),
    );
  }
}
