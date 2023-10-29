import 'package:flutter/material.dart';

enum AppTheme {
  customLight,
  customDark,
}

const customLightColorScheme =  ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFF021B89),       
  onPrimary: Color(0xFFFFFFFF),    
  secondary: Color(0xFFFB7A8D),    
  onSecondary: Color(0xFF000000),   
  surface: Color(0xFFFB7A8D),       
  onSurface: Color(0xFF393E46),     
  background: Color(0xFFFFFFFF),    
  onBackground: Color(0xFF393E46),  
  error: Color(0xFFF93875),         
  onError: Color(0xFF393E46),      
);

const customDarkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFFF93875),
  onPrimary: Color(0xFFFFFFFF), 
  secondary: Color(0xFF021B89),
  onSecondary: Color(0xFFFFFFFF), 
  surface: Color(0xFFFB7A8D),
  onSurface: Color(0xFF393E46), 
  background: Color(0xFF393E46),  
  onBackground: Color(0xFFFFFFFF), 
  error: Color(0xFF6395FC),
  onError: Color(0xFF393E46), 
);



final appThemeData = {
  AppTheme.customLight: ThemeData.from(colorScheme: customLightColorScheme),
  AppTheme.customDark: ThemeData.from(colorScheme: customDarkColorScheme)
};


