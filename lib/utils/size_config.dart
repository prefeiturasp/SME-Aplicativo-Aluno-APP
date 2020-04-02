import 'package:flutter/material.dart';

class SizeConfig {
  static double screenWidth;
  static double screenHeight;

  static double _blockSizeHorizontal;
  static double _blockSizeVertical;
  static double _safeBlockHorizontal;
  static double _safeBlockVertical;
  static double _safeBlockVerticalWithAppBar;
  static double _safeAreaHorizontal;
  static double _safeAreaVertical;
  static double _safeAreaVerticalWithAppBar;
  static BuildContext _context;
  static MediaQueryData _mediaQueryData;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    _context = context;
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    _blockSizeHorizontal = screenWidth / 100;
    _blockSizeVertical = screenHeight / 100;

    _safeAreaHorizontal =
        _mediaQueryData.padding.left + _mediaQueryData.padding.right;
    _safeAreaVertical =
        _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;

    _safeAreaVerticalWithAppBar =
        _mediaQueryData.padding.top + _mediaQueryData.padding.bottom + 56;

    _safeBlockHorizontal = (screenWidth - _safeAreaHorizontal) / 100;

    _safeBlockVertical = (screenHeight - _safeAreaVertical) / 100;

    _safeBlockVerticalWithAppBar =
        (screenHeight - _safeAreaVerticalWithAppBar) / 100;
  }

  static double getTotalRelativeHeight(double percentSize) {
    return _blockSizeVertical * percentSize;
  }

  static double getTotalRelativeWidth(double percentSize) {
    return _blockSizeHorizontal * percentSize;
  }

  static double getSafeRelativeHeight(double percentSize,
      {bool withAppBar = false}) {
    return withAppBar
        ? _safeBlockVerticalWithAppBar * percentSize
        : _safeBlockVertical * percentSize;
  }

  static double getSafeRelativeWidth(double percentSize) {
    return _safeBlockHorizontal * percentSize;
  }
}
