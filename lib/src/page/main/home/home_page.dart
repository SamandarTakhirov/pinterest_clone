import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pinterest_clone/src/common/constants/app_color.dart';
import 'package:pinterest_clone/src/common/constants/app_icons.dart';

import '../../../common/service/api_service.dart';
import '../../../common/utils/debouncing_throttling.dart';
import '../../../data/repository.dart';
import '../../../models/photo_model.dart';
import 'widgets/ads_widget.dart';
import 'widgets/categories.dart';
import 'widgets/staggered_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final IPhotoRepository photoRepository;
  late final TextEditingController controller;
  List<PhotoModel> photos = [];
  bool isLoading = false;
  bool isPaginationLoading = false;
  late final PageController scrollController;
  int page = 1;
  int searchPage = 1;
  final double expandedHeight = 300;
  final deBouncing = DeBouncing(const Duration(milliseconds: 300));
  bool isSelected = false;

  @override
  void initState() {
    super.initState();
    photoRepository = PhotoRepositoryImpl(APIService());
    controller = TextEditingController();
    scrollController = PageController()
      ..addListener(pagination)
      ..addListener(appBarExtend);
    getPhotos();
  }

  @override
  void dispose() {
    controller.dispose();
    scrollController
      ..removeListener(pagination)
      ..removeListener(appBarExtend);
    scrollController.dispose();
    deBouncing.dispose();
    super.dispose();
  }

  void getPhotos() async {
    setState(() => isLoading = true);

    page = 1;
    photos = await photoRepository.paginationPhotos(page++);
    photos.shuffle();
    setState(() => isLoading = false);
  }

  void pagination() async {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      if (controller.text.trim().isNotEmpty) {
        List<PhotoModel> paginationPhoto = await photoRepository.searchPhotos(
          searchPage++,
          controller.text.trim(),
        );
        photos.addAll(paginationPhoto);
        setState(() {});
      } else {
        List<PhotoModel> paginationPhoto =
            await photoRepository.paginationPhotos(page++);
        photos.addAll(paginationPhoto);
        setState(() {});
      }
    }
  }

  void searchingPhotos(String text) {
    setState(() => isLoading = true);

    deBouncing.handler(() async {
      if (text.isEmpty) {
        searchPage = 1;
        getPhotos();
      } else {
        photos = await photoRepository.searchPhotos(
          searchPage++,
          text.trim(),
        );
      }
      setState(() => isLoading = false);
    });
  }

  bool get isAppBarExpanded =>
      scrollController.hasClients &&
      scrollController.offset > (expandedHeight - kToolbarHeight);

  void appBarExtend() {
    setState(() {});
  }

  void onTap() {
    setState(() {
      if (isSelected) {
        isSelected = false;
      } else {
        isSelected = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: AppColor.black,
      body: Stack(
        children: [
          isSelected
              ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: MasonryGridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 2,
              crossAxisSpacing: 2,
              controller: scrollController,
              itemCount: photos.length,
              itemBuilder: (BuildContext context, int index) {
                return index == index ~/ 5 + 3
                    ? const AdsWidget()
                    : StaggeredWidget(
                  text: photos[index].user?.name ?? "",
                  height: photos[index].height ?? 5.0,
                  width: photos[index].width ?? 5.0,
                  image: photos[index].urls?.small ?? "",
                );
              },
            ),
          )
              : PageView.builder(
                  controller: scrollController,
                  scrollDirection: Axis.vertical,
                  onPageChanged: (value) {
                    setState(
                      () {
                        scrollController.animateToPage(
                          value,
                          duration: const Duration(microseconds: 150),
                          curve: Curves.easeOutSine,
                        );
                      },
                    );
                  },
                  itemBuilder: (context, index) {
                    return SizedBox(
                      height: size.height - 75,
                      child: Stack(
                        children: [
                          Positioned(
                            height: size.height,
                            child: Image(
                              image: NetworkImage(
                                photos[index].urls?.regular ?? "",
                              ),
                              width: size.width,
                              height: size.height,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            right: size.width - 220,
                            top: size.height - 140,
                            width: 200,
                            child: Container(
                              width: double.infinity,
                              height: 70,
                              decoration: const BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: AppColor.black,
                                      blurRadius: 250,
                                      spreadRadius: 150,
                                      blurStyle: BlurStyle.normal,
                                      offset: Offset(75, 100)),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    photos[index].user?.name ?? "",
                                    style: const TextStyle(
                                      color: AppColor.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    photos[index].user?.instagramUsername ?? "",
                                    style: const TextStyle(
                                      color: AppColor.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  itemCount: photos.length,
                ),
          Positioned(
            top: 50,
            left: 10,
            right: 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  style: IconButton.styleFrom(
                    maximumSize: const Size(55, 55),
                  ),
                  onPressed: () {},
                  icon: Image.asset(AppIcons.icBill),
                ),
                Categories(
                  isSelected: isSelected,
                  onTap: onTap,
                ),
                IconButton(
                  style: IconButton.styleFrom(
                    maximumSize: const Size(55, 55),
                  ),
                  onPressed: () {},
                  icon: Image.asset(AppIcons.icSearch),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
