// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i3;
import 'package:flutter/material.dart' as _i4;
import 'package:notes/models/note.dart' as _i5;
import 'package:notes/views/screens/home_screen.dart' as _i1;
import 'package:notes/views/screens/notes_screen.dart' as _i2;

abstract class $AppRouter extends _i3.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i3.PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      return _i3.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.HomeScreen(),
      );
    },
    NotesRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<NotesRouteArgs>(
          orElse: () => NotesRouteArgs(id: pathParams.optString('id')));
      return _i3.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.NotesScreen(
          key: args.key,
          id: args.id,
          note: args.note,
        ),
      );
    },
  };
}

/// generated route for
/// [_i1.HomeScreen]
class HomeRoute extends _i3.PageRouteInfo<void> {
  const HomeRoute({List<_i3.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i3.PageInfo<void> page = _i3.PageInfo<void>(name);
}

/// generated route for
/// [_i2.NotesScreen]
class NotesRoute extends _i3.PageRouteInfo<NotesRouteArgs> {
  NotesRoute({
    _i4.Key? key,
    String? id,
    _i5.Note? note,
    List<_i3.PageRouteInfo>? children,
  }) : super(
          NotesRoute.name,
          args: NotesRouteArgs(
            key: key,
            id: id,
            note: note,
          ),
          rawPathParams: {'id': id},
          initialChildren: children,
        );

  static const String name = 'NotesRoute';

  static const _i3.PageInfo<NotesRouteArgs> page =
      _i3.PageInfo<NotesRouteArgs>(name);
}

class NotesRouteArgs {
  const NotesRouteArgs({
    this.key,
    this.id,
    this.note,
  });

  final _i4.Key? key;

  final String? id;

  final _i5.Note? note;

  @override
  String toString() {
    return 'NotesRouteArgs{key: $key, id: $id, note: $note}';
  }
}
