import 'package:flash_chat/screens/login_screen.dart';
import 'package:flutter/material.dart';

class PButton extends StatelessWidget {
  const PButton({super.key, required this.label , required this.cl,required this.func});
  final String label;
  final cl;
  final func;
  

  @override
  Widget build(BuildContext context) {
    return Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                elevation: 5.0,
                color: cl,
                borderRadius: BorderRadius.circular(30.0),
                child: MaterialButton(
                  onPressed: func,
                  minWidth: 200.0,
                  height: 42.0,
                  child: Text(
                    label,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            );
  }
}