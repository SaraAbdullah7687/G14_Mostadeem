// ignore: unused_import
import 'package:flutter/material.dart';

// green 
const kPrimaryColor = Color(0xFF467c54);
// light green 
const kPrimaryLightColor = Color(0xFFAFC051);
// beige
const kLightColor = Color(0xFFEDE7CD);

class Palette { 

   MaterialColor pColor = const MaterialColor( 
    0xffe55f48, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch. 
    const <int, Color>{ 
      50: const Color(0xFF467c54 ),//10% 
    
    }, 
  ); 
}