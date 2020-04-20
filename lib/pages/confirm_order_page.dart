import 'package:flutter/material.dart';
import 'package:gamespace/api/providers/games_provider.dart';
import 'package:gamespace/models/cart_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfirmOrderPage extends StatefulWidget {
  @override
  _ConfirmOrderPageState createState() => _ConfirmOrderPageState();
}

class _ConfirmOrderPageState extends State<ConfirmOrderPage> {

  final gamesProvider = new GamesProvider();
  final Color primayColor = Color(0xff5c6cfc);
    final Color secondaryColor = Color(0xff0ebc7d);
    final Color primaryDark = Color(0xff2d304e);
    final Color lightColor = Color(0xffededf1);
  var carrito = List<String>();
  bool confirmar = false;
    Map<String, dynamic> orderDetails ;

  

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _cargarPrefs();

  }

  _cargarPrefs() async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
     carrito = prefs.getStringList('carrito');
     if (carrito.length > 0) {
       confirmar = true;
     }
     setState(() {
       
     });
   }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightColor,
      appBar: AppBar(
        leading: IconButton(icon: Icon(LineIcons.arrow_left, color: primaryDark,), onPressed: (){Navigator.of(context).pop();}),
        backgroundColor: lightColor,
        elevation: 0,
        centerTitle: true,
        title: Text('Confirma tu compra', style: GoogleFonts.russoOne(color: primayColor)),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            _infoCompra(),
            SizedBox(height: 10),
            FormularioDatos(),
          ],
        ),
      ),
    );
  }

  Widget _infoCompra() {
    orderDetails = ModalRoute.of(context).settings.arguments;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text('Unidades: ${orderDetails['data']['unidades']}', style: TextStyle(color: primaryDark, fontSize: 18,fontWeight: FontWeight.bold),),
            ],
          ),
          Row(
            children: <Widget>[
              Text('Total de la compra: ${orderDetails['data']['total']}', style: TextStyle(color: Colors.green, fontSize: 18,fontWeight: FontWeight.bold),),
            ],
          ),
          SizedBox(height: 15,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text('Llena los siguientes datos', style: TextStyle(color: primaryDark, fontSize: 15),),
            ],
          ),
        ],
      ),
    );
  }

 
}

 class FormularioDatos extends StatefulWidget {
    @override
    _FormularioDatosState createState() => _FormularioDatosState();
  }
  
  class _FormularioDatosState extends State<FormularioDatos> {

    final _formKey = GlobalKey<FormState>();
    
    final Color primayColor = Color(0xff5c6cfc);
    final Color secondaryColor = Color(0xff0ebc7d);
    final Color primaryDark = Color(0xff2d304e);
    final Color lightColor = Color(0xffededf1);
    final compra = CartModel();
    Map<String, dynamic> orderDetails;
  
    @override
    Widget build(BuildContext context) {

       orderDetails = ModalRoute.of(context).settings.arguments;


      return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20), 
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
              labelText: 'Nombre',
              labelStyle:  TextStyle(color: primaryDark, fontSize: 15.0)),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Por favor llena este campo';
                }
              },
              onChanged: (val) => compra.customerName = val,
            ),
            SizedBox(height: 10,),
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
              labelText: 'Apellidos',
              labelStyle:  TextStyle(color: primaryDark, fontSize: 15.0)),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Por favor llena este campo';
                }
              },
              onChanged: (val) => compra.customerLname = val,
            ),
            SizedBox(height: 10,),
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
              labelText: 'Dirección',
              labelStyle:  TextStyle(color: primaryDark, fontSize: 15.0)),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Por favor llena este campo';
                }
              },
              onChanged: (val) => compra.adress = val,
            ),
            SizedBox(height: 10,),
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
              labelText: 'Ciudad',
              labelStyle:  TextStyle(color: primaryDark, fontSize: 15.0)),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Por favor llena este campo';
                }
              },
              onChanged: (val) => compra.city = val,
            ),
            SizedBox(height: 10,),
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
              labelText: 'Estado',
              labelStyle:  TextStyle(color: primaryDark, fontSize: 15.0)),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Por favor llena este campo';
                }
              },
              onChanged: (val) => compra.state = val,
            ),
            SizedBox(height: 10,),
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
              labelText: 'Número de teléfono',
              labelStyle:  TextStyle(color: primaryDark, fontSize: 15.0)),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Por favor llena este campo';
                }
              },
              onChanged: (val) => compra.phone = val,
            ),
            SizedBox(height: 10,),
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
              labelText: 'Corre electrónico',
              labelStyle:  TextStyle(color: primaryDark, fontSize: 15.0)),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Por favor llena este campo';
                }
              },
              onChanged: (val) => compra.mail = val,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: GestureDetector(
                      onTap: (){
                        if (_formKey.currentState.validate()) {
                          
                          compra.status = 'active';
                          compra.userId = '123123';
                          compra.country = 'Mexico';
                          compra.total = orderDetails['data']['total'];
                          compra.subtotal = orderDetails['data']['subtotal'];
                          compra.unidades = orderDetails['data']['unidades'];

                          var list  = orderDetails['data']['orderDetails'] as List;
                          List<OrderDetail> orders = list.map((i) => OrderDetail.fromJson(i)).toList();
                          compra.orderDetails = orders;

                          Navigator.of(context).pushNamed('pago', arguments: compra);

                        }
                      
                      },
                           child: Container(
                             decoration: BoxDecoration(
                               color: primayColor,
                             ),
                             height: 55,
                             width: double.infinity,
                         child: Center(child: Text('Siguiente', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15 ))),
                        ),
                    ),
              
              
               
            ),
          ],
        ),
      ),
    );
    }
  }