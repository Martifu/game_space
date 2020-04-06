import 'package:flutter/material.dart';
import 'package:gamespace/models/game_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GameDetails extends StatefulWidget {
  @override
  _GameDetailsState createState() => _GameDetailsState();
}

class _GameDetailsState extends State<GameDetails> {

  final Color primayColor = Color(0xff5c6cfc);
    final Color secondaryColor = Color(0xff0ebc7d);
    final Color primaryDark = Color(0xff2d304e);
    final Color lightColor = Color(0xffededf1);
    var favoritos = List<String>(); 

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;

    final GameModel game = ModalRoute.of(context).settings.arguments;
    

    return Scaffold(
      backgroundColor: lightColor,
      bottomNavigationBar: GestureDetector(
        onTap: (){
          print('Agregado');
        },
        child: Container(
          height: _size.height/13,
          decoration: BoxDecoration(
            color: primaryDark,
             borderRadius: BorderRadius.only(topRight: Radius.circular(30), topLeft: Radius.circular(30))
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Agregar al carrito ', style: GoogleFonts.russoOne(
                fontSize: 20,
                color: lightColor,
              ),),
              Icon(Icons.shopping_cart, color: lightColor, size: 22, )
            ],
          ),
        ),
      ),
      body:Stack(
      children: <Widget>[
        _headerCurve(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Padding(
            padding: const EdgeInsets.only(top: 45),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                CircleAvatar(child: IconButton(icon: Icon(LineIcons.arrow_left),color: primaryDark, onPressed: (){Navigator.of(context).pop();}), backgroundColor: lightColor,),
                CircleAvatar(child: IconButton(icon: Icon(LineIcons.heart_o), color: primaryDark, 
                onPressed: (){
                  _favorito(game);
                }), backgroundColor: lightColor,)
              ],
            ),
          ),
        ),
        Positioned(
          top: _size.height / 4, 
            child: Padding(
            padding: const EdgeInsets.only(left:0),
            child: Container(
              width: _size.width,
              child: Column(
                children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: 20),
                        child: Text(game.title, style: GoogleFonts.russoOne(
                          fontSize: 20,
                          color: lightColor
                        ),),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,  
                        children: <Widget>[
                          
                          Column(
                            children: <Widget>[
                              Container(child: Center(child: Text('${game.category}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: lightColor),)),
                            padding: EdgeInsets.all(5),
                            width: _size.width/4,
                            decoration: BoxDecoration(
                              color: primaryDark,
                              borderRadius: BorderRadiusDirectional.circular(40)
                            ),
                          ),
                              
                          SizedBox(height: 10),
                            Container(child: Center(child: Text('★ ${game.rank.toString()}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.yellow),)),
                            padding: EdgeInsets.all(4),
                            width: _size.width/4,
                            decoration: BoxDecoration(
                              color: primaryDark,
                              borderRadius: BorderRadiusDirectional.circular(40)
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(child: Center(child: Text('\$${game.price.toString()}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green),)),
                            padding: EdgeInsets.all(5),
                            width: _size.width/4,
                            decoration: BoxDecoration(
                              color: primaryDark,
                              borderRadius: BorderRadiusDirectional.circular(40)
                            ),
                          ),
                          
                          
                            ],
                          ),
                          Container(
                            height: _size.height/4.5,
                            width: _size.width/3.5 ,
                            child: FadeInImage(placeholder: AssetImage('assets/images/no-image.jpg'), image: NetworkImage(game.image), fit: BoxFit.cover),

                          ),
                        ],
                      ),
                      
                      Container(
                        padding: EdgeInsets.all(20),
                        height: _size.height/2.5 ,
                        child: SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              Text(game.description,
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                            ],
                          ),
                        ),
                      ),

                      

                ],
              ),
            ),
          ),
        ),
        
      ],
      
    ) ,
    );
    
    
  }

  Widget _headerCurve() {

    final _size = MediaQuery.of(context).size;

    return Container(
      height: _size.height,
      child: Container(
      margin: EdgeInsets.only(bottom: _size.height/2.0),
      decoration: BoxDecoration(
        color: primayColor,
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(80))
      ),
    ),
    );
  }
    _favorito(GameModel game) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      
      
      favoritos = prefs.getStringList('favoritos');
      if (!favoritos.contains(game.id)) { 
        favoritos.add(game.id);
      }
      prefs.setStringList('favoritos', favoritos); 
      print(prefs.get('favoritos').toString()); 
    }

    
}