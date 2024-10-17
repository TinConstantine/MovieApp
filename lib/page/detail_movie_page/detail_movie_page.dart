import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:kk_phim/utils/colors.dart';
import 'package:provider/provider.dart';

import '../../../models/list_movie_model.dart';
import '../../../models/movie_model.dart';
import '../watch_movie_page/watch_movie.dart';
import 'detail_movie_viewmodel.dart';

class DetailMoviePage extends StatefulWidget {
  final String slugMovie;
  final String movieName;

  const DetailMoviePage(
      {super.key, required this.slugMovie, required this.movieName});

  @override
  State<DetailMoviePage> createState() => _DetailMoviePageState();
}

class _DetailMoviePageState extends State<DetailMoviePage> {
  final _detailMovieViewmodel = DetailMovieViewmodel();

  @override
  void initState() {
    _detailMovieViewmodel.getDetailMovie(widget.slugMovie);
    super.initState();
  }

  @override
  void dispose() {
    _detailMovieViewmodel.dispose();
    super.dispose();

  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => _detailMovieViewmodel,
        builder: (context, child) {
          return Consumer<DetailMovieViewmodel>(
            builder: (context, detailMovieViewmodel, child) => Scaffold(
                backgroundColor: kBackgroundColor,
                body: Stack(
                  children: [
                    (detailMovieViewmodel.movieModel != null)
                        ? SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 8, right: 8, bottom: 120),
                              child: Column(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height *
                                        0.5,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      gradient: LinearGradient(
                                          colors: [
                                            kBackgroundColor.withOpacity(0.8),
                                            Colors.transparent
                                          ],
                                          begin: Alignment.bottomCenter,
                                          end: Alignment.topCenter),
                                      // borderRadius: BorderRadius.circular(20),
                                      image: DecorationImage(
                                          image: CachedNetworkImageProvider(detailMovieViewmodel
                                                  .movieModel
                                                  ?.movie
                                                  ?.posterUrl ??
                                              "https://tiengdong.com/wp-content/uploads/www_tiengdong_com-anh-man-hinh-dien-thoai-dang-load-xoay-tron-troll.jpg"),
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 22,
                                  ),
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 4),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    detailMovieViewmodel
                                                            .movieModel
                                                            ?.movie
                                                            ?.name ??
                                                        "",
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 22,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  const SizedBox(
                                                    height: 4,
                                                  ),
                                                  Text(
                                                    "${detailMovieViewmodel.movieModel?.movie?.originName} (${detailMovieViewmodel.movieModel?.movie?.year})",
                                                    style: const TextStyle(
                                                        color: Colors.white38,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        buildMapInfo("Đang phát",
                                            "${detailMovieViewmodel.movieModel?.movie?.quality} ${detailMovieViewmodel.movieModel?.movie?.lang}"),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        buildMapInfo(
                                            "Năm phát hành",
                                            (detailMovieViewmodel.movieModel
                                                        ?.movie?.year ??
                                                    0)
                                                .toString()),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        buildMapInfo(
                                            "Thể loại",
                                            parseListToString(
                                                (detailMovieViewmodel.movieModel
                                                        ?.movie?.category
                                                        ?.map(
                                                          (e) => e.name,
                                                        )
                                                        .toList()) ??
                                                    [])),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        buildMapInfo(
                                            "Quốc gia",
                                            parseListToString(
                                                (detailMovieViewmodel.movieModel
                                                        ?.movie?.country
                                                        ?.map(
                                                          (e) => e.name,
                                                        )
                                                        .toList()) ??
                                                    [])),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        buildMapInfo(
                                            "Đạo diễn",
                                            parseListToString(
                                                (detailMovieViewmodel.movieModel
                                                        ?.movie?.director ??
                                                    []))),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        buildMapInfo(
                                            "Tình trạng",
                                            detailMovieViewmodel.movieModel
                                                    ?.movie?.episodeCurrent ??
                                                ""),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        buildMapInfo(
                                            "Thời lượng",
                                            detailMovieViewmodel
                                                    .movieModel?.movie?.time ??
                                                ""),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        buildMapInfo(
                                            "Diễn viên",
                                            parseListToString(
                                                (detailMovieViewmodel.movieModel
                                                        ?.movie?.actor ??
                                                    []))),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        buildMapInfo(
                                            "Nội dung",
                                            detailMovieViewmodel.movieModel
                                                    ?.movie?.content ??
                                                ""),
                                        const SizedBox(
                                          height: 12,
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        : const Center(
                            child: CircularProgressIndicator(),
                          ),


                    Positioned(
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
                        )),
                    if(detailMovieViewmodel.movieModel != null)
                    Positioned(
                        bottom: 30,
                        right: 30,
                        left: 30,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => WatchMoviePage(
                                        detailMovieViewmodel:
                                            detailMovieViewmodel,
                                      ),
                                    ));
                              },
                              style: ButtonStyle(
                                  padding: WidgetStateProperty.all(
                                      const EdgeInsets.symmetric(vertical: 12)),
                                  backgroundColor:
                                      WidgetStateProperty.all(kButtonColor)),
                              child: const Text(
                                "Xem phim",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            )))
                  ],
                )),
          );
        });
  }

  Widget buildTag(Category tag) {
    return Container(
      margin: const EdgeInsets.only(top: 8, right: 8),
      child: ElevatedButton(
        onPressed: null,
        style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(kSearchbarColor)),
        child: Text(
          tag.name ?? "",
          style: const TextStyle(color: Colors.white30, fontSize: 16),
        ),
      ),
    );
  }

  Widget buildMapInfo(String title, String detail) {
    return RichText(
      text: TextSpan(children: [
        TextSpan(
          text: "$title: ",
          style: const TextStyle(
              fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        TextSpan(
          text: detail,
          style: const TextStyle(fontSize: 14, color: Colors.white30),
        ),
      ]),
    );
  }

  String parseListToString(List<String?> list) {
    if (list.isEmpty) return "";
    String res = "";
    for (int i = 0; i < list.length; i++) {
      if (list[i] != null) res += list[i]!;
      if (i < list.length - 1) res += ", ";
    }
    return res;
  }

  // String getListCountry(List<Country> list){
  //   if(list.isEmpty) return "";
  //   String res = "";
  //   for(int i = 0; i < list.length; i++){
  //     if(list[i].name!=null) res += list[i].name!;
  //     if(i < list.length - 1) res +=", ";
  //   }
  //   return res;
  // }

  Widget buildItemMovie(String posterUrl, Episodes episodes) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.3,
            height: 64,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                kBackgroundColor.withOpacity(0.8),
                Colors.transparent
              ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
              // borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                  image: NetworkImage(posterUrl), fit: BoxFit.cover),
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          Text(
            episodes.serverData?[0].name ?? "",
            style: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
          )
        ],
      ),
    );
  }
}
