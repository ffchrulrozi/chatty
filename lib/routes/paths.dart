class PATH {
  static const String SPLASH = "/";
  static const String LOGIN = "/login";
  static const String DASHBOARD = "/dashboard";
  static ParamedPath CHAT_PERSONAL = ParamedPath("/chat/:id", "/chat");
}

class ParamedPath {
  String path;
  String name;
  ParamedPath(this.path, this.name);
}
