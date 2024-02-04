import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project1/widgets/NewsList.dart';
import 'package:project1/controller/RequestController.dart';
import 'package:project1/widgets/NewsBanner.dart';

class NewsTab1 extends StatelessWidget {
  var controller = Get.put(GetNewsController());
  final String categoryId;

  NewsTab1({required this.categoryId});

  Future<void> _refresh() async {
    await controller.getNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () {
          if (controller.isLoading.value) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return CustomScrollView(
              slivers: [
                NewsBanner(),
                NewsList(controller: controller),
              ],
            );
          }
        },
      ),
    );
  }
}
