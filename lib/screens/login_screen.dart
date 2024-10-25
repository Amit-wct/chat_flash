import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flash_chat/widgets/push_button.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  String? email;
  String? password;
  bool showSpinner = false;

  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Hero(
                  tag:'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
                SizedBox(
                  height: 48.0,
                ),
                TextField(
                   textAlign: TextAlign.center,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    email = value;
          
                  },
                  decoration: KTextFielDecoration.copyWith(hintText: "Enter your Email"),
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextField(
                   textAlign: TextAlign.center,
                   obscureText: true,
                  onChanged: (value) {
                    //Do something with the user input.
                    password = value;
                  },
                  decoration: KTextFielDecoration.copyWith(hintText: "Enter your Password")
                ),
                SizedBox(
                  height: 24.0,
                ),
               
                PushButton(title: "Log In", colour: Colors.lightBlueAccent, onClick: () async{
                  setState(() {
                    // showSpinner = true;
                  });
                 try{
                  // final user = await  _auth.signInWithEmailAndPassword(email: email!, password: password!);
                  
                  // final user = await _auth.verifyPhoneNumber(email!);
          
                  await FirebaseAuth.instance.verifyPhoneNumber(
            phoneNumber: email!,
            verificationCompleted: (PhoneAuthCredential credential) {print('lello1'); setState(() {
              showSpinner = false;
            });},
            verificationFailed: (FirebaseAuthException e) {print(e);},
            codeSent: (String verificationId, int? resendToken) {print('lello2');},
            codeAutoRetrievalTimeout: (String verificationId) {print('lello3');},);
          // );
          //                if(user!=null){
          //                 Navigator.pushNamed(context, ChatScreen.id);
          //                }
          
                //  setState(() {
                //    showSpinner = false;
                //  });
                 }
                 catch (e){
                  print(e);
                 }
                 
                 
                 }),
          
                 PushButton(title: "Forgot Password", colour: Colors.lightBlueAccent, onClick: () async{
                 try{
                  final user = await  _auth.sendPasswordResetEmail(email: email!);
                 
                 }
                 catch (e){
                  print(e);
                 }
          
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
