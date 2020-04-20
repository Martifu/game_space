import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gamespace/api/providers/games_provider.dart';
import 'package:gamespace/models/game_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({Key key}) : super(key: key);

  @override
  _ShopPageState createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {

  final Color primayColor = Color(0xff5c6cfc);
    final Color secondaryColor = Color(0xff0ebc7d);
    final Color primaryDark = Color(0xff2d304e);
    final Color lightColor = Color(0xffededf1);
  final gamesProvider = new GamesProvider();
  var carrito = List<String>();
  bool logeado;
  int _itemCount = 1;
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
     logeado = prefs.getBool('logeado');
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
        backgroundColor: lightColor,
        elevation: 0,
        title: Text('Próximas compras', style: GoogleFonts.russoOne(
          color: primayColor
        ),),
      ),
      body: Container(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: <Widget>[ 
              _crearFavs(),
               Visibility(
                 visible: confirmar,
                 child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: GestureDetector(
                      onTap: (){
                        _statusOrden();
                       
                      },
                           child: Container(
                             decoration: BoxDecoration(
                               color: primayColor,
                             ),
                             height: 55,
                             width: double.infinity,
                         child: Center(child: Text('Confirmar compra', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15 ))),
                        ),
                    )
                  ),
              ),
               ),
              SizedBox(height: 90)
            ],
          ),
        ),
      ),
    );
  }

   Widget _crearFavs() {
    return Container(
      child: FutureBuilder(
        future: gamesProvider.getFavoritos(carrito),
        builder: (BuildContext context, AsyncSnapshot<List<GameModel>> snapshot) {
          if (!snapshot.hasData) {
           return Center(child: CircularProgressIndicator());
          } else if (snapshot.data.length > 0) {
                
            confirmar = true;
          
           return Column(
             children: _listaJuegos(snapshot.data),
           ) ;
          } else {
            return Container( child: Center(child: Text('No tienes juegos'),),);
          }
        },
      ),
    );
  }

  

  List<Widget> _listaJuegos(List<GameModel> games) {
      
      return games.map((game){
        return Container(
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15), 
          padding: EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: primaryDark.withOpacity(.3),
                blurRadius: 8,
                spreadRadius: 1,
                offset: Offset(-2, 2)
              )
            ]
          ),
          child: ListTile(
            onTap: (){
              Navigator.of(context).pushNamed('game_details', arguments: game);
            },
            leading: Image.network(game.image ),
            title: Text(game.title, style: TextStyle(fontWeight: FontWeight.bold),),
            subtitle: Text('\$${game.price.toString()}'),
            trailing: Container(
              child: IconButton(icon: Icon(LineIcons.trash, color: primaryDark), onPressed: (){
                _eliminarCart(game);
                setState(() {
                  
                });
              }),
            )
            
            
          ),
        );
      }).toList();
  }

  _eliminarCart(GameModel game) async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
     carrito = prefs.getStringList('carrito');
      carrito.removeWhere((item) => item == game.id);
      prefs.setStringList('carrito', carrito); 
      print(prefs.get('carrito').toString()); 
  }

  _statusOrden() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (!logeado){
      Navigator.of(context).pushNamed('login');
    } else {
      carrito = prefs.getStringList('carrito');
     
     orderDetails = await gamesProvider.statusOrder(json.encode({"ids":carrito}));
     print(orderDetails);

     Navigator.of(context).pushNamed('confirm_sell', arguments: orderDetails);
    }
    
     
  }
} 