// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:blog_app/core/common/extensions/app_extension.dart';
import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/core/utils/calculate_reading_time/calculate_reading_time.dart';
import 'package:flutter/material.dart';

import 'package:blog_app/features/blog/domain/entities/blog.dart';

class BlogCard extends StatelessWidget {
  const BlogCard({
    super.key,
    required this.blog,
    required this.color,
    required this.onTap,
  });
  final Blog blog;
  final Color color;
  final VoidCallback onTap;

  final verticalGap = 10.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 200,
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: blog.topics
                        .map((e) => Padding(
                              padding: const EdgeInsets.only(right: 5.0),
                              child: Chip(
                                label: Text(e),
                                color: MaterialStateProperty.all(
                                    AppPallete.backgroundColor),
                                side: const BorderSide(
                                  color: AppPallete.borderColor,
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                ),
                Text(blog.title,
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold)),
              ],
            ),
            Text("${calculateReadingTime(blog.content)} min",
                style: const TextStyle(fontSize: 15, color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
