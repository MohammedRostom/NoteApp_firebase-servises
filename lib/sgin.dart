import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class sgin extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<sgin> {
  GlobalKey<FormState> keyform = GlobalKey();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repasswordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoading = false;

  void sgin() async {
    final String username = _usernameController.text;
    final String password = _passwordController.text;
    final String repassword = _repasswordController.text;

    if (username.isNotEmpty && password.isNotEmpty && repassword.isNotEmpty) {
      setState(() {
        _isLoading = true;
      });

      try {
        UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
          email: username,
          password: password,
        );

        if (userCredential.user!.emailVerified == false) {
          await userCredential.user!.sendEmailVerification();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Email not verified. Verification email sent.'),
              duration: Duration(seconds: 2),
            ),
          );
        }
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(
        //     content: Text('تم التسجيل بنجاح'),
        //     duration: Duration(seconds: 2),
        //   ),
        // );
        gotologin();

        // Navigate to the next screen after successful login
      } catch (e) {
        // Handle login errors here
        print(e);
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    } else if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('لا يمكن التسجيل والحقول فارغة '),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  voidfunction() {
    if (_isLoading == true) {
      return LinearProgressIndicator();
    } else {
      return Text("sgin");
    }
  }

  void gotologin() {
    Duration delayDuration =
        Duration(seconds: 2); // Adjust the duration as needed

    Future.delayed(delayDuration, () {
      Navigator.pushReplacementNamed(context, 'log');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: keyform,
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'sgin',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              TextFormField(
                validator: (value) {
                  if (value == "" || value!.isEmpty) {
                    return "انت عبيط يسطا مفيش حلجة مكتوبة ";
                  }

                  ;
                },
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                validator: (value) {
                  if (value == "" || value!.isEmpty) {
                    return "انت عبيط يسطا مفيش حلجة مكتوبة ";
                  }
                },
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              SizedBox(height: 16),
              Expanded(
                child: TextFormField(
                  validator: (value) {
                    if (value == "" || value!.isEmpty) {
                      return "انت عبيط يسطا مفيش حلجة مكتوبة ";
                    }

                    ;
                  },
                  controller: _repasswordController,
                  decoration: InputDecoration(
                    labelText: 'rePassword',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                  onPressed: () {
                    if (keyform.currentState!.validate()) sgin();
                  },
                  child: voidfunction()),
            ],
          ),
        ),
      ),
    );
  }
}
