import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:blog_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog_app/core/common/extensions/app_extension.dart';
import 'package:blog_app/core/common/widgets/loader.dart';
import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/core/utils/image_picker/image_picker.dart';
import 'package:blog_app/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:blog_app/features/blog/presentation/widgets/blog_editor.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class AddNewBlogView extends StatefulWidget {
  const AddNewBlogView({super.key});

  @override
  State<AddNewBlogView> createState() => _AddNewBlogViewState();
}

class _AddNewBlogViewState extends State<AddNewBlogView> {
  List<String> chipList = [
    'Technology',
    'Business',
    'Programming',
    'Entertainment',
  ];
  List<String> selectedChipList = [];

  final _blogTitleController = TextEditingController();
  final _blogContentController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final spacing = 10.0;
  File? _image;

  selectImage() async {
    final image = await pickImage();
    if (image != null) {
      _image = image;
      setState(() {});
    }
  }

  _uploadBlog() {
    if (_formKey.currentState!.validate()) {
      if (selectedChipList.isEmpty) {
        context.showSnack('Please select a topic');
        return;
      }
      if (_image != null) {
        final posterId =
            (context.read<AppUserCubit>().state as AppUserLoggedIn).user.id;

        context.read<BlogBloc>().add(UploadBlogEvent(
            posterId: posterId,
            image: _image!,
            title: _blogTitleController.text.trim(),
            content: _blogContentController.text,
            topics: selectedChipList));
      } else {
        context.showSnack('Please select an image');
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _blogTitleController.dispose();
    _blogContentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Add New Blog', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: _uploadBlog,
            icon: const Icon(Icons.done_rounded),
            tooltip: 'upload blog',
          )
        ],
      ),
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {
          if (state is BlogFetchedSuccess) {
            context.showSnack('Blog uploaded successfully');
            context.router.pop();
          }
          if (state is BlogFailure) {
            context.showSnack(state.message);
          }
        },
        builder: (context, state) {
          if (state is BlogLoading) {
            return const Loader();
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    InkWell(
                      onTap: selectImage,
                      borderRadius: BorderRadius.circular(10),
                      child: SizedBox(
                        height: context.height * 0.2,
                        width: double.infinity,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            DottedBorder(
                              color: AppPallete.borderColor,
                              strokeWidth: 3,
                              dashPattern: const [10, 4],
                              padding: const EdgeInsets.all(5),
                              radius: const Radius.circular(10),
                              strokeCap: StrokeCap.round,
                              child: const SizedBox(
                                height: double.infinity,
                                width: double.infinity,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.folder_open, size: 40),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text('select your image',
                                        style: TextStyle(fontSize: 15))
                                  ],
                                ),
                              ),
                            ),
                            if (_image != null)
                              ClipRRect(
                                child: Image.file(
                                  _image!,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: double.infinity,
                                ),
                              )
                          ],
                        ),
                      ),
                    ),
                    spacing.hBox,
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: chipList
                            .map((e) => Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      if (selectedChipList.contains(e)) {
                                        selectedChipList.remove(e);
                                      } else {
                                        selectedChipList.add(e);
                                      }
                                      setState(() {});
                                    },
                                    child: Chip(
                                      label: Text(e),
                                      color: MaterialStateProperty.all(
                                          selectedChipList.contains(e)
                                              ? AppPallete.gradient2
                                              : AppPallete.backgroundColor),
                                      side: selectedChipList.contains(e)
                                          ? null
                                          : const BorderSide(
                                              color: AppPallete.borderColor,
                                            ),
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                    spacing.hBox,
                    BlogEditor(
                        controller: _blogTitleController,
                        hintText: "Blog title"),
                    spacing.hBox,
                    BlogEditor(
                        controller: _blogContentController,
                        hintText: "Blog content"),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
