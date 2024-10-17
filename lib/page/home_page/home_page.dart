import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kk_phim/models/list_movie_model.dart';
import 'package:kk_phim/page/home_page/home_page_viewmodel.dart';
import 'package:kk_phim/page/home_page/widget/custom_card_normal.dart';
import 'package:kk_phim/page/home_page/widget/custom_card_thumbnail.dart';
import 'package:kk_phim/utils/colors.dart';
import 'package:provider/provider.dart';
import '../../../models/latest_list_movie_model.dart';
import '../list_movie_page/list_movie_page.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _homePageViewmodel = HomePageViewmodel();
  final pageController = PageController();
  final searchTextController = TextEditingController();
  final listIconNav = [
    FontAwesomeIcons.house,
    FontAwesomeIcons.compass,
    FontAwesomeIcons.video,
    FontAwesomeIcons.user
  ];
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    _homePageViewmodel.getListLatestMovie();
  }

  List<GenresMovie> getGenres() {
    List<GenresMovie> list = [];
    for (int i = 0; i < 5; i++) {
      list.add(GenresMovie.values[i]);
    }
    return list;
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => _homePageViewmodel,
      builder: (context, child) => Consumer<HomePageViewmodel>(
        builder: (context, homePageViewModel, child) => Scaffold(
          backgroundColor: kBackgroundColor,
          body: Stack(
            children: [
              SafeArea(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                        child: Row(
                          children: [
                            Text(
                              "Xin chào !",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 30),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: SearchBar(
                          controller: searchTextController,
                          textStyle: WidgetStateProperty.all(const TextStyle(color: Colors.white)),
                          trailing: [
                            IconButton(
                              icon: const Icon(
                                Icons.arrow_forward,
                                color: Colors.white54,
                              ),
                              onPressed: () {
                                if (searchTextController.text
                                    .trim()
                                    .isEmpty) return;
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ListMoviePage(
                                        title:
                                            "Kết quả: ${searchTextController.text.trim()}",
                                        keyword: searchTextController.text
                                            .trim(),
                                      ),
                                    ));
                              },
                            )
                          ],
                          hintText: "Tìm kiếm..",
                          hintStyle: WidgetStateProperty.all<TextStyle>(
                              const TextStyle(color: Colors.white54)),
                          leading: const Icon(
                            FontAwesomeIcons.magnifyingGlass,
                            color: Colors.white30,
                          ),
                          backgroundColor:
                              WidgetStateProperty.all(kSearchbarColor),
                          padding: WidgetStateProperty.all(
                              const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 16)),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      title(title: 'Mới nhất', onPressed: null),
                      if (homePageViewModel.latestListMovieModel == null)
                        const Center(
                          child: CircularProgressIndicator(),
                        )
                      else ...[
                        recentCardLayout(
                            homePageViewModel.latestListMovieModel!),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 12),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: kSearchbarColor),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: buildPageIndicatorWidget(
                                  homePageViewModel.latestListMovieModel!),
                            ),
                          ),
                        ),
                      ],
                      // const SizedBox(height: 16,),
                      // title(title: "Thể loại", onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const AllCategoryPage(),))),
                      // genresBuilder(context,list: getGenres(), isVertical:  false),
                      const SizedBox(
                        height: 16,
                      ),
                      title(
                        title: "Phim lẻ",
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ListMoviePage(
                                title: "Phim lẻ",
                                typeMovie: TypeMovie.feature,
                              ),
                            )),
                      ),
                      MovieListBuilder(
                          homePageViewmodel: homePageViewModel,
                          typeMovie: TypeMovie.feature),
                      const SizedBox(
                        height: 16,
                      ),
                      title(
                          title: "TV Shows",
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ListMoviePage(
                                  title: "TV Shows",
                                  typeMovie: TypeMovie.tvShows,
                                ),
                              ))),
                      MovieListBuilder(
                          homePageViewmodel: homePageViewModel,
                          typeMovie: TypeMovie.tvShows),
                      const SizedBox(
                        height: 16,
                      ),
                      title(
                          title: "Phim bộ",
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ListMoviePage(
                                  title: "Phim bộ",
                                  typeMovie: TypeMovie.tvSeries,
                                ),
                              ))),
                      MovieListBuilder(
                          homePageViewmodel: homePageViewModel,
                          typeMovie: TypeMovie.tvSeries),
                      const SizedBox(
                        height: 16,
                      ),
                      title(
                          title: "Phim hoat hình",
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ListMoviePage(
                                  title: "Phim lẻ",
                                  typeMovie: TypeMovie.cartoon,
                                ),
                              ))),
                      MovieListBuilder(
                          homePageViewmodel: homePageViewModel,
                          typeMovie: TypeMovie.cartoon),
                      const SizedBox(
                        height: 40,
                      )
                    ],
                  ),
                ),
              ),

              // bottom nav

              // Positioned(
              // bottom: 28,
              // left: 16,
              // right: 16
              // ,child: ClipRRect(
              //   borderRadius: BorderRadius.circular(20),
              //   child: BackdropFilter(
              //     filter: ImageFilter.blur(
              //       sigmaX: 25,
              //       sigmaY: 25
              //     ),
              //     child: Container(
              //       height: 80,
              //       color: kSearchbarColor.withOpacity(0.6),
              //       child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [
              //           ...listIconNav.map((e) => Icon(e, color: e == FontAwesomeIcons.house ? Colors.white: Colors.white54,size: 24,))
              //       ],),
              //     ),
              //   ),
              // ))
              //
            ],
          ),
        ),
      ),
    );
  }

  Widget recentCardLayout(LatestListMovieModel latestListMovieModel) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.48,
      child: PageView.builder(
        physics: const ClampingScrollPhysics(),
        controller: pageController,
        itemCount: latestListMovieModel.getLatestItem(5).length,
        itemBuilder: (context, index) => CustomCardThumbnail(
            latestItems: latestListMovieModel.items?[index]),
        onPageChanged: (value) {
          setState(() {
            currentPage = value;
          });
        },
      ),
    );
  }

  List<Widget> buildPageIndicatorWidget(
      LatestListMovieModel latestListMovieModel) {
    List<Widget> list = [];
    if (latestListMovieModel.items == null) return list;
    for (int i = 0; i < 5; i++) {
      list.add(i == currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 8,
      width: 8,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Colors.white24,
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }

  // Widget movieListBuilder(ListMovieModel? listMovieModel) {
  //   return
  // }

  Widget title({required String title, required void Function()? onPressed}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
                color: Colors.white54,
                fontSize: 20,
                fontWeight: FontWeight.w300),
          ),
          if (onPressed != null)
            TextButton(
              onPressed: onPressed,
              child: const Text(
                "Tất cả",
                style: TextStyle(
                    color: kButtonColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w300),
              ),
            ),
        ],
      ),
    );
  }
}

class MovieListBuilder extends StatefulWidget {
  final TypeMovie typeMovie;
  final HomePageViewmodel homePageViewmodel;

  const MovieListBuilder(
      {super.key, required this.typeMovie, required this.homePageViewmodel});

  @override
  State<MovieListBuilder> createState() => _MovieListBuilderState();
}

class _MovieListBuilderState extends State<MovieListBuilder> {
  ListMovieModel? listMovieModel;

  @override
  void initState() {
    widget.homePageViewmodel
        .getListMovieByType(type: widget.typeMovie, limit: 5)
        .then(
      (value) {
        setState(() {
          listMovieModel = value;
        });
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return listMovieModel == null
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Container(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            height: MediaQuery.of(context).size.height * 0.29,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: listMovieModel?.data?.items?.length ?? 0,
              itemBuilder: (context, index) {
                final currentItem = listMovieModel?.data?.items?[index];
                return CustomCardNormal(item: currentItem ?? Items());
              },
            ),
          );
  }
}
