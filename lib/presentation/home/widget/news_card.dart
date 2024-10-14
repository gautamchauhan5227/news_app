import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/core/const/app_const.dart';
import 'package:news_app/core/const/string_const.dart';
import 'package:news_app/core/local_model/article_model.dart';
import 'package:news_app/core/model/news_dto.dart';
import 'package:news_app/core/utils/string_extension.dart';
import 'package:share_plus/share_plus.dart';

class NewsCard extends StatelessWidget {
  final Article article;
  const NewsCard({
    super.key,
    required this.article,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15).copyWith(
        bottom: 15,
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              article.urlToImage ??
                  'https://plus.unsplash.com/premium_photo-1683865776032-07bf70b0add1?q=80&w=2832&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
              width: 100,
              height: 100,
              fit: BoxFit.cover,
              errorBuilder:
                  (BuildContext context, Object error, StackTrace? stackTrace) {
                return Image.network(
                  'https://plus.unsplash.com/premium_photo-1683865776032-07bf70b0add1?q=80&w=2832&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                );
              },
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      article.source.name,
                      style: GoogleFonts.poppins(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        final result = await Share.share(article.url);

                        if (result.status == ShareResultStatus.success) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(StringConst.thankShare),
                            ),
                          );
                        }
                      },
                      child: Icon(
                        Icons.share_sharp,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                  article.title,
                  maxLines: 2,
                  softWrap: true,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      article.publishedAt.toFormattedDate(),
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        try {
                          final data = await isarService.addItem(
                            ArticleModel(
                              sourceName: article.source.name,
                              sourceId: article.source.id!,
                              title: article.title,
                              url: article.url,
                              publishedAt: article.publishedAt,
                              author: article.author,
                              content: article.content,
                              description: article.description,
                              urlToImage: article.urlToImage,
                            ),
                          );
                          if (data) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(StringConst.successFullySaved)),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text(StringConst.alreadyAdeded)),
                            );
                          }
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text(StringConst.somethingWhenWrong)),
                          );
                        }
                      },
                      child: Icon(
                        Icons.bookmark,
                        color: Colors.grey.shade600,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
