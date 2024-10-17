import 'package:flutter/material.dart';
import 'package:kk_phim/component/close_page_button.dart';
import 'package:kk_phim/utils/colors.dart';

import '../../models/list_movie_model.dart';

class AllCategoryPage extends StatelessWidget {
  const AllCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 12),
            child: ListView.builder(
              itemBuilder: (context, index) {
                {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin:
                            const EdgeInsets.only(top: 40, bottom: 12),
                        height: 210,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: DecorationImage(
                                image: AssetImage(GenresMovie.values[index].img),
                                fit: BoxFit.cover)),
                      ),
                         Text(
                          GenresMovie.values[index].categoryName,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,

                        ),
                      ),

                    ],
                  );
                }
              },
              itemCount: GenresMovie.values.length,
            ),
          ),
          closePageButton(context),
        ],
      ),
    );
  }
}
