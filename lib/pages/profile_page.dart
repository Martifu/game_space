import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  String usuario;
  String email;

  void initState() { 
    super.initState();
    _cargarPrefs();
    
    
  }

   _cargarPrefs() async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
     //logeado = prefs.getString('logeado');
     usuario = prefs.getString('usuario');
     email = prefs.getString('email');
     setState(() {
       
     });
      //print(logeado.toString() + usuario +email);
   }
  @override
  Widget build(BuildContext context) {

    final _size = MediaQuery.of(context).size;
    final Color primayColor = Color(0xff5c6cfc);
    final Color secondaryColor = Color(0xff0ebc7d);
    final Color primaryDark = Color(0xff2d304e);
    final Color lightColor = Color(0xffededf1);
   print(usuario);
    return Scaffold(
      backgroundColor: lightColor,
      body: (usuario == null) ? Center(
          child: RaisedButton(onPressed: (){
            Navigator.of(context).pushNamed('login');
          },
            child: Text('Inicia Sesión', style: TextStyle(color: lightColor),),
            color: primayColor,
            
          ),
        ) : 
        Stack(
        children: <Widget>[
          Container(
            height: _size.height / 3,
            decoration: BoxDecoration(
            color: primaryDark,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40),)
            ),
          ),
          Padding(
            padding:  EdgeInsets.only(top: _size.height / 8),
            child: Align(
              alignment: Alignment.topCenter,
              child: Text('Perfil', style: GoogleFonts.russoOne(
                fontSize: 35,
                 color: lightColor
              ),),
            ),
          ),
          Padding(
            padding:  EdgeInsets.only(top: _size.height / 4.5),
            child: Align(
              alignment: Alignment.topCenter,
              child:  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: primayColor, width: 5),
                            shape: BoxShape.circle
                          ),
                          child: CircleAvatar(
                            backgroundImage: AssetImage('assets/images/profile.png'),
                            maxRadius: _size.width / 6,
                            
                          ),
                        ),
                      ],
                    ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: _size.height /2.2),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                    mainAxisAlignment: MainAxisAlignment.start ,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('Usuario:', style: TextStyle(fontWeight: FontWeight.bold),)
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('$usuario', style: GoogleFonts.russoOne(
                            fontSize: 20
                          ),)
                        ],
                      ),
                      SizedBox(height: 40,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('Usuario:', style: TextStyle(fontWeight: FontWeight.bold),)
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(width: 45,),
                          Expanded(
                              child: Text('$email', style: GoogleFonts.russoOne(
                              fontSize: 20
                            ),),
                          )
                        ],
                      ),
                      SizedBox(height: 80,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                         RaisedButton(
                           color: primayColor,
                           onPressed: (){
                            _borrarPreferencias();
                            Navigator.of(context).pushReplacementNamed('login');
                            
                          },
                            child: Row(
                              children: <Widget>[
                                Text('Cerrar sesión ', style: TextStyle(color: Colors.white),),
                                Icon(Icons.exit_to_app, size: 15, color: Colors.white,)
                              ],
                            ),
                         )
                        ],
                      ),
                    ],
                  ),
            ),
          ),
        ],
      ) 
        
    );

  }

 _borrarPreferencias() async {
   SharedPreferences prefs = await SharedPreferences.getInstance();
   prefs.clear();
 }
}