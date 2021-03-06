# Hanginglist

A Flutter library to create a `HangingList` with animation on scrolling. You can also create `HangingItems` which you can rotate like a hanger and play with their flip property.
The idea is taken from hanging clothes in almirah.

![Hanging List Demo](demo/hangingList.gif) ![Flip Item Demo](demo/flipAnimation.gif)

[![Hanging List Demo Video](https://i9.ytimg.com/vi/eTNpH7j6xMU/mq3.jpg?sqp=CLCp1e8F&rs=AOn4CLDP1CiygUqyLlzz8In2Bmd0012fSw)](https://youtu.be/kzgtRHAu7eg)

## Getting Started

#### 1. Add dependency to your `pubspec.yaml`

```yaml
dependencies:
  hanginglist: ^0.1.1
```

#### 2. Import it

```dart
import 'package:hanginglist/hanginglist.dart'
```

#### 3. Use it. See the examples folder for an ... example.

## Parameters

```dart
    @required this.list; //list of items
    @required this.frontSide; //widget to show on front side of card
    @required this.backSide;  //widget to show on back side of card
    @required this.moveList;  // bool value whether to move whole list with animation
    @required this.moveListItem;  // bool value whether to move list item with animation
    @required this.height; //height of card
    @required this.width;  //width of card
```

`HangingList<T>` is a widget which builds list of cards.

```dart
HangingList({
    @required this.list,
    @required this.frontSide,
    @required this.backSide,
    @required this.moveList,
    @required this.moveListItem,
    @required this.height,
    @required this.width,
  });
```

## Example

```dart
//Initialise the HangingList widget where you want to use it.
HangingList<HangingObject>(
        list: list,
        frontSide: frontSide,
        backSide: backSide,
        moveList: true,
        moveListItem: true,
        height: screenHeight / 2,
        width: screenWidth / 1.3,
      ),

// create a generic function frontSide which excepts the type of list you want in <Object> parameters and return the widget you want to show in the card.

Widget frontSide<HangingObject>(obj) {
    return yourWidget();
}
// Similarly create backSide which will show when you flip the card.
Widget backSide<HangingObject>(obj) {
    return yourWidget();
}
// Also do not forget to initialise the list with type params.
List<HangingObject> list = [
    HangingObject(
        'Chicken',
        'McDonald`s',
        ['Chicken McNuggets', 'Big Mac', 'Fries'],
        'Fusion Mall,2ndStage, Kormangala',),
    HangingObject(
        'Burger',
        'Taco Bell',
        ['Doritos Locos Tacos', 'Freezes', 'Nacho Fries', 'The Meximelt'],
        'Ashwini Complex, Indranagar',)];
```

This package is currently in development. To enjoy all the features you can edit this package.

## FAQ

**Q:** How can I change PageView Builder to ListViewBuilder ?

**A:** Go to HangingList widget and chage PageView builder to list view builder and change PageController to ScrollController.

##

**Q:** How can I add more gestures to List Items ?

**A:** Go to HangingList widget > HangingItem widget and in gestureDetector add your own gesture functionalities.

##

**Q:** How can I change List Item decoration ?

**A:** Go to the HangingItem widget > Animation Card widget > HangTransform widget and add your decoration there.
