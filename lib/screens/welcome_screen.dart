import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flash_chat/widgets/button.dart';
import 'package:flash_chat/widgets/push_button.dart';
import 'package:flutter/material.dart';
import 'login_screen.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = 'welcome_screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin{

  late AnimationController controller;
  late Animation animation;
  double opacity = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(duration: Duration(seconds: 1), vsync: this);
  //   animation = CurvedAnimation(parent: controller, curve: Curves.decelerate);
    controller.forward();

  //   animation.addStatusListener((status) { 
  //     if(animation.status == AnimationStatus.completed){
  //       controller.reverse(from:1.0);
  //     }
  //     else if( animation.status == AnimationStatus.dismissed){
  //       controller.forward();
  //     }
  //   });
    controller.addListener(() {print(animation.value); setState(() {
     
    });});
  // }

  
  animation = ColorTween(begin: Colors.blue, end: Colors.white).animate(controller);
  }
  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    // child: Image.asset('images/logo.png'),
                    child: Icon(Icons.bolt, color: Colors.red,size:50 ,),
                    // height: animation.value*50,
                  ),
                ),
                DefaultTextStyle(
    style: const TextStyle(
      fontSize: 24.0,
      // fontFamily: 'Agne',
      color: Colors.black
    ),
child:
               AnimatedTextKit(
                animatedTexts:[
                 TypewriterAnimatedText( 'Flash Chat '),
                 
                
                ]),
                ),
              ],

              
            ),
            SizedBox(
              height: 48.0,
            ),
          
            PushButton(colour:Colors.lightBlueAccent , title: 'Login', onClick: () {
                    //Go to login screen.
                    Navigator.pushNamed(context, LoginScreen.id);
                  } ,),
            
             PushButton(colour:Colors.blueAccent , title: 'Register', onClick: () {
                    //Go to login screen.
                    Navigator.pushNamed(context, RegistrationScreen.id);
                  } ,),
           
          ],
        ),
      ),
    );
  }
}


