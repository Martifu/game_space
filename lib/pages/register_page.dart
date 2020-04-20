import 'package:flutter/material.dart';
import 'package:gamespace/api/providers/usuario_provider.dart';
import 'package:gamespace/widgets/circle.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
                                  Text('Registrate', style: GoogleFonts.russoOne(
                                    fontSize: 31
                                  ),)
                                ],
                              ),
                            ),
                            SizedBox(height: 30,),
                           RegisterForm()
                          ],
                        )
                      ],

                    ) ,
                  ) 
                  ),
              ),
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    onTap: (){
                      Navigator.of(context).pop();
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.white.withOpacity(.2),
                      child: Icon(LineIcons.close, color: primaryDark,),
                    ),
                  )
                ),
              ),
            ],
          ),
        )
    );
  }
}

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
    final _formKey = GlobalKey<FormState>();

  final Color primayColor = Color(0xff5c6cfc);
    final Color secondaryColor = Color(0xff0ebc7d);
    final Color primaryDark = Color(0xff2d304e);
    final Color lightColor = Color(0xffededf1);

    final usuarioProvider = UserProvider();

    bool validando = false;

    String user = '';
    String email = '';
    String pass = '';
    String confirmPass = '';
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
              labelText: 'Usuario',
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
              labelText: 'Email',
              labelStyle:  TextStyle(color: primaryDark, fontSize: 15.0)),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Por favor llena este campo';
                }
              },
              onChanged: (val) => email = val,
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
              labelText: 'Confirma la contraseña',
              labelStyle:  TextStyle(color: primaryDark, fontSize: 15.0)),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Por favor llena este campo';
                  
                } else if (value!=pass) {
                    return 'Las contraseñas no coinciden';
                  }
              },
              onChanged: (val) => confirmPass = val,
            ),
            AbsorbPointer(
              absorbing: validando,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: GestureDetector(
                        onTap: (){
                          if (_formKey.currentState.validate()) {
                            
                            setState(() {
                              validando = true;
                            });
                            _register(user, pass, email);
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
                           child: Center(child: Text('Registrar', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15 ))),
                          ),
                      ),
              ),
            ),
            SizedBox(height: 10,),
            
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
        )
      ],
    );
    
    
  }

  void _showDialog(req) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(req['status']),
          content: Text("Ya existe un usuario creado con este valor: "+req['message'].toString()),
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

  _register(String user, String pass, String email) async {

    
    final req = await usuarioProvider.nuevoUsuario(user, email, pass);

      if (req['status'] == 'DUPLICATED_VALUES') {
        setState(() {
         validando = false;
        });
        _showDialog(req);
      } else {
        setState(() {
        validando = false;
        });
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('usuario', user);
        prefs.setString('email', email);
        Navigator.of(context).pop();
        Navigator.of(context).pushReplacementNamed('home');
      }
    }

}