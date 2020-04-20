import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gamespace/api/providers/games_provider.dart';
import 'package:gamespace/logic/bloc/credit_card_bloc.dart';
import 'package:gamespace/models/cart_model.dart';
import 'package:gamespace/utils/uidata.dart';
import 'package:gamespace/widgets/profile_tile.dart';
import 'package:google_fonts/google_fonts.dart';




class CreditCardPage extends StatelessWidget {

  final gamesProvider = GamesProvider();
  BuildContext _context;
  CreditCardBloc cardBloc;
  MaskedTextController ccMask =
      MaskedTextController(mask: "0000 0000 0000 0000");
  MaskedTextController expMask = MaskedTextController(mask: "00/00");
  Widget bodyData() => SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[creditCardWidget(), fillEntries()],
        ),
      );
  Widget creditCardWidget() {
    var deviceSize = MediaQuery.of(_context).size;
    return Container(
      height: deviceSize.height * 0.3,
      color: Color(0xffededf1),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          clipBehavior: Clip.antiAlias,
          elevation: 3.0,
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: UIData.kitGradients)),
              ),
              Opacity(
                opacity: 0.1,
                child: Image.asset(
                  "assets/images/map.png",
                  fit: BoxFit.cover,
                ),
              ),
              MediaQuery.of(_context).orientation == Orientation.portrait
                  ? cardEntries()
                  : FittedBox(
                      child: cardEntries(),
                    ),
              Positioned(
                right: 10.0,
                top: 10.0,
                child: Icon(
                  FontAwesomeIcons.ccVisa,
                  size: 30.0,
                  color: Colors.white,
                ),
              ),
              Positioned(
                right: 10.0,
                bottom: 10.0,
                child: StreamBuilder<String>(
                  stream: cardBloc.nameOutputStream,
                  initialData: "Your Name",
                  builder: (context, snapshot) => Text(
                        snapshot.data.length > 0 ? snapshot.data : "Your Name",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: UIData.ralewayFont,
                            fontSize: 20.0),
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget cardEntries() => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            StreamBuilder<String>(
                stream: cardBloc.ccOutputStream,
                initialData: "**** **** **** ****",
                builder: (context, snapshot) {
                  snapshot.data.length > 0
                      ? ccMask.updateText(snapshot.data)
                      : null;
                  return Text(
                    snapshot.data.length > 0
                        ? snapshot.data
                        : "**** **** **** ****",
                    style: TextStyle(color: Colors.white, fontSize: 22.0),
                  );
                }),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                StreamBuilder<String>(
                    stream: cardBloc.expOutputStream,
                    initialData: "MM/YY",
                    builder: (context, snapshot) {
                      snapshot.data.length > 0
                          ? expMask.updateText(snapshot.data)
                          : null;
                      return ProfileTile(
                        textColor: Colors.white,
                        title: "Expiry",
                        subtitle:
                            snapshot.data.length > 0 ? snapshot.data : "MM/YY",
                      );
                    }),
                SizedBox(
                  width: 30.0,
                ),
                StreamBuilder<String>(
                    stream: cardBloc.cvvOutputStream,
                    initialData: "***",
                    builder: (context, snapshot) => ProfileTile(
                          textColor: Colors.white,
                          title: "CVV",
                          subtitle:
                              snapshot.data.length > 0 ? snapshot.data : "***",
                        )),
              ],
            ),
          ],
        ),
      );

  Widget fillEntries() => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextField(
              controller: ccMask,
              keyboardType: TextInputType.number,
              maxLength: 19,
              style: TextStyle(
                  fontFamily: UIData.ralewayFont, color: Colors.black),
              onChanged: (out) => cardBloc.ccInputSink.add(ccMask.text),
              decoration: InputDecoration(
                  labelText: "Credit Card Number",
                  labelStyle: TextStyle(fontWeight: FontWeight.bold),
                  border: OutlineInputBorder()),
            ),
            TextField(
              controller: expMask,
              keyboardType: TextInputType.number,
              maxLength: 5,
              style: TextStyle(
                  fontFamily: UIData.ralewayFont, color: Colors.black),
              onChanged: (out) => cardBloc.expInputSink.add(expMask.text),
              decoration: InputDecoration(
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  labelText: "MM/YY",
                  border: OutlineInputBorder()),
            ),
            TextField(
              keyboardType: TextInputType.number,
              maxLength: 3,
              style: TextStyle(
                  fontFamily: UIData.ralewayFont, color: Colors.black),
              onChanged: (out) => cardBloc.cvvInputSink.add(out),
              decoration: InputDecoration(
                  labelStyle: TextStyle(fontWeight: FontWeight.bold),
                  labelText: "CVV",
                  border: OutlineInputBorder()),
            ),
            TextField(
              keyboardType: TextInputType.text,
              maxLength: 20,
              style: TextStyle(
                  fontFamily: UIData.ralewayFont, color: Colors.black),
              onChanged: (out) => cardBloc.nameInputSink.add(out),
              decoration: InputDecoration(
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  labelText: "Name on card",
                  border: OutlineInputBorder()),
            ),
          ],
        ),
      );

  Widget floatingBar(CartModel compra) => Ink(
        decoration: ShapeDecoration(
            shape: StadiumBorder(),
            color: Color(0xff5c6cfc) ),
        child: FloatingActionButton.extended(
          onPressed: () {
            _pay(compra);
          },
          backgroundColor: Colors.transparent,
          icon: Icon(
            FontAwesomeIcons.creditCard,
            color: Colors.white,
          ),
          label: Text(
            "Pagar",
            style: TextStyle(color: Colors.white),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {


    CartModel compra = ModalRoute.of(context).settings.arguments;
    
    _context = context;
    cardBloc = CreditCardBloc();
    return Scaffold(
      backgroundColor:  Color(0xffededf1) ,
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Credit Card", style: GoogleFonts.russoOne(
          color: Color(0xff5c6cfc),
        ),),
        backgroundColor:  Color(0xffededf1) ,
        elevation: 0,
        leading: IconButton(
          icon: Icon(FontAwesomeIcons.arrowLeft, color: Color(0xff5c6cfc)),
          onPressed: (){
            Navigator.of(context).pop();
          },
        ),
      ),
      body: bodyData(),
      floatingActionButton: floatingBar(compra),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void _pay(CartModel compra) async {

    final payStatus = await gamesProvider.payOrder(compra);

    print(compra.customerLname);
  }
}