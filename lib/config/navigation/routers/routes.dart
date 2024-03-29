import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quote_generator/config/config.dart';
import 'package:quote_generator/features/features.dart';

final _shellNavigatorKey = GlobalKey<NavigatorState>();

final routes = [
  GoRoute(
    path: RouteLocation.splash,
    parentNavigatorKey: navigationKey,
    builder: SplashScreen.builder,
  ),
  GoRoute(
    path: RouteLocation.createQuote,
    parentNavigatorKey: navigationKey,
    builder: CreateQuoteScreen.builder,
  ),
  GoRoute(
    name: RouteLocation.detailScreen,
    path: '${RouteLocation.detailScreen}/:id',
    parentNavigatorKey: navigationKey,
    pageBuilder: (context, state) {
      return NoTransitionPage(
        child: QuoteDetailScreen.builder(
          context,
          state,
          state.pathParameters['id'],
        ),
      );
    },
  ),

  GoRoute(
    name: RouteLocation.remoteQuoteDetailScreen,
    path: '${RouteLocation.remoteQuoteDetailScreen}/:quoteId',
    parentNavigatorKey: navigationKey,
    pageBuilder: (context, state) {
      return NoTransitionPage(
        child: RemoteQuoteDetailScreen.builder(
          context,
          state,
          '${state.pathParameters['quoteId']}',
        ),
      );
    },
  ),

  GoRoute(
    path: RouteLocation.profile,
    parentNavigatorKey: navigationKey,
    builder: ProfileScreen.builder,
  ),

  GoRoute(
    path: RouteLocation.auth,
    parentNavigatorKey: navigationKey,
    builder: AuthScreen.builder,
  ),

  //Bottom Nav bar shell
  ShellRoute(
    navigatorKey: _shellNavigatorKey,
    pageBuilder: (context, state, child) {
      return NoTransitionPage(
        child: BottomNavBarShell.builder(
          context,
          state,
          child,
        ),
      );
    },
    routes: [
      GoRoute(
        path: RouteLocation.createdByYou,
        parentNavigatorKey: _shellNavigatorKey,
        pageBuilder: (context, state) {
          return NoTransitionPage(
            child: CreatedByYouScreen.builder(context, state),
          );
        },
      ),
      GoRoute(
        path: RouteLocation.discovery,
        parentNavigatorKey: _shellNavigatorKey,
        pageBuilder: (context, state) {
          return NoTransitionPage(
            child: DiscoveryScreen.builder(context, state),
          );
        },
      ),
      GoRoute(
        path: RouteLocation.search,
        parentNavigatorKey: _shellNavigatorKey,
        pageBuilder: (context, state) {
          return NoTransitionPage(
            child: SearchScreen.builder(context, state),
          );
        },
      ),
      GoRoute(
        path: RouteLocation.favorites,
        parentNavigatorKey: _shellNavigatorKey,
        pageBuilder: (context, state) {
          return NoTransitionPage(
            child: FavoriteScreen.builder(context, state),
          );
        },
      ),
      GoRoute(
        path: RouteLocation.settings,
        parentNavigatorKey: _shellNavigatorKey,
        pageBuilder: (context, state) {
          return NoTransitionPage(
            child: SettingsScreen.builder(context, state),
          );
        },
      ),
    ],
  ),
];
