import 'dart:convert';

import 'package:http/http.dart' as http;

class UserProvider {

  Future nuevoUsuario(String user, String email, String pass) async {

    final authData = {
      "username":user,
      "email":email,
      "password":pass
    };

    final resp = await http.post('http://game-space-api.herokuapp.com/api/users/create',
        headers: {'Content-type': 'application/json'}, 
      body: json.encode(authData)
    );

    Map<String, dynamic> decodedResp = json.decode(resp.body);

    print(decodedResp);

    return decodedResp;

    

  }

  Future login(String email, String pass) async {

    final authData = {
      "email":email,
      "password":pass
    };

    final resp = await http.post('https://game-space-api.herokuapp.com/api/users/login',
        headers: {'Content-type': 'application/json'}, 
      body: json.encode(authData)
    );

    Map<String, dynamic> decodedResp = json.decode(resp.body);

    print(decodedResp);

    return decodedResp;

  }

  

}