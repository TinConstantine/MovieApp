import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kk_phim/models/list_movie_model.dart';
import '../../../../utils/colors.dart';
import '../../detail_movie_page/detail_movie_page.dart';

class CustomCardNormal extends StatelessWidget {
  final Items item;

  const CustomCardNormal({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) =>  DetailMoviePage(slugMovie: item.slug ?? "",movieName: item.originName ?? "",))),
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 12),
            height: 200,
            width: 140,
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: kButtonColor.withOpacity(0.25),
                      blurRadius: 5,
                      spreadRadius: 1,
                      offset: const Offset(0, 3)),
                ],
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: CachedNetworkImageProvider("${item.posterUrl}" ??
                      "https://tiengdong.com/wp-content/uploads/www_tiengdong_com-anh-man-hinh-dien-thoai-dang-load-xoay-tron-troll.jpg"),
                  fit: BoxFit.cover,
                )),
          ),
          Positioned(
            left: 16,
            right: 16,
            bottom: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name ?? "",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  item.year.toString(),
                  style: const TextStyle(
                    color: Colors.white54,
                    fontWeight: FontWeight.w300,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
