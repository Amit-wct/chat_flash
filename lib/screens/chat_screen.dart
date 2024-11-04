import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = FirebaseFirestore.instance;
final _auth = FirebaseAuth.instance;

class ChatScreen extends StatefulWidget {
  static String id = 'chat_screen';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  User? loggedInUser;
  String messageText = '';
  final chatController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getCurrentUSer();
  }

  void getCurrentUSer() async {
    final user = await _auth.currentUser;
    if (user != null) {
      loggedInUser = user;
      print(loggedInUser!.email);
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
              
                //Implement logout functionality
                // loggedInUser.
                // _auth.signOut();
                // Navigator.pop(context);
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessageStream(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: chatController,
                      onChanged: (value) {
                        //Do something with the user input.
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      //Implement send functionality.
                      // messageText + loggedInUser.email
                      _firestore.collection('messages').add(
                          {'text': messageText, 'sender': loggedInUser!.email});
                      chatController.clear();
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageStream extends StatelessWidget {
  const MessageStream({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('messages').snapshots(),
        builder: (context, snapshot) {
          List<MessageBubble> messageWigets = [];
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(color: Colors.red),
            );
          }

          final messages = snapshot.data!.docs.reversed;

          for (var msg in messages) {
            final msgText = msg['text'];
            final msgSender = msg['sender'];
            final msgWidget = MessageBubble(
              msgSender: msgSender,
              msgText: msgText,
            );

            messageWigets.add(msgWidget);
          }

          return Expanded(
              child: ListView(
            padding: EdgeInsets.all(8),
            children: messageWigets,
          ));
        });
  }
}

class MessageBubble extends StatelessWidget {
  const MessageBubble({super.key, this.msgSender, this.msgText});

  final msgText, msgSender;

  @override
  Widget build(BuildContext context) {
    bool reciever = _auth.currentUser!.email == msgSender ? true : false;
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            reciever ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            msgSender,
            style: TextStyle(fontSize: 12, color: Colors.black54),
          ),
          Material(
              borderRadius: reciever
                  ? BorderRadius.only(
                      topLeft: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30))
                  : BorderRadius.only(
                      topRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30)),
              elevation: 5,
              color:
                  reciever ? Colors.lightBlueAccent : Colors.lightGreenAccent,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
                child: Text( 
                  msgText,
                  style: TextStyle(
                      fontSize: 15,
                      color: reciever ? Colors.white : Colors.black),
                ),
              )),
        ],
      ),
    );
  }
}
