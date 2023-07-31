import 'package:auto_route/auto_route.dart';

import 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: HomeRoute.page,
          initial: true,
          path: '/notes',
          title: (context, data) => "Notes",
        ),
        AutoRoute(page: NotesRoute.page, path: "/notes/:id"),
      ];
}
