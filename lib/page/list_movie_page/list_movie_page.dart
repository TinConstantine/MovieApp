import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kk_phim/component/close_page_button.dart';

import 'package:kk_phim/utils/colors.dart';

import '../../models/list_movie_model.dart';
import '../detail_movie_page/detail_movie_page.dart';
import '../home_page/home_page_viewmodel.dart';

class ListMoviePage extends StatefulWidget {
  final String title;
  final TypeMovie? typeMovie;
  final String? keyword;
  final HomePageViewmodel? homePageViewmodel;
  const ListMoviePage({super.key, required this.title, this.typeMovie, this.keyword,this.homePageViewmodel});

  @override
  State<ListMoviePage> createState() => _ListMoviePageState();
}

class _ListMoviePageState extends State<ListMoviePage> {
  late bool isSearchByKeyword;
  ListMovieModel? listMovieModel;
  late HomePageViewmodel homePageViewmodel;
  final scrollController = ScrollController();
  int currentPage = 1;
  bool isLoading = false;
  @override
  void initState() {
    homePageViewmodel = widget.homePageViewmodel ?? HomePageViewmodel();
    isSearchByKeyword = widget.keyword != null ? true : false;
    initData();
    scrollController.addListener(() {
      if(scrollController.position.pixels == scrollController.position.maxScrollExtent && (listMovieModel?.data?.params?.pagination!.totalPages ?? 1) >= currentPage && !isLoading){
        currentPage ++;
        setState(() {
          isLoading = true;
        });
        if(isSearchByKeyword)
          {
            homePageViewmodel.getListMovieByKeyword(keyword: widget.keyword!,pageIndex: currentPage).then((value) {
              setState(() {
                listMovieModel?.addItem(value.data?.items ?? []);
                isLoading = false;
              });
            },);
          }
        else {
          homePageViewmodel.getListMovieByType(type: widget.typeMovie!,pageIndex: currentPage).then((value) {
            setState(() {
              listMovieModel?.addItem(value.data?.items ?? []);
              isLoading = false;
            });
          },);
        }

      }

    },);
    super.initState();
  }

  void initData(){
    setState(() {
      listMovieModel = null;
      isLoading = true;
    });
    if(isSearchByKeyword){
      print("keyword" + widget.keyword.toString());
      homePageViewmodel.getListMovieByKeyword(keyword: widget.keyword ?? '').then((value) {
        setState(() {
          listMovieModel = value;
          isLoading = false;
          print(listMovieModel!.data!.items!.length.toString());
        });
      },);
    }
    else {
      homePageViewmodel.getListMovieByType(type: widget.typeMovie!).then((value) {
        setState(() {
          listMovieModel = value;
          isLoading = false;
        });
      },);
    }
  }
  @override
  void dispose() {
    homePageViewmodel.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kBackgroundColor,
        body: Stack(
          children: [
            SafeArea(child: listMovieModel == null ? const Center(child: CircularProgressIndicator(),) :
                RefreshIndicator(
                  onRefresh: ()async{
                    initData();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 0, left: 12, right: 12, bottom: 20),
                    child: Column(
                      children: [
                        Text(widget.title, style:  const TextStyle(color: Colors.white, fontSize: 30),),
                        const SizedBox(height: 16,),
                        Expanded(
                          child: ListView.separated(controller: scrollController,itemCount: (listMovieModel?.data?.items?.length ?? 0) + ((listMovieModel?.data?.params?.pagination!.totalPages ?? 1) > currentPage ? 1 : 0),itemBuilder: (context, index) {
                            if(index >= listMovieModel!.data!.items!.length){
                              return const Center(child: CircularProgressIndicator(color: Colors.white,),);
                            }
                            else {
                              return buildItem(listMovieModel!.data!.items![index]);
                            }
                          }, separatorBuilder: (BuildContext context, int index) { return const SizedBox(height: 20,); },),
                        )
                      ],
                    ),
                  ),
                )
            ),
            closePageButton(context),
          ],
        ),
    );
  }

  Widget buildItem(Items item){
      return GestureDetector(
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => DetailMoviePage(slugMovie: item.slug ?? "", movieName: item.name ?? ""),)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 120,
              width: 90,
              decoration: BoxDecoration(
                image: DecorationImage(image: CachedNetworkImageProvider(item.posterUrl ?? "",), fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            const SizedBox(width: 12,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(item.name ?? "", style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),),
                  const SizedBox(height: 8,),
                  Text(item.originName ?? "", style: const TextStyle(color: Colors.white54, fontSize: 14),),
                  const SizedBox(height: 8,),
                  Text(item.year.toString(), style: const TextStyle(color: Colors.white54, fontSize: 14),),
                ],
              ),
            )
          ],
        ),
      );
  }
}
