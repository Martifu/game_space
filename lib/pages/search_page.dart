import 'package:flutter/material.dart';
import 'package:gamespace/api/providers/games_provider.dart';
import 'package:gamespace/models/game_model.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  final Color primayColor = Color(0xff5c6cfc);
  final Color secondaryColor = Color(0xff0ebc7d);
  final Color primaryDark = Color(0xff2d304e);
  final Color lightColor = Color(0xffededf1);

  bool isSearching = false;
  List<GameModel> countries = [];
  List<GameModel> juegosFiltrados = [];
  final gamesProvider = GamesProvider();

  @override
  void initState() { 
    getGames().then((data) {
      setState(() {
        countries = juegosFiltrados = data;
      });
    });
    super.initState();
    super.initState();
  }

   getGames() async {
    var response = await gamesProvider.getPopulares();
    return response;
  }

  void _filtergames(value) {
    setState(() {
      juegosFiltrados = countries
          .where((country) =>
              country.title.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryDark,
        title: !isSearching
            ? Text('Todos los juegos')
            : TextField(
                onChanged: (value) {
                  _filtergames(value);
                },
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    icon: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    hintText: "Busca un juego aquí",
                    hintStyle: TextStyle(color: Colors.white)),
              ),
        actions: <Widget>[
          isSearching
              ? IconButton(
                  icon: Icon(Icons.cancel),
                  onPressed: () {
                    setState(() {
                      this.isSearching = false;
                    print('object');
                      juegosFiltrados = countries;
                    });
                  },
                )
              : IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    setState(() {
                      this.isSearching = true;
                    });
                  },
                )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: juegosFiltrados.length > 0
            ? ListView.builder(
                itemCount: juegosFiltrados.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                     Navigator.of(context).pushNamed('game_details', arguments: juegosFiltrados[index]);
                    },
                    child: Card(
                      elevation: 10,
                      child: Padding(
                        padding:  EdgeInsets.symmetric(
                            vertical: 10, horizontal: 8),
                        child: Row(
                          children: <Widget>[
                            Image(
                              height: 60,
                              image: NetworkImage(juegosFiltrados[index].image) ), 
                              SizedBox(width: 10,),
                            Container(
                              width: 170,
                              child: Text(
                                juegosFiltrados[index].title,
                                overflow: TextOverflow.clip,
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                            Spacer(),
                            Text(
                              "\$ ${juegosFiltrados[index].price.toString()}",
                              style: TextStyle(fontSize: 18),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                })
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}