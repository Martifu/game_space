import 'package:flutter/material.dart';
import 'package:gamespace/pages/confirm_order_page.dart';
import 'package:gamespace/pages/favs_page.dart';
import 'package:gamespace/pages/game_details.dart';
import 'package:gamespace/pages/home_page.dart';
import 'package:gamespace/pages/login_page.dart';
import 'package:gamespace/pages/pago_page.dart';
import 'package:gamespace/pages/profile_page.dart';
import 'package:gamespace/pages/register_page.dart';
import 'package:gamespace/pages/search_page.dart';
import 'package:gamespace/pages/shop_page.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: MainPage(),
      routes: {
        'game_details' : (_) => GameDetails(),
        'confirm_sell' : (_) => ConfirmOrderPage(),
        'pago' : (_) => CreditCardPage(),
        'login' : (_) => LoginPage(),
        'register' : (_) => RegisterPage(),
        'search'  : (_) => SearchPage(),
        'home': (_) => MainPage()
      },
    );
  }
}

class MainPage extends StatefulWidget {
  MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
   int _selectedIndex = 0;

    final ProfilePage _profilePage = new ProfilePage();
    final ShopPage _shopPage = new ShopPage();
    final FavsPage _favsPage = new FavsPage();
    final HomePage _homePage = new HomePage();

    Widget  _showPage = new HomePage();

    Widget _pageChooser(int page){
      switch (page) {
        case 0: 
        return _homePage;
          break;
        case 1: 
        return _favsPage;
          break;
        case 2: 
        return _shopPage;
          break;
        case 3: 
        return _profilePage;
          break;  
        default:
        return Container(child: Center(child: Text('data'),),);
      }
    }

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _showPage,
          Align(
            alignment: Alignment.bottomCenter,
            child:  Container(
        margin: EdgeInsets.all(20),
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1))
        ],
          borderRadius: BorderRadius.circular(40)
        ),
        child: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
                gap: 5,
                activeColor: Colors.white,
                iconSize: 24,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                duration: Duration(milliseconds: 300),
                tabBackgroundColor: Color(0xff5c6cfc),
                tabs: [
                  GButton(
                    icon: LineIcons.home,
                    text: 'Inicio',
                  ),
                  GButton(
                    icon: LineIcons.heart_o,
                    text: 'Fav',
                    
                  ),
                  GButton(
                    icon: LineIcons.shopping_cart,
                    text: 'Carrito',
                  ),
                  GButton(
                    icon: LineIcons.user,
                    text: 'Perfil',
                  ),
                ],
                selectedIndex: _selectedIndex,
                onTabChange: (index) {
                  setState(() {
                    print(index);
                    _selectedIndex = index;
                    _showPage = _pageChooser(index);
                  });
                }),
          ),
        ),
      ),

          )
        ],
      ),
    );
  }
}