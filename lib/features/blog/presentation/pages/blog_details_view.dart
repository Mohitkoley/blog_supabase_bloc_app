import 'package:auto_route/auto_route.dart';
import 'package:blog_app/core/common/extensions/app_extension.dart';
import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/core/utils/calculate_reading_time/calculate_reading_time.dart';
import 'package:blog_app/core/utils/format_date/format_date.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

@RoutePage()
class BlogDetailsView extends StatelessWidget {
  const BlogDetailsView({super.key, required this.blog});
  final Blog blog;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  blog.title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'By ${blog.posterName}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  '${formatDateBydMMMYYYY(blog.updatedAt)} . ${calculateReadingTime(blog.content)} min',
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: AppPallete.greyColor,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 20),
                ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    // child: Image.network(
                    //   blog.imageUrl,
                    //   height: context.height * 0.2,
                    //   fit: BoxFit.cover,
                    //   width: double.infinity,
                    // ),
                    child: CachedNetworkImage(
                      imageUrl: blog.imageUrl,
                      height: context.height * 0.2,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) => SizedBox(
                              height: context.height * 0.2,
                              width: double.infinity / 2,
                              child: Center(
                                  child: CircularProgressIndicator(
                                      value: downloadProgress.progress))),
                      errorWidget: (context, url, error) => Image.asset(
                        'assets/broken_image.png',
                        height: context.height * 0.2,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    )),
                const SizedBox(height: 20),
                Text(
                  blog.content,
                  style: const TextStyle(
                    fontSize: 16,
                    height: 2,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
