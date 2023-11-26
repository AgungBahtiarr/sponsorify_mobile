// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sponsorify/data/datasource/remote_register.dart';
import 'package:sponsorify/data/model/register_model.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  Data? user;

  int? statusCode;
  Future getResponse(user) async {
    var res = await RemoteRegister().register(user);
    setState(() {
      statusCode = res;
    });
  }

  bool secure = true;

  String fullName = '';
  String email = '';
  String role = '';
  String password = '';
  bool passwordChecked = true;

  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController roleController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  var items = ['Event Organizer', 'Sponsorship'];
  var dropDownValue = 'Event Organizer';

  final alertSuccess = const SnackBar(content: Text("Register Success"));
  final alertFailed = const SnackBar(content: Text("Register Failed"));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 42),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
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
                controller: fullNameController,
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
                controller: emailController,
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
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: DropdownButtonHideUnderline(
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
                                    color: Colors.black),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              dropDownValue = newValue!;
                            });
                          }),
                    ),
                  )),
              const SizedBox(
                height: 24,
              ),
              TextField(
                obscureText: secure,
                controller: passwordController,
                enabled: true,
                decoration: InputDecoration(
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(right: 25),
                      child: IconButton(
                          onPressed: () {
                            setState(() {
                              secure = !secure;
                            });
                          },
                          icon: const Icon(Icons.remove_red_eye),
                          color: const Color.fromRGBO(170, 174, 182, 100)),
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
                obscureText: secure,
                controller: confirmPasswordController,
                enabled: true,
                decoration: InputDecoration(
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(right: 25),
                      child: IconButton(
                          onPressed: () {
                            setState(() {
                              secure = !secure;
                            });
                          },
                          icon: const Icon(Icons.remove_red_eye),
                          color: const Color.fromRGBO(170, 174, 182, 100)),
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
                    onPressed: () async {
                      setState(() {
                        fullName = fullNameController.text;
                        email = emailController.text;
                        role = dropDownValue;

                        if (passwordController.text ==
                            confirmPasswordController.text) {
                          password = passwordController.text;
                        } else {
                          passwordChecked = false;
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Password Not Match")));
                        }

                        if (dropDownValue == 'Event Organizer') {
                          role = '1';
                        } else if (dropDownValue == 'Sponsorship') {
                          role = '2';
                        }
                      });

                      user = Data(
                          name: fullName,
                          email: email,
                          password: password,
                          idRole: role,
                          profilePhoto: 'ini url');

                      await getResponse(user);
                      if (statusCode == 201 && passwordChecked == true) {
                        setState(() {
                          fullNameController.text = '';
                          emailController.text = '';
                          passwordController.text = '';
                          confirmPasswordController.text = '';
                        });
                        Navigator.pushNamed(context, '/login');
                        ScaffoldMessenger.of(context)
                            .showSnackBar(alertSuccess);
                      } else {
                        setState(() {});
                        ScaffoldMessenger.of(context).showSnackBar(alertFailed);
                      }
                    },
                    child: Text(
                      'Register',
                      style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
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
                    onPressed: () {
                      Navigator.pop(context);
                    },
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
