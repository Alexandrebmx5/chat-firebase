import 'package:chat_firebase/screens/chat_messages.dart';
import 'package:chat_firebase/screens/text_composer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:animate_do/animate_do.dart';

class ChatScreen extends StatefulWidget {

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _sendMessage({String text}) async{

    Map<String, dynamic> data = {
      'uid': 'Alexandre Soares',
      'time' : Timestamp.now(),
      'type': 'sender'
    };

    if(text !=null) data['text'] = text;

    FirebaseFirestore.instance.collection('messages').add(data);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/fundo.png'),
                fit: BoxFit.cover
            )
        ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          toolbarHeight: 176,
          flexibleSpace: Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Column(
              children: [
                Container(
                    height: 30,
                    child: SvgPicture.asset('assets/logo.svg', color: Colors.white,)
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: Navigator.of(context).pop,
                            icon: Icon(Icons.arrow_back, color: Color(0xff5C2E85), size: 30,)
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(
                              backgroundColor: Color(0xff5C2E85),
                              maxRadius: 30,
                              backgroundImage: AssetImage('assets/img_doutor.png'),
                            ),
                            SizedBox(width: 8),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Dr. João Peixoto',
                                  style: TextStyle(
                                      color: Color(0xff5C2E85),
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                                Text('Clínico Geral - CRM 1120',
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                        IconButton(
                            onPressed: (){},
                            icon: Icon(Icons.more_vert, color: Color(0xff5C2E85), size: 30,)
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        key: _scaffoldKey,
        body: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Colors.grey.withAlpha(30)))
          ),
          child: Stack(
            children: [
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('messages').orderBy('time').snapshots(),
                builder: (context, snapshot){
                  switch(snapshot.connectionState){
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    default:
                      List<DocumentSnapshot> documents =
                      snapshot.data.docs.reversed.toList();

                      return ListView.builder(
                          padding: EdgeInsets.only(bottom: 75),
                          itemCount: documents.length,
                          reverse: true,
                          itemBuilder: (context, index){
                            return documents[index].data()['type'] == 'sender' ? FadeInRight(
                              child: ChatMessage(
                                  documents[index].data()
                              ),
                            ) : FadeInLeft(
                              child: ChatMessage(
                                  documents[index].data()
                              ),
                            );
                          }
                      );
                  }
                },
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(top: BorderSide(color: Colors.grey.withAlpha(30)))
                    ),
                    height: 70,
                    child: TextComposer(sendMessage: _sendMessage)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
