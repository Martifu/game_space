import 'package:flutter/material.dart';
import 'package:gamespace/api/providers/games_provider.dart';
import 'package:gamespace/models/game_model.dart';
import 'package:gamespace/widgets/games_horizontal.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gamespace/pages/favs_page.dart';
import 'package:gamespace/pages/profile_page.dart';
import 'package:gamespace/pages/shop_page.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}



class _HomePageState extends State<HomePage> {

  final gamesProvider = new GamesProvider();
  final Color primayColor = Color(0xff5c6cfc);
  final Color secondaryColor = Color(0xff0ebc7d);
  final Color primaryDark = Color(0xff2d304e);
  final Color lightColor = Color(0xffededf1);

  @override
  void initState() { 
    super.initState();
    _cargarPrefs();
  }

    void _cargarPrefs() async {
      SharedPreferences preferences = await SharedPreferences.getInstance();
    }
  @override
  Widget build(BuildContext context) {

    gamesProvider.getPopulares();
    gamesProvider.getBestSellers();
    gamesProvider.getNewReleases();
    final size = MediaQuery.of(context).size;

    

    return Scaffold(
      backgroundColor: lightColor,
      appBar: AppBar(
        title: Text('GAME SPACE', style: GoogleFonts.russoOne(
          color: primayColor,
        ) ), 
        backgroundColor: lightColor,
        elevation: 0,
        centerTitle: false,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search, color: primayColor, size: 30,), onPressed: (){
            Navigator.of(context).pushNamed('search');
            print('Search page');
          },)
        ],
      ),
      body: Stack(
        children: <Widget>[
            Container(
          width: size.width,
          height: size.height,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                _showPopulares(),
                _showNewReleases(), 
                _showBestSellers(),
                SizedBox(height: 90,)
              ],
            ),
          ),
        ),
        ],
            
      )
      );
  }

  Widget _showPopulares() {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      padding: EdgeInsets.only(bottom: 10 ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 7),
            child: Text('Populares', style: GoogleFonts.russoOne(
              fontSize: 18,
              color: primaryDark,
            ),),
            
          ),
          StreamBuilder(
              stream: gamesProvider.popularesStream,
              builder: (BuildContext context, AsyncSnapshot<List<GameModel>> snapshot) {
                
                if (!snapshot.hasData) {
                  return Container(
                    child: Center(child: CircularProgressIndicator(),),
                  );
                } else  {
                  return GameHorizontal(games: snapshot.data);
                }
              },
            ),
        ],
      ),
    );
  }

  Widget _showNewReleases() {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      padding: EdgeInsets.only(bottom: 10 ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 7),
            child: Text('Nuevos lanzamientos', style: GoogleFonts.russoOne(
              fontSize: 18,
              color: primaryDark,
            ),),
            
          ),
          StreamBuilder(
              stream: gamesProvider.newReleasesStream,
              builder: (BuildContext context, AsyncSnapshot<List<GameModel>> snapshot) {
                
                if (!snapshot.hasData) {
                  return Container(
                    child: Center(child: CircularProgressIndicator(),),
                  );
                } else  {
                  return GameHorizontal(games: snapshot.data);
                }
              },
            ),
        ],
      ),
    );
  }

  Widget _showBestSellers() {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      padding: EdgeInsets.only(bottom: 10 ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 7),
            child: Text('Más vendidos', style: GoogleFonts.russoOne(
              fontSize: 18,
              color: primaryDark,
            ),),
            
          ),
          StreamBuilder(
              stream: gamesProvider.bestSellersStream,
              builder: (BuildContext context, AsyncSnapshot<List<GameModel>> snapshot) {
                
                if (!snapshot.hasData) {
                  return Container(
                    child: Center(child: CircularProgressIndicator(),),
                  );
                } else  {
                  return GameHorizontal(games: snapshot.data);
                }
              },
            ),
        ],
      ),
    );
  }

  
}