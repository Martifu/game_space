// To parse this JSON data, do
//
//     final cartModel = cartModelFromJson(jsonString);

import 'dart:convert';

CartModel cartModelFromJson(String str) => CartModel.fromJson(json.decode(str));

String cartModelToJson(CartModel data) => json.encode(data.toJson());

class CartModel {
    String customerName;
    String customerLname;
    String adress;
    String city;
    String state;
    String country;
    String phone;
    String mail;
    String status;
    String userId;
    double total;
    double subtotal;
    int unidades;
    List<OrderDetail> orderDetails;

    CartModel({
        this.customerName,
        this.customerLname,
        this.adress,
        this.city,
        this.state,
        this.country,
        this.phone,
        this.mail,
        this.status,
        this.userId,
        this.total,
        this.subtotal,
        this.unidades,
        this.orderDetails,
    });

    factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        customerName: json["customer_name"],
        customerLname: json["customer_lname"],
        adress: json["adress"],
        city: json["city"],
        state: json["state"],
        country: json["country"],
        phone: json["phone"],
        mail: json["mail"],
        status: json["status"],
        userId: json["user_id"],
        total: json["total"].toDouble(),
        subtotal: json["subtotal"].toDouble(),
        unidades: json["unidades"],
        orderDetails: List<OrderDetail>.from(json["orderDetails"].map((x) => OrderDetail.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "customer_name": customerName,
        "customer_lname": customerLname,
        "adress": adress,
        "city": city,
        "state": state,
        "country": country,
        "phone": phone,
        "mail": mail,
        "status": status,
        "user_id": userId,
        "total": total,
        "subtotal": subtotal,
        "unidades": unidades,
        "orderDetails": List<dynamic>.from(orderDetails.map((x) => x.toJson())),
    };
}

class OrderDetail {
    String gameId;
    int quantity;
    int discount;

    OrderDetail({
        this.gameId,
        this.quantity,
        this.discount,
    });

    factory OrderDetail.fromJson(Map<String, dynamic> json) => OrderDetail(
        gameId: json["game_id"],
        quantity: json["quantity"],
        discount: json["discount"],
    );

    Map<String, dynamic> toJson() => {
        "game_id": gameId,
        "quantity": quantity,
        "discount": discount,
    };
}
