import 'package:flutter/material.dart';
import 'package:smart_resto/animation/ScaleRoute.dart';
import 'package:smart_resto/api_services/api_services.dart';
import 'package:smart_resto/constants.dart';
import 'package:smart_resto/models/user_model.dart';
import 'package:smart_resto/pages/FoodOrderPage.dart';
import 'package:smart_resto/pages/HomePage.dart';
import 'package:smart_resto/pages/profil_screen.dart';
import 'package:smart_resto/pages/ticketPage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomNavBarWidget extends StatefulWidget {
  final int? index;

  const BottomNavBarWidget({
    Key? key,
    this.index,
  }) : super(key: key);
  @override
  _BottomNavBarWidgetState createState() => _BottomNavBarWidgetState();
}

class _BottomNavBarWidgetState extends State<BottomNavBarWidget> {



  @override
  Widget build(BuildContext context) {
    




    int _selectedIndex = 0;
    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;

//        navigateToScreens(index);
      });

      switch (_selectedIndex) {
        case 0:
          Navigator.push(
              context,
              ScaleRoute(
                  page: HomePage(
      
              )));

          break;

        case 1:
          Navigator.push(context, ScaleRoute(page: TicketPage()));

          break;
        case 2:
          Navigator.push(context, ScaleRoute(page: FoodOrderPage()));

          break;
        case 3:
          Navigator.push(context, ScaleRoute(page: Profil()));

          break;
      }
    }

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Accueil',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.fastfood_rounded),
          label: "Tickets",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.card_giftcard),
          label: "Commandes",
        ),
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.user),
          label: "Profil",
        ),
      ],
      currentIndex: widget.index!,
      selectedItemColor: kPrimaryColor,
      onTap: _onItemTapped,
    );
  }
}
