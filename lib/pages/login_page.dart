import 'package:flutter/material.dart';
import 'package:gamespace/api/providers/usuario_provider.dart';
import 'package:gamespace/widgets/circle.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    
    final size = MediaQuery.of(context).size;
    final Color primayColor = Color(0xff5c6cfc);
    final Color secondaryColor = Color(0xff0ebc7d);
    final Color primaryDark = Color(0xff2d304e);
    final Color lightColor = Color(0xffededf1);
    
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
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    width: size.width,
                    child: Column(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Container( 
                              margin: EdgeInsets.only(top:size.width*.6),
                              child: Row(
                                children: <Widget>[
                                  Text('Inicia\nSesión', style: GoogleFonts.russoOne(
                                    fontSize: 31
                                  ),)
                                ],
                              ),
                            ),
                            SizedBox(height: 30,),
                           LoginForm(),
                           Padding(
                             padding:  EdgeInsets.only(top:50.0),
                             child: Align(

                                alignment: Alignment.bottomRight,
                                child: FlatButton(onPressed: (){Navigator.of(context).pushNamed('home');},
                                child: Text('Seguir comprando', style: TextStyle(color: lightColor),),
                                color: primayColor,
                                
                                ),
                              ),
                           )
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

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
    final _formKey = GlobalKey<FormState>();

  final Color primayColor = Color(0xff5c6cfc);
    final Color secondaryColor = Color(0xff0ebc7d);
    final Color primaryDark = Color(0xff2d304e);
    final Color lightColor = Color(0xffededf1);

    final usuarioProvider = UserProvider();

    bool validando = false;
    bool iniciado = false;

    String user = '';
    String pass = '';
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Stack(
      children: <Widget>[
        
        Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 0),
        child: Column(
          children: <Widget>[
            
             TextFormField(
              decoration: InputDecoration(
                border: new OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                  const Radius.circular(8.0),
                ),
                borderSide: new BorderSide(
                  color: Colors.black,
                  width: 1.0,
                ),
              ),
              labelText: 'Correo electrónico',
              labelStyle:  TextStyle(color: primaryDark, fontSize: 15.0)),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Por favor llena este campo';
                }
              },
              onChanged: (val) => user = val,
            ),
            SizedBox(height:20),
            TextFormField(
              obscureText: true,
              decoration: InputDecoration(
                border: new OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                  const Radius.circular(8.0),
                ),
                borderSide: new BorderSide(
                  color: Colors.black,
                  width: 1.0,
                ),
              ),
              labelText: 'Contraseña',
              labelStyle:  TextStyle(color: primaryDark, fontSize: 15.0)),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Por favor llena este campo';
                }
              },
              onChanged: (val) => pass = val,
            ),
            AbsorbPointer(
              absorbing: validando,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: GestureDetector(
                        onTap: (){
                          if (_formKey.currentState.validate()) {
                            
                            setState(() {
                              validando = true;
                            });
                            _login(user,pass);
                            //Navigator.of(context).pushNamed('pago', arguments: compra);

                          }
                        // Navigator.of(context).pushNamed('confirm_sell');
                        },
                             child: Container(
                               decoration: BoxDecoration(
                                 color: primayColor,
                               ),
                               height: 55,
                               width: double.infinity,
                           child: Center(child: Text('iniciar', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15 ))),
                          ),
                      ),
              ),
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text('¿No tienes cuenta?', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: primaryDark),),
                GestureDetector(
                  onTap: (){
                    Navigator.of(context).pushNamed('register');
                  },
                  child: Text('Crea una aquí',style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: primayColor),),
                )
              ],
            ),
            
          ],
        ),
      ),
    ),
    Visibility(
          visible: validando,
            child: Align(
          alignment: Alignment.center,
          child: Container(
            width: size.width /4,
            height: size.height/7,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20)
            ),
            child: Center(
              child: CircularProgressIndicator()
            ),
          ),
        ),
        ),
        
      ],
    );
    
    
  }

   _showDialog(req) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(req['status']),
          content: Text(req['message'].toString()),
          elevation: 5,
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Ok"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

   _login(String user, String pass) async {
     
     
     final res = await usuarioProvider.login(user, pass);

     if (res['message'] == 'Invalid password') {
       setState(() {
       validando = false;
        });
       _showDialog(res);
     } else if (res['message'] == 'user not found') {
       setState(() {
       validando = false;
        });
       _showDialog(res);
     } else {
       setState(() {
       validando = false;
       iniciado = true;
        });
       SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('usuario', res['data']['username']);
        prefs.setString('email', res['data']['email']);
        prefs.setString('logeado','logeado');
        print( prefs.getString('usuario'));
        Navigator.of(context).pop();
        Navigator.of(context).pushReplacementNamed('home');
     }

   }
}