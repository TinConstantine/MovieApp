
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:kk_phim/utils/colors.dart';
import 'package:video_player/video_player.dart';

import '../../../models/movie_model.dart';
import '../../component/close_page_button.dart';
import '../detail_movie_page/detail_movie_viewmodel.dart';

class WatchMoviePage extends StatefulWidget {
  final DetailMovieViewmodel detailMovieViewmodel;

  const WatchMoviePage({super.key, required this.detailMovieViewmodel});

  @override
  State<WatchMoviePage> createState() => _WatchMoviePageState();
}

class _WatchMoviePageState extends State<WatchMoviePage> {
  late FlickManager _controller;
  late DetailMovieViewmodel detailMovieViewmodel;
  late int currentIndex = 0;
  late List<ServerData> listServer;
  final String defaultLink = "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4";
  bool _isLoading = false;

  @override
  void initState() {
    detailMovieViewmodel = widget.detailMovieViewmodel;
    listServer = detailMovieViewmodel.movieModel?.episodes?[0].serverData ?? [];
    _controller = FlickManager(
      videoPlayerController: VideoPlayerController.networkUrl(
          Uri.parse(listServer[currentIndex].linkM3u8 ?? defaultLink)),
      autoPlay: false,onVideoEnd: (){
      currentIndex = currentIndex + 1;
        playNextVideo(index:currentIndex , url: listServer[currentIndex].linkM3u8 ?? defaultLink);
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  void playNextVideo({required int index,required String url}){
    if(currentIndex >= listServer.length) return;
    setState(() {
      currentIndex = index;
      _controller.flickVideoManager?.videoPlayerController?.dispose();
      _controller.handleChangeVideo(VideoPlayerController.networkUrl(Uri.parse(url)));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: detailMovieViewmodel.movieModel != null ? Stack(
        children: [
          Column(
            children: [
              SizedBox(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.3,
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                child: FlickVideoPlayer(flickManager: _controller),),
              const SizedBox(height: 16,),
              Expanded(
                child: SingleChildScrollView(
                  child: Wrap(
                    direction: Axis.horizontal,
                    crossAxisAlignment: WrapCrossAlignment.start,
                    alignment: WrapAlignment.start,
                    spacing: 12,
                    runSpacing: 8,
                    children: listServer.indexed.map((e) {
                      return ElevatedButton(onPressed: () {
                          playNextVideo(index: e.$1, url: e.$2.linkM3u8 ?? defaultLink);
                      },
                        style: ButtonStyle(backgroundColor: WidgetStateProperty.all(currentIndex == e.$1 ? Colors.purple :
                            kButtonColor)),
                        child: Text(e.$2.name ?? "", style: const TextStyle(
                            color: Colors.white, fontSize: 14),),);
                    },).toList(),
                  ),
                ),
              )
            ],
          
          ),

          // if(!(_controller.flickVideoManager?.videoPlayerController?.value.isInitialized ?? false))
          //   Container(width: double.infinity, height: double.infinity, color: Colors.grey.withOpacity(0.5), child: const Center(
          //     child: CircularProgressIndicator(),
          //   ),),
          closePageButton(context)
        ],
      ) : const Center(child: CircularProgressIndicator(),),
    );
  }

}
