import 'dart:convert';

import 'package:gamespace/models/game_model.dart';
import 'package:http/http.dart' as http;

class GamesProvider {
   
    String _url = 'game-space-api.herokuapp.com';

    Future<List<GameModel>> getPopulares() async {

      
      final url = Uri.https(_url, "/api/games/get-games");

      final resp = await http.get(url);
      final decodedData =  json.decode(resp.body);
      print(decodedData['data'][0]['title']);
      return [];
    }

}