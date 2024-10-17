import 'package:flutter/material.dart';
import 'package:kk_phim/page/list_movie/list_movie_page.dart';

import '../../../models/list_movie_model.dart';

Widget genresBuilder(BuildContext context,
    {required List<GenresMovie> list, required bool isVertical}) {
  Widget child = ListView.builder(
    scrollDirection: isVertical ? Axis.vertical : Axis.horizontal,
    itemCount: list.length,
    itemBuilder: (context, index) => GestureDetector(
      onTap: ()=> Navigator.push(context,MaterialPageRoute(builder: (context) => ListMoviePage(title: 'Thể loại: ${list[index].categoryName}',keyword: list[index].keyword,),)),
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 8, right: 8, bottom: 28),
            width: 250,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: AssetImage(list[index].img),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 20,
            child: Text(
              list[index].categoryName,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    ),
  );
  if(!isVertical) {
    child = Container(
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      height: MediaQuery.of(context).size.height * 0.2,
      child: child,
    );
  }
  return child;
}
