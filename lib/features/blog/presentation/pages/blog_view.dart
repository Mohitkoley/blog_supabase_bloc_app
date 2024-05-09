import 'package:auto_route/auto_route.dart';
import 'package:blog_app/core/common/extensions/app_extension.dart';
import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:blog_app/features/blog/presentation/widgets/blog_card.dart';
import 'package:blog_app/navigation/app_routing/app_router.dart';
import 'package:blog_app/navigation/route_name/route_names.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class BlogView extends StatefulWidget {
  const BlogView({super.key});

  @override
  State<BlogView> createState() => _BlogViewState();
}

class _BlogViewState extends State<BlogView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<BlogBloc>().add(BlogFetchAllBlogs());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Blogs',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  context.router
                      .pushNamed(RouteNames.addNewBlogView)
                      .then((value) {});
                },
                icon: const Icon(CupertinoIcons.add_circled))
          ],
        ),
        body: BlocConsumer<BlogBloc, BlogState>(listener: (context, state) {
          if (state is BlogFailure) {
            context.showSnack(state.message);
          }
        }, builder: (context, state) {
          if (state is BlogLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is BlogFetchedSuccess) {
            if (state.blogs.isEmpty) {
              return const Center(child: Text('No blogs available'));
            }

            return ListView.builder(
                itemCount: state.blogs.length,
                itemBuilder: (context, index) {
                  final blog = state.blogs[index];
                  return BlogCard(
                      onTap: () {
                        context.router.push(BlogDetailsRoute(blog: blog));
                      },
                      blog: blog,
                      color: index % 3 == 0
                          ? AppPallete.gradient1
                          : index % 3 == 1
                              ? AppPallete.gradient2
                              : AppPallete.gradient3);
                });
          }
          return const SizedBox();
        }));
  }
}
