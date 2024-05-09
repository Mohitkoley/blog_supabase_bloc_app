import 'package:blog_app/features/blog/data/models/blog_model.dart';
import 'package:hive/hive.dart';

abstract interface class BlogLocalDataSource {
  void uploadLocalBlogsAll({required List<BlogModel> blogs});
  List<BlogModel> loadBlogs();
}

class BlogLocalDataSourceImpl implements BlogLocalDataSource {
  final Box box;
  BlogLocalDataSourceImpl(this.box);
  @override
  List<BlogModel> loadBlogs() {
    List<BlogModel> blogs = [];
    box.read(() {
      for (var i = 0; i < box.length; i++) {
        blogs.add(BlogModel.fromLocalJson(box.getAt(i)));
      }
    });
    return blogs;
  }

  @override
  void uploadLocalBlogsAll({required List<BlogModel> blogs}) {
    box.clear();

    box.write(() {
      for (int i = 0; i < blogs.length; i++) {
        box.put(i.toString(), blogs[i].toJson());
      }
    });
  }
}
