import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoading = false;

  void _login() async {
    if (_formKey.currentState!.validate()) {
      final String username = _usernameController.text;
      final String password = _passwordController.text;

      setState(() {
        _isLoading = true;
      });

      try {
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: username,
          password: password,
        );

        print(userCredential);
        if (userCredential.user!.emailVerified == true) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Logged in successfully and emailVerified '),
              duration: Duration(seconds: 2),
            ),
          );

          navigateToHome();
        } else if (userCredential.user!.emailVerified == false) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('NOT emailVerified '),
              duration: Duration(seconds: 2),
            ),
          );
        }
      } catch (e) {
        print(e);
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void navigateToHome() {
    Duration delayDuration = Duration(seconds: 2);

    Future.delayed(delayDuration, () {
      Navigator.pushReplacementNamed(context, 'home');
    });
  }

  Future<UserCredential> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Check if the user canceled the sign-in flow
      if (googleUser == null) {
        throw Exception('Google sign-in was canceled.');
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      // Handle the sign-in error
      print('Sign-in with Google failed: $e');
      // You can display an error message to the user or perform other actions as needed
      throw Exception('Failed to sign in with Google. Please try again later.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _isLoading,
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(20),
          child: Form(
            autovalidateMode: AutovalidateMode.always,
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Login',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a username';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _login,
                  child: Text("login"),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, 'sgin');
                  },
                  child: Text("Sign Up"),
                ),
                IconButton(
                  onPressed: () async {
                    signInWithGoogle();
                  },
                  icon: Text("Sign Up"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



// class CustomLoadingWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return CircularProgressIndicator(
//       valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//     );
//   }
// }
