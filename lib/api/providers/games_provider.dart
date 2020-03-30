import 'dart:async';
import 'dart:convert';

import 'package:gamespace/models/game_model.dart';
import 'package:http/http.dart' as http;

class GamesProvider {
   
    String _url = 'game-space-api.herokuapp.com';


    List<GameModel> _populares = new List();
    final _streamPopularesController = StreamController<List<GameModel>>.broadcast();
    Function(List<GameModel>) get popularesSink => _streamPopularesController.sink.add;
    Stream<List<GameModel>> get popularesStream  => _streamPopularesController.stream;

    List<GameModel> _bestSellers = new List();
    final _streambestSellersController = StreamController<List<GameModel>>.broadcast();
    Function(List<GameModel>) get bestSellersSink => _streambestSellersController.sink.add;
    Stream<List<GameModel>> get bestSellersStream  => _streambestSellersController.stream;

    List<GameModel> _newReleases = new List();
    final _streamnewReleasesController = StreamController<List<GameModel>>.broadcast();
    Function(List<GameModel>) get newReleasesSink => _streamnewReleasesController.sink.add;
    Stream<List<GameModel>> get newReleasesStream  => _streamnewReleasesController.stream;



    void disposeStreams() {
        _streamPopularesController?.close();
        _streambestSellersController?.close();
        _streamnewReleasesController?.close();
    }

    Future<List<GameModel>> getPopulares() async {

      
      final url = Uri.https(_url, "/api/games/get-games");

      final resp = await http.get(url);
      final decodedData =  json.decode(resp.body);
      
      final games = Games.fromJsonList(decodedData['data']);


      _populares.addAll(games.items);
      popularesSink(_populares);
      return games.items;
    }

    Future<List<GameModel>> getBestSellers() async {

      
      final url = Uri.https(_url, "/api/games/bestseller");

      final resp = await http.get(url);
      final decodedData =  json.decode(resp.body);
      
      final games = Games.fromJsonList(decodedData['data']);


      _bestSellers.addAll(games.items);
      bestSellersSink(_bestSellers);
      return games.items;
    }

    Future<List<GameModel>> getNewReleases() async {

      
      final url = Uri.https(_url, "/api/games/new-release");

      final resp = await http.get(url);
      final decodedData =  json.decode(resp.body);
      
      final games = Games.fromJsonList(decodedData['data']);


      _newReleases.addAll(games.items);
      newReleasesSink(_newReleases);
      return games.items;
    }

}