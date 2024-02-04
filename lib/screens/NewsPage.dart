import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project1/components/NewsPage/NewsTab1.dart';
import 'package:project1/controller/RequestController.dart';

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage>
    with SingleTickerProviderStateMixin {
  final GetCategoryController categoryController =
      Get.put(GetCategoryController());
  final GetNewsController newsController = Get.put(GetNewsController());

  late TabController _tabController;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();

    if (categoryController.request.isNotEmpty) {
      _initializeControllers();
    } else {
      ever(
        categoryController.request,
        (_) {
          if (categoryController.request.isNotEmpty) {
            _initializeControllers();
          }
        },
      );
    }
  }

  void _initializeControllers() {
    _tabController = TabController(
      length: categoryController.request.length,
      vsync: this,
    );
    _pageController = PageController();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _refresh() async {
    await newsController.getNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Мэдээ, мэдээлэл',
            style: TextStyle(fontWeight: FontWeight.w600)),
      ),
      body: Obx(
        () => categoryController.isLoading.value
            ? Center(
                child: CircularProgressIndicator(),
              )
            : RefreshIndicator(
                onRefresh: _refresh,
                child: Column(
                  children: [
                    TabBar(
                      controller: _tabController,
                      isScrollable: true,
                      onTap: (index) {
                        var selectedCategoryId =
                            categoryController.request[index].id;
                        newsController.selectedCategoryId.value =
                            selectedCategoryId;
                        if (!newsController.request.value.news
                            .any((news) => news.id == selectedCategoryId)) {
                          newsController.getNews();
                        }
                        _pageController.animateToPage(
                          index,
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      },
                      tabs: categoryController.request
                          .map((category) => Tab(
                                text: category.categoryName,
                              ))
                          .toList(),
                    ),
                    Expanded(
                      child: PageView(
                        controller: _pageController,
                        onPageChanged: (index) {
                          _tabController.animateTo(index);
                          var selectedCategoryId =
                              categoryController.request[index].id;
                          newsController.selectedCategoryId.value =
                              selectedCategoryId;
                          if (!newsController.request.value.news
                              .any((news) => news.id == selectedCategoryId)) {
                            newsController.getNews();
                          }
                        },
                        children: categoryController.request
                            .map(
                              (category) => NewsTab1(categoryId: category.id),
                            )
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
