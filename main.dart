import 'package:letuschat/Animation/FadeAnimation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:letuschat/ChatWindow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

void main() => runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    )
);

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController txtUsername = new TextEditingController();
  TextEditingController txtPassword = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: 400,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/background.png'),
                        fit: BoxFit.fill
                    )
                ),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      left: 35,
                      width: 80,
                      height: 200,
                      child: FadeAnimation(1, Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/images/light-1.png')
                            )
                        ),
                      )),
                    ),
                    Positioned(
                      left: 165,
                      width: 80,
                      height: 150,
                      child: FadeAnimation(1.3, Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/images/light-2.png')
                            )
                        ),
                      )),
                    ),
                    Positioned(
                      right: 40,
                      top: 40,
                      width: 80,
                      height: 150,
                      child: FadeAnimation(1.5, Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/images/clock.png')
                            )
                        ),
                      )),
                    ),
                    Positioned(
                      child: FadeAnimation(1.6, Container(
                        margin: EdgeInsets.only(top: 100),
                        child: Center(
                          child: Text("Welcome", style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold, letterSpacing: 3.0,
                              fontFamily: 'Lobster'),),
                        ),
                      )),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(30.0),
                child: Column(
                  children: <Widget>[
                    FadeAnimation(1.8, Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromRGBO(143, 148, 251, .2),
                                blurRadius: 20.0,
                                offset: Offset(0, 10)
                            )
                          ]
                      ),
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(color: Colors.grey[100]))
                            ),
                            child: TextField(
                              controller: txtUsername,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Enter username",
                                hintStyle: TextStyle(color: Colors.grey[400]),
                              ),
                              autofocus: true,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(8.0),
                            child: TextField(
                              controller: txtPassword,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Enter password",
                                  hintStyle: TextStyle(color: Colors.grey[400])
                              ),
                            ),
                          )
                        ],
                      ),
                    )),
                    SizedBox(height: 30,),
                    FadeAnimation(2, Container(
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                              colors: [
                                Color.fromRGBO(143, 148, 251, 1),
                                Color.fromRGBO(143, 148, 251, .6),
                              ]
                          )
                      ),
                      child: Center(
                          child: ButtonTheme(
                            height: 50,
                            minWidth: 400,
                            child: FlatButton(
                              onPressed: () async {
                                if (txtUsername.text != '' && txtPassword.text != '') {
                                  validateUser();
                                }
                                else {
                                  Fluttertoast.showToast(
                                      msg: "Please fill both the fields!",
                                      gravity: ToastGravity.BOTTOM,
                                      backgroundColor: Colors.black,
                                      textColor: Colors.white
                                  );
                                }
                              },
                              child: Text(
                                'Login/Register',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    letterSpacing: 1.5,
                                    fontFamily: 'LexendTera'
                                ),
                              ),
                            ),
                          )
                      ),
                    )),
                  ],
                ),
              )
            ],
          ),
        )
    );
  }

  void validateUser() async {
    String username = txtUsername.text;
    String password = txtPassword.text;
    Response response = await get("http://165.22.14.77:8080/Narsi/ChatRoom/register.jsp?username=" + username + "&password=" + password);
    String responseFromServer = response.body.trim();
    if (responseFromServer == 'Logged') {
      Fluttertoast.showToast(
          msg: "Login successful!",
          gravity: ToastGravity.BOTTOM
      );
      openChatWindow(username);
    }
    else if (responseFromServer == 'Registered') {
      String username = txtUsername.text;
      Fluttertoast.showToast(
          msg: 'Registration successful!',
          gravity: ToastGravity.BOTTOM
      );
      openChatWindow(username);
    }
    else if (responseFromServer == 'Invalid') {
      Fluttertoast.showToast(
          msg: "Invalid credentials!",
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black,
          textColor: Colors.white
      );
    }
  }
  void openChatWindow(String username) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ChatWindow(username: username)
        )
    );
  }
}