import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 52),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Color(0xffE3E3E3)),
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.arrow_back),
                  )),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 50),
                child: SizedBox(
                    width: 198,
                    child: Text(
                      'Hay King, Login Now',
                      style: GoogleFonts.poppins(
                          fontSize: 36, fontWeight: FontWeight.bold),
                    )),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  TextField(
                    enabled: true,
                    decoration: InputDecoration(
                        suffixIcon: const Padding(
                          padding: EdgeInsets.only(right: 25),
                          child: Icon(Icons.email,
                              color: Color.fromRGBO(170, 174, 182, 100)),
                        ),
                        prefix: const SizedBox(
                          width: 25,
                        ),
                        hintStyle: GoogleFonts.poppins(
                            fontSize: 16, fontWeight: FontWeight.w500),
                        hintText: 'Email',
                        border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(
                                color: Color.fromRGBO(196, 201, 210, 100),
                                width: 2)),
                        enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(
                                color: Color.fromRGBO(196, 201, 210, 100),
                                width: 2)),
                        focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(
                                color: Color.fromRGBO(196, 201, 210, 100),
                                width: 2))),
                  ),
                  const SizedBox(
                    height: 28,
                  ),
                  TextField(
                    enabled: true,
                    decoration: InputDecoration(
                        suffixIcon: const Padding(
                          padding: EdgeInsets.only(right: 25),
                          child: Icon(Icons.remove_red_eye,
                              color: Color.fromRGBO(170, 174, 182, 100)),
                        ),
                        prefix: const SizedBox(
                          width: 25,
                        ),
                        hintStyle: GoogleFonts.poppins(
                            fontSize: 16, fontWeight: FontWeight.w500),
                        hintText: 'Password',
                        border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(
                                color: Color.fromRGBO(196, 201, 210, 100),
                                width: 2)),
                        enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(
                                color: Color.fromRGBO(196, 201, 210, 100),
                                width: 2)),
                        focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(
                                color: Color.fromRGBO(196, 201, 210, 100),
                                width: 2))),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    child: Text(
                      'Forgot Password?',
                      style: GoogleFonts.poppins(
                          fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              Center(
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 137, vertical: 18),
                        backgroundColor: const Color(0xff372E1D)),
                    onPressed: () {},
                    child: Text(
                      'Login',
                      style: GoogleFonts.poppins(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    )),
              ),
              const SizedBox(
                height: 164,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Haven’t an account ?',
                    style: GoogleFonts.poppins(
                        color: const Color(0xffAAAEB6),
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Register',
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}