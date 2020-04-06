import 'package:flutter/material.dart';
import 'package:gamespace/api/providers/games_provider.dart';
import 'package:gamespace/models/game_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavsPage extends StatefulWidget {
  
  @override
  _FavsPageState createState() => _FavsPageState();
}

class _FavsPageState extends State<FavsPage> {

  final Color primayColor = Color(0xff5c6cfc);
    final Color secondaryColor = Color(0xff0ebc7d);
    final Color primaryDark = Color(0xff2d304e);
    final Color lightColor = Color(0xffededf1);
  final gamesProvider = new GamesProvider();
  var favoritos = List<String>();
  @override
  void initState() { 
    super.initState();
    _cargarPrefs();
    
    
  }

   _cargarPrefs() async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
     favoritos = prefs.getStringList('favoritos');
     setState(() {
       
     });
   }

  @override
  Widget build(BuildContext context) {



    final Color primayColor = Color(0xff5c6cfc);
    final Color secondaryColor = Color(0xff0ebc7d);
    final Color primaryDark = Color(0xff2d304e);
    final Color lightColor = Color(0xffededf1);

    return Scaffold(
      backgroundColor: lightColor,
      appBar: AppBar(
        backgroundColor: lightColor,
        elevation: 0,
        title: Text('Favoritos', style: GoogleFonts.russoOne(
          color: primayColor
        ),),
      ),
      body: Container(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: <Widget>[ 
              _crearFavs()
            ],
          ),
        ),
      ),
    );
  }

  Widget _crearFavs() {
    return Container(
      child: FutureBuilder(
        future: gamesProvider.getFavoritos(favoritos),
        builder: (BuildContext context, AsyncSnapshot<List<GameModel>> snapshot) {
          if (!snapshot.hasData) {
           return Center(child: CircularProgressIndicator());
          } else {
           return Column(
             children: _listaJuegos(snapshot.data),
           ) ;
          }
        },
      ),
    );
  }

   _eliminarFav(GameModel game) async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
     favoritos = prefs.getStringList('favoritos');
      favoritos.removeWhere((item) => item == game.id);
      prefs.setStringList('favoritos', favoritos); 
      print(prefs.get('favoritos').toString()); 
      
  }

  List<Widget> _listaJuegos(List<GameModel> games) {
      return games.map((game){
        return Container(
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15), 
          padding: EdgeInsets.symmetric(vertical: 10),
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
            subtitle: Text(game.price.toString()),
            trailing: IconButton(icon: Icon(LineIcons.trash, color: primaryDark), onPressed: (){
              _eliminarFav(game);
              setState(() {
                
              });
            }),
          ),
        );
      }).toList();
  }

  
}