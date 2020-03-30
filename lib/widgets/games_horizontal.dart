import 'package:flutter/material.dart';
import 'package:gamespace/models/game_model.dart';
import 'package:google_fonts/google_fonts.dart';

class GameHorizontal extends StatelessWidget {

  final  List<GameModel> games;
  final Color primayColor = Color(0xff5c6cfc);
    final Color secondaryColor = Color(0xff0ebc7d);
    final Color primaryDark = Color(0xff2d304e);
    final Color lightColor = Color(0xffededf1);
   GameHorizontal({@required this.games});

   final pageController = new PageController(
          initialPage: 1,
          viewportFraction: .35,
        );

  @override
  Widget build(BuildContext context) {

    final _size = MediaQuery.of(context).size;
    

    return Container(
      height: _size.height /4,
      child: PageView(
        pageSnapping: false,
        controller: PageController(
          initialPage: 1,
          viewportFraction: .35,
        ),
        children: _tarjetas(),
      ),
    );
  }

  List<Widget> _tarjetas() {
    return games.map((game){
      return  Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 10),
          child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
                      child: Container(
                        child: FadeInImage(
                  image: NetworkImage(game.image),
                  placeholder: AssetImage('assets/images/no-image.jpg'),
                  fit: BoxFit.cover,
                ),
                      ),
          ),
         ),
         Align(
           alignment: Alignment.bottomCenter,
           child: Container(
             margin: EdgeInsets.only(right: 10),
             height: 40,
             width: 87,
            decoration: BoxDecoration(
             color: primaryDark, 
             borderRadius: BorderRadius.circular(25),
             boxShadow: [
              
             ]
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Ver más'   , style: GoogleFonts.montserrat(
                      color: lightColor,
                      fontSize: 14,
                    ),)
                  ],
                ),
              ],
            ),
             )),
             Align(
            alignment: Alignment.topRight,
            child: Container(
              height: 35,
              width: 60,
             margin: EdgeInsets.only(right: 10),
              child: Center(child: Text('\$${game.price.toString()}', style: TextStyle(color: lightColor, fontSize: 15, fontWeight: FontWeight.bold ),)),
              decoration: BoxDecoration(
                color: primayColor,
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10))
              ),
            ),
          ),
        ],
      );
      
      
    }).toList();
  }
}