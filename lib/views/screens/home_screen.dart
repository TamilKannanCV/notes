import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:notes/controllers/home_screen_controller.dart';
import 'package:notes/gen/assets.gen.dart';
import 'package:notes/router/app_router.gr.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sizer/sizer.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeScreenController homeScreenController;
  @override
  void initState() {
    super.initState();
    homeScreenController = Get.put(HomeScreenController());
    homeScreenController.fetchNotes();
    homeScreenController.listenToNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pushRoute(NotesRoute(id: "new"));
        },
        child: const Icon(Icons.add_rounded),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: const Text("KeepMyNotes"),
            actions: [
              IconButton(
                onPressed: () {
                  showAboutDialog(
                    context: context,
                    applicationName: "KeepMyNotes",
                    applicationVersion: Get.find<PackageInfo>().version,
                    applicationLegalese: "Tamil Kannan C V",
                  );
                },
                icon: const Icon(Icons.info_outline),
              ),
              const SizedBox(width: 10.0),
            ],
          ),
          Obx(() {
            if (homeScreenController.fetchingNotes.value == true) {
              return const SliverFillRemaining(
                hasScrollBody: false,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            if (homeScreenController.notes.isEmpty) {
              return SliverFillRemaining(
                hasScrollBody: false,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox.square(
                        dimension: 100.0,
                        child: Assets.images.logoOutlined.svg(),
                      ),
                      SizedBox(height: 2.0.h),
                      Text(
                        "No notes found",
                        style: TextStyle(
                          fontSize: 15.0.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            if (homeScreenController.notes.isNotEmpty) {
              return SliverPadding(
                padding: const EdgeInsets.all(10.0),
                sliver: SliverFillRemaining(
                  hasScrollBody: false,
                  child: StaggeredGrid.extent(
                    mainAxisSpacing: 10.0,
                    crossAxisSpacing: 10.0,
                    maxCrossAxisExtent: 50.0.w,
                    children: homeScreenController.notes
                        .map((e) => InkWell(
                              borderRadius: BorderRadius.circular(15.0),
                              onTap: () {
                                context.pushRoute(NotesRoute(id: e.id, note: e));
                              },
                              child: Container(
                                padding: const EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey.withOpacity(0.7)),
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      e.title,
                                      style: TextStyle(
                                        fontSize: 10.5.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      e.note,
                                      style: TextStyle(
                                        fontSize: 8.5.sp,
                                      ),
                                      maxLines: 10,
                                      overflow: TextOverflow.ellipsis,
                                    )
                                  ],
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                ),
              );
            }
            return const SliverToBoxAdapter();
          }),
        ],
      ),
    );
  }
}
