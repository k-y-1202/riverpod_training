// private navigators
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_training/config/utils/enum/router_enum.dart';
import 'package:riverpod_training/features/auth/repo/auth_repo.dart';
import 'package:riverpod_training/features/task/view/five_tasks_page.dart';
import 'package:riverpod_training/features/task/view/task_tab_page.dart';
import 'package:riverpod_training/routing/go_router_refresh_streaml.dart';
import 'package:riverpod_training/features/user/view/edit_my_image_page.dart';
import 'package:riverpod_training/features/user/view/edit_my_user_page.dart';
import 'package:riverpod_training/features/task/view/add_or_edit_task_page.dart';
import 'package:riverpod_training/features/auth/view/auth_page.dart';
import 'package:riverpod_training/features/navigation/view/bottom_navigation_page.dart';
import 'package:riverpod_training/features/user/view/my_page.dart';
import 'package:riverpod_training/features/task/view/tasks_page.dart';
// ignore: depend_on_referenced_packages
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_training/features/user/view/users_page.dart';

part 'app_router.g.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellBottomNavigatorKey = GlobalKey<NavigatorState>();
final _shellTaskTabNavigatorKey = GlobalKey<NavigatorState>();

@riverpod
GoRouter goRouter(GoRouterRef ref) {
  return GoRouter(
    initialLocation: AppRoute.tasks.path,
    navigatorKey: _rootNavigatorKey,
    debugLogDiagnostics: true,
    redirect: (context, state) {
      //ページ遷移のたびにここが読み込まれる
      //ログインチェック
      if (ref.read(authRepoProvider) == null) {
        return AppRoute.auth.path;
      }

      return null;
    },

    ///右側のデータが変更されたら、redirect処理が走らせる
    refreshListenable: GoRouterRefreshStream(
      ref.watch(authRepoProvider.notifier).authStateChange(),
    ),
    routes: [
      GoRoute(
        path: AppRoute.auth.path,
        name: AppRoute.auth.name,
        pageBuilder: (context, state) {
          return const NoTransitionPage(child: AuthPage());
        },
      ),
      ShellRoute(
          navigatorKey: _shellBottomNavigatorKey,
          builder: (context, state, child) {
            return BottomNavigationPage(child: child);
          },
          routes: [
            //taskページを切り替えるタブのshellRoute
            ShellRoute(
              navigatorKey: _shellTaskTabNavigatorKey,
              builder: (context, state, child) {
                return TaskTabPage(child: child);
              },
              routes: [
                GoRoute(
                  path: AppRoute.tasks.path,
                  name: AppRoute.tasks.name,
                  pageBuilder: (context, state) {
                    return const NoTransitionPage(child: TasksScreen());
                  },
                  routes: [
                    GoRoute(
                      parentNavigatorKey: _rootNavigatorKey,
                      path: AppRoute.newTask.path,
                      name: AppRoute.newTask.name,
                      pageBuilder: (context, state) {
                        return const MaterialPage(
                            fullscreenDialog: true, child: AddOrEditTaskPage());
                      },
                    ),
                    GoRoute(
                      parentNavigatorKey: _rootNavigatorKey,
                      path: AppRoute.editTask.path,
                      name: AppRoute.editTask.name,
                      pageBuilder: (context, state) {
                        final taskId =
                            state.queryParameters['taskId'] as String;
                        return MaterialPage(
                          fullscreenDialog: true,
                          child: AddOrEditTaskPage(
                            taskId: taskId,
                          ),
                        );
                      },
                    ),
                  ],
                ),
                GoRoute(
                  path: AppRoute.fiveTasks.path,
                  name: AppRoute.fiveTasks.name,
                  pageBuilder: (context, state) {
                    return const NoTransitionPage(child: FiveTasksPage());
                  },
                ),
              ],
            ),
            GoRoute(
              path: AppRoute.users.path,
              name: AppRoute.users.name,
              pageBuilder: (context, state) {
                return const NoTransitionPage(child: UsersPage());
              },
            ),
            GoRoute(
                path: AppRoute.mypage.path,
                name: AppRoute.mypage.name,
                pageBuilder: (context, state) {
                  return const NoTransitionPage(child: MyPage());
                },
                routes: [
                  GoRoute(
                    path: AppRoute.editMyPage.path,
                    name: AppRoute.editMyPage.name,
                    parentNavigatorKey: _rootNavigatorKey,
                    pageBuilder: (context, state) {
                      return const NoTransitionPage(child: EditMyUserPage());
                    },
                  ),
                  GoRoute(
                    path: AppRoute.editMyImagePage.path,
                    name: AppRoute.editMyImagePage.name,
                    parentNavigatorKey: _rootNavigatorKey,
                    pageBuilder: (context, state) {
                      return const NoTransitionPage(child: EditMyImagePage());
                    },
                  ),
                ]),
          ]),
    ],
  );
}
