import 'package:flutter/material.dart';
import 'package:gamespace/widgets/circle.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    
    final size = MediaQuery.of(context).size;
    
    return Scaffold(
        body:Container(
          color: Color(0xffededf1),
          width: size.width,
          height: size.height,
          child: Stack(
            children: <Widget>[

              Positioned(
                right: -size.width *0.35,
                top:  -size.width *0.45, 
                child: Circle(
                radius: size.width * 0.52,
                colores:[
                  Color(0xff2d304e),
                  Color(0xff5c8cfa)
                ],
              )
              ),
              Positioned(
                left: -size.width *0.15,
                top:  -size.width *0.34, 
                child: Circle(
                radius: size.width * 0.35,
                colores:[
                  Color(0xff5c6cfc),
                  Color(0xff5c8cfa)
                ],
              )
              ),
              SingleChildScrollView(
                child: SafeArea(
                  child:Container(
                    width: size.width,
                    child: Column(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Container( 
                              width: 90,
                              height: 90,
                              margin: EdgeInsets.only(top:size.width*.3),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [BoxShadow(color: Colors.black26,blurRadius: 26)]
                              )
                            ),
                            SizedBox(height: 30,),
                            Text('data')
                          ],
                        )
                      ],

                    ) ,
                  ) 
                  ),
              )
            ],
          ),
        )
    );
  }
}