import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:institute_objectbox/model/student.dart';
import 'package:institute_objectbox/repository/student_repo.dart';
import 'package:institute_objectbox/screen/register.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dashboard.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const String route = "loginScreen";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Student? student;
  bool mustLogin = false;
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController(text: 'kiran');
  final _passwordController = TextEditingController(text: 'kiran123');

  @override
  initState() {
    Future.delayed(const Duration(seconds: 2), () => getLoginSession());
    super.initState();
  }

  _setDataToSharedPref(String key, String value) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(key, value);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  // _removeLoginSession(String key) async {
  //   try {
  //     final SharedPreferences prefs = await SharedPreferences.getInstance();
  //     await prefs.remove(key);
  //   } catch (e) {
  //     debugPrint(e.toString());
  //   }
  // }

  Future<String?> _getDataToSharedPref(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? student = prefs.getString(key);
    return student;
  }

  _login() async {
    final student = await StudentRepositoryImpl()
        .loginStudent(_usernameController.text, _passwordController.text);
    if (student != null) {
      _setDataToSharedPref("student", student.username);
      _goToAnotherPage();
    } else {
      _showMessage();
    }
  }

  _goToAnotherPage() {
    Navigator.pushNamed(context, DashboardScreen.route);
  }

  _showMessage() {
    MotionToast.error(description: const Text('Invalid username or password'))
        .show(context);
  }

  void getLoginSession() async {
    String? username = await _getDataToSharedPref('student');
    final students = await StudentRepositoryImpl().getStudents();
    for (Student s in students) {
      if (s.username == username) {
        student = s;
        break;
      }
    }
    if (student != null) {
      _goToAnotherPage();
    } else {
      setState(() {
        mustLogin = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: mustLogin
            ? Form(
                key: _formKey,
                child: Center(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        children: [
                          SvgPicture.asset(
                            'assets/svg/logo.svg',
                            height: 200,
                            width: 200,
                          ),
                          const SizedBox(height: 8),
                          TextFormField(
                            controller: _usernameController,
                            onSaved: (newValue) {
                              setState(() {
                                _usernameController.text = newValue!;
                              });
                            },
                            decoration: const InputDecoration(
                              labelText: 'Username',
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter username';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          TextFormField(
                            obscureText: true,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Password',
                            ),
                            controller: _passwordController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter password';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 8),
                          ElevatedButton(
                            // style: ElevatedButton.styleFrom(
                            //   backgroundColor: Colors.green[400],
                            //   shape: RoundedRectangleBorder(
                            //     borderRadius: BorderRadius.circular(30.0),
                            //   ),
                            // ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _login();
                              }
                            },
                            child: const SizedBox(
                              height: 50,
                              child: Center(
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: "Brand Bold",
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          ElevatedButton(
                            // style: ElevatedButton.styleFrom(
                            //   shape: RoundedRectangleBorder(
                            //     borderRadius: BorderRadius.circular(30.0),
                            //   ),
                            // ),
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, RegisterScreen.route);
                            },
                            child: const SizedBox(
                              height: 50,
                              child: Center(
                                child: Text(
                                  'Register',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: "Brand Bold",
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            : Container(
                height: double.infinity,
                width: double.infinity,
                alignment: Alignment.center,
                child: const CircularProgressIndicator(),
              ),
      ),
    );
  }
}
