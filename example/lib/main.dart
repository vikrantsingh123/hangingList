import 'package:flutter/material.dart';
// import your package here
import 'package:hanginglist/hanginglist.dart';
import './model/hangingObj.dart';

void main() => runApp(MaterialApp(
      title: 'TASTYBURGER',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.yellow),
      home: MyStateWidget(),
    ));

class MyStateWidget extends StatelessWidget {
  double screenWidth, screenHeight;

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    screenWidth = mediaQueryData.size.width;
    screenHeight = mediaQueryData.size.height;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'HANGINGLIST',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          textAlign: TextAlign.center,
        ),
        actions: <Widget>[
          Icon(Icons.fastfood),
          Padding(
            padding: EdgeInsets.all(5),
          )
        ],
      ),
      // Define the HangingList Widget and do not forget to initialise all fields
      body: HangingList<HangingObject>(
        list: list,
        frontSide: frontSide,
        backSide: backSide,
        moveList: true,
        moveListItem: true,
        height: screenHeight / 2,
        width: screenWidth / 1.3,
      ),
    );
  }

// Create a generic function which returns the frontSide widget of the card
  Widget frontSide<HangingObject>(obj) {
    return Container(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Text(
                obj.restaurantName,
                style: TextStyle(fontSize: 30, color: Color(0xffb71c1c)),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
                width: 200,
                child: RaisedButton(
                  color: Color(0xffffab40),
                  onPressed: () {},
                  child: Text(
                    'Add to your order',
                    style: TextStyle(color: Colors.white),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(18.0),
                      side: BorderSide(color: Color(0xffff6d00))),
                ))
          ],
        ));
  }

// Create a generic function which returns the backSide widget of the card
  Widget backSide<HangingObject>(obj) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Text(obj.restaurantName,
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Color(0xffb71c1c))),
          ),
          SizedBox(
            height: 10,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text('Dishes:',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.brown,
                    fontWeight: FontWeight.w600)),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: obj.dishes.length,
            itemBuilder: (BuildContext context, int i) {
              return Text(obj.dishes[i], style: TextStyle(fontSize: 16));
            },
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text('Location:',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.brown,
                    fontWeight: FontWeight.w600)),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(obj.location),
          ),
          SizedBox(
            height: 10,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text('Contact:',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.brown,
                    fontWeight: FontWeight.w600)),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(obj.contact),
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
              width: 200,
              child: RaisedButton(
                color: Color(0xffffab40),
                onPressed: () {},
                child: Text(
                  'ORDER NOW',
                  style: TextStyle(color: Colors.white),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(18.0),
                    side: BorderSide(color: Color(0xffff6d00))),
              ))
        ],
      ),
    );
  }

// Create a list of objects which hold your desired data and also not forget to define your model
  List<HangingObject> list = [
    HangingObject(
        'Chicken',
        'chicken',
        'McDonald`s',
        ['Chicken McNuggets', 'Big Mac', 'Fries'],
        'Fusion Mall,2ndStage, Kormangala',
        '1860 210 0000, 080 3399 4444'),
    HangingObject(
        'Burger',
        'burger',
        'Taco Bell',
        ['Doritos Locos Tacos', 'Freezes', 'Nacho Fries', 'The Meximelt'],
        'Ashwini Complex, Indranagar',
        '1860 210 0000, 080 3399 4444'),
    HangingObject(
        'Pizza',
        'pizza',
        'KFC',
        [
          'Boneless Wings',
          'Extra Crispy Strips',
          'Extra Crispy Chicken',
          'Hot Wings'
        ],
        'BDA Complex HSR',
        '1860 210 0000, 080 3399 4444'),
    HangingObject(
        'Fries',
        'fries',
        'Burger King',
        ['Whopper Jr. Sandwich', 'HamBurger', 'Veggie Burger', 'TENDERGRILL'],
        'Bull Temple Road, Basavanagudi',
        '1860 210 0000, 080 3399 4444'),
    HangingObject(
        'Coke',
        'coke',
        'Subway',
        [
          'Rotisserie-Style Chicken',
          'Veggie Delite',
          'Meatball Marinara',
          'Meatball Marinara'
        ],
        'Fusion Mall,2ndStage, Kormangala',
        '1860 210 0000, 080 3399 4444'),
    HangingObject(
        'Sandwich',
        'sandwich',
        'StarBucks',
        ['Cake pops', 'Pumpkin bread, Greek yogurt, Bacon'],
        'Orion East, Banaswadi',
        '1860 210 0000, 080 3399 4444')
  ];
}
