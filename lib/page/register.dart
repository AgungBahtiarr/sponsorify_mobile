import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 42),
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
                padding: const EdgeInsets.symmetric(vertical: 38),
                child: SizedBox(
                    width: 230,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hey King,",
                          style: GoogleFonts.poppins(
                              fontSize: 36, fontWeight: FontWeight.w700),
                        ),
                        Text(
                          "Sign Up Now",
                          style: GoogleFonts.poppins(
                              fontSize: 36, fontWeight: FontWeight.w700),
                        ),
                      ],
                    )),
              ),
              TextField(
                enabled: true,
                decoration: InputDecoration(
                    suffixIcon: const Padding(
                      padding: EdgeInsets.only(right: 25),
                      child: Icon(Icons.person,
                          color: Color.fromRGBO(170, 174, 182, 100)),
                    ),
                    prefix: const SizedBox(
                      width: 25,
                    ),
                    hintStyle: GoogleFonts.poppins(
                        fontSize: 16, fontWeight: FontWeight.w500),
                    hintText: 'Full Name',
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
                height: 24,
              ),
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
                height: 24,
              ),
              Container(
                  height: 58,
                  width: 400,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          color: const Color.fromRGBO(196, 201, 210, 100),
                          width: 2)),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32),
                    child: RoleDropDown(),
                  )),
              const SizedBox(
                height: 24,
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
              const SizedBox(
                height: 18,
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
                    hintText: 'Confirm Password',
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
                height: 18,
              ),
              Center(
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 124, vertical: 18),
                        backgroundColor: const Color(0xff372E1D)),
                    onPressed: () {},
                    child: Text(
                      'Register',
                      style: GoogleFonts.poppins(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    )),
              ),
              const SizedBox(
                height: 38,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Have an account ?',
                    style: GoogleFonts.poppins(
                        color: const Color(0xffAAAEB6),
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Login',
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

class RoleDropDown extends StatefulWidget {
  const RoleDropDown({super.key});

  @override
  State<RoleDropDown> createState() => _RoleDropDownState();
}

class _RoleDropDownState extends State<RoleDropDown> {
  var items = ['Event Organizer', 'Sponsorship'];
  var dropDownValue = 'Event Organizer';
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton(
          value: dropDownValue,
          items: items.map((String items) {
            return DropdownMenuItem(
              value: items,
              child: Text(
                items,
                style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: const Color.fromARGB(156, 44, 44, 44)),
              ),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              dropDownValue = newValue!;
            });
          }),
    );
  }
}
