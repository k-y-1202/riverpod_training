enum AppRoute {
  login,
  tasks,
  fiveTasks,
  newTask,
  auth,
  editTask,
  mypage,
  editMyPage,
  editMyImagePage,
  users,
}

extension AppRouteExtention on AppRoute {
  String get path {
    switch (this) {
      case AppRoute.auth:
        return "/auth";
      case AppRoute.tasks:
        return "/tasks";
      case AppRoute.fiveTasks:
        return "/fiveTasks";
      case AppRoute.newTask:
        return "newTask";
      case AppRoute.editTask:
        return "editTask";
      case AppRoute.users:
        return "/users";
      case AppRoute.mypage:
        return "/mypage";
      case AppRoute.editMyPage:
        return "editMyPage";
      case AppRoute.editMyImagePage:
        return "editMyImagePage";
      default:
        return "/tasks";
    }
  }
}
