// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sponsorify/data/datasource/remote_login.dart';
import 'package:sponsorify/data/datasource/remote_sponsorship.dart';
import 'package:sponsorify/data/model/login_model.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  LoginModel? user;
  LoginModel? data;

  Future<LoginModel> login(user) async {
    final response = await RemoteLogin().login(user);
    return response;
  }

  bool isSecure = true;

  String? token;
  bool? statusCode;
  String email = '';
  String password = '';

  int? count;
  bool? isHaveSponsorship;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> setPref([token, userName, urlPhoto, authId, role]) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
    prefs.setInt('role', role);
    prefs.setString('userName', userName);
    prefs.setString('urlPhoto', urlPhoto);
    prefs.setInt('authId', authId);
  }

  Future getSponsorshipCount(id) async {
    int response = await RemoteSponsorship().count(id);
    setState(() {
      count = response;
      if (count != 0) {
        Navigator.pushReplacementNamed(context, '/sponsorship_layout');
      } else {
        Navigator.pushReplacementNamed(context, '/add_sponsorship');
      }
    });
  }

  final alertSuccess = const SnackBar(
      backgroundColor: Colors.green, content: Text("Login Success"));
  final alertFailed = const SnackBar(
      backgroundColor: Colors.red, content: Text("Login Failed"));

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
                    height: 28,
                  ),
                  TextField(
                    obscureText: isSecure,
                    controller: passwordController,
                    enabled: true,
                    decoration: InputDecoration(
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(right: 14),
                          child: IconButton(
                              onPressed: () {
                                setState(() {
                                  isSecure = !isSecure;
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
                    onPressed: () async {
                      setState(() {
                        email = emailController.text;
                        password = passwordController.text;
                        user = LoginModel(email: email, password: password);
                      });

                      await login(user).then((value) {
                        setState(() {
                          data = value;
                        });
                      });

                      if (data!.success == true) {
                        if (data!.role == 1) {
                          setState(() {
                            emailController.text = '';
                            passwordController.text = '';
                            setPref(
                                data!.token,
                                data!.user!.name,
                                data!.user!.profilePhoto,
                                data!.user!.id,
                                data!.role);
                          });
                          debugPrint(data!.user!.name);
                          ScaffoldMessenger.of(context)
                              .showSnackBar(alertSuccess);
                          Navigator.pushReplacementNamed(
                              context, '/event_layout');
                        } else if (data!.role == 2) {
                          setState(() {
                            emailController.text = '';
                            passwordController.text = '';
                            setPref(data!.token, data!.role);
                          });
                          await getSponsorshipCount(data!.user!.id);
                        }
                        ScaffoldMessenger.of(context)
                            .showSnackBar(alertSuccess);
                      } else {
                        setState(() {
                          emailController.text = '';
                          passwordController.text = '';
                        });
                        ScaffoldMessenger.of(context).showSnackBar(alertFailed);
                      }
                    },
                    child: Text(
                      'Login',
                      style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
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
                    onPressed: () {
                      Navigator.pushNamed(context, '/register');
                    },
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
