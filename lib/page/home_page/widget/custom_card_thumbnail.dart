import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kk_phim/models/latest_list_movie_model.dart';
import 'package:kk_phim/utils/colors.dart';

import '../../detail_movie_page/detail_movie_page.dart';
class CustomCardThumbnail extends StatelessWidget {
 final LatestItems? latestItems;
 const CustomCardThumbnail({super.key, this.latestItems });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context,MaterialPageRoute(builder: (context) => DetailMoviePage(slugMovie: latestItems?.slug ?? "", movieName: latestItems?.originName ?? ""),)),
      child: Container(
       decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(color: kButtonColor.withOpacity(0.25),
          blurRadius: 5,
           spreadRadius: 1,
           offset: const Offset(0, 3)
          ),

        ],
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(image: CachedNetworkImageProvider(latestItems?.posterUrl ?? ""), fit: BoxFit.cover),
       ),
       margin: const EdgeInsets.only(left: 16, right: 16,top: 12, bottom: 32),
      ),
    );
  }
}
