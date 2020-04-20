import 'dart:async';
import 'dart:convert';

import 'package:gamespace/models/cart_model.dart';
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

    Future<List<GameModel>> getFavoritos(favoritos) async {

      
      final url = Uri.https(_url, "/api/games/favoritos");
      Map<String, dynamic> favo = {
        "favoritos": favoritos
      };
      var body = json.encode(favo);
      final resp = await http.post(
        url,
        headers: {'Content-type': 'application/json'}, 
        body: body
      );
      final decodedData =  json.decode(resp.body);
      final favs = Games.fromJsonList(decodedData['data']);

      return favs.items;
    }

    Future<List<GameModel>> getCarrito() async {

      
      final url = Uri.https(_url, "/api/games/carrito");

      final resp = await http.get(url);
      final decodedData =  json.decode(resp.body);
      
      final cartGames = Games.fromJsonList(decodedData['data']);

      return cartGames.items;
    }

    Future<List<GameModel>> search(String value) async {

      
      final url = Uri.https(_url, "/api/games/search/$value");

      final resp = await http.get(url);
      final decodedData =  json.decode(resp.body);
      
      final searchGames = Games.fromJsonList(decodedData['data']);
      
      return searchGames.items;
    }

    Future statusOrder(orderDetails) async {

    

    final resp = await http.post('https://game-space-api.herokuapp.com/api/order/getTotal',
        headers: {'Content-type': 'application/json'}, 
      body: orderDetails
    );

    Map<String, dynamic> decodedResp = json.decode(resp.body);

    print(decodedResp);

    return decodedResp;

  }

  Future payOrder(CartModel compra) async {

    final data = {
        "customer_name":compra.customerName,
        "customer_lname":compra.customerLname,
        "adress":compra.adress,
        "city":compra.city,
        "state":compra.state,
        "country": compra.country,
        "phone":compra.phone,
        "mail": compra.mail,
        "status":compra.status,
        "user_id":compra.userId,
        "total":compra.total,
        "subtotal":compra.subtotal,
        "unidades":compra.unidades,
        "orderDetails":compra.orderDetails
      };

    final resp = await http.post('https://game-space-api.herokuapp.com/api/order/create',
        headers: {'Content-type': 'application/json'}, 
      body: json.encode(data)
    );

    Map<String, dynamic> decodedResp = json.decode(resp.body);

    print(decodedResp);

    return decodedResp;

  }

}