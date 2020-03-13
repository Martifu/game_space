import 'dart:convert';

GameModel gameModelFromJson(String str) => GameModel.fromJson(json.decode(str));

String gameModelToJson(GameModel data) => json.encode(data.toJson());

class Games {

    List<GameModel> items = new List();

    Games();  

    Games.fromJsonList(List<dynamic> jsonList){
      if (jsonList==null) return;

      for (var item in jsonList) {
        final game = new GameModel.fromJson(item);
        items.add(game); 
      }
    }

}

class GameModel {
    String id;
    String title;
    String description;
    double price;
    String image;
    String category;
    String year;
    double rank;
    DateTime createdAt;
    DateTime updatedAt;
    int v;

    GameModel({
        this.id,
        this.title,
        this.description,
        this.price,
        this.image,
        this.category,
        this.year,
        this.rank,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    factory GameModel.fromJson(Map<String, dynamic> json) => GameModel( 
        id: json["_id"],
        title: json["title"],
        description: json["description"],
        price: json["price"].toDouble(),
        image: json["image"],
        category: json["category"],
        year: json["year"],
        rank: json["rank"].toDouble(),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "description": description,
        "price": price,
        "image": image,
        "category": category,
        "year": year,
        "rank": rank,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}
