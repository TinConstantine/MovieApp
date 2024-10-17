import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../utils/colors.dart';

Widget closePageButton(BuildContext context){
  return Positioned(
    top: 48,
    right: 20,
    child: Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white70,
      ),
      child: IconButton(
        icon: const Icon(
          FontAwesomeIcons.xmark,
          color: kSearchbarColor,
          size: 20,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    ),
  );

}