class PATH {
  static const String SPLASH = "/";
  static const String LOGIN = "/login";
  static const String DASHBOARD = "/dashboard";
  static const String CONTACT_ADD = '/contact/add';
  static ParamedPath CONTACT_DETAIL = ParamedPath("/contact/detail/:id", "/contact/detail");
  static ParamedPath CHAT_PERSONAL = ParamedPath("/chat/:id", "/chat");
}

class ParamedPath {
  String path;
  String name;
  ParamedPath(this.path, this.name);
}
