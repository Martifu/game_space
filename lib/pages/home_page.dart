import 'package:flutter/material.dart';
import 'package:gamespace/api/providers/games_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gamespace/pages/favs_page.dart';
import 'package:gamespace/pages/profile_page.dart';
import 'package:gamespace/pages/shop_page.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


    
  @override
  Widget build(BuildContext context) {

    final Color primayColor = Color(0xff5c6cfc);
    final Color secondaryColor = Color(0xff0ebc7d);
    final Color primaryDark = Color(0xff2d304e);
    final Color lightColor = Color(0xffededf1);
    final size = MediaQuery.of(context).size;

    final gamesProvider = new GamesProvider();

    return Scaffold(
      backgroundColor: lightColor,
      appBar: AppBar(
        title: Text('GAME SPACE', style: GoogleFonts.russoOne(
          color: primayColor,
        ) ), 
        backgroundColor: lightColor,
        elevation: 0,
        centerTitle: true,
      ),
      body: Stack(
        children: <Widget>[
            Container(
          width: size.width,
          height: size.height,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                RaisedButton(onPressed: (){
                     gamesProvider.getPopulares();
                })
              ],
            ),
          ),
        ),
        ],
            
      )
      );
  }
}