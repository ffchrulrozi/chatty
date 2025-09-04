class PATH {
  static ParamedPath SPLASH = ParamedPath("/", "/");
  static ParamedPath LOGIN = ParamedPath("/login", "/login") ;
  static ParamedPath DASHBOARD = ParamedPath("/dashboard", "/dashboard");
  static ParamedPath CONTACT_ADD = ParamedPath('/contact/add', '/contact/add') ;
  static ParamedPath CONTACT_DETAIL = ParamedPath("/contact/detail/:id", "/contact/detail");
  static ParamedPath CHAT_LIST_CONTACT = ParamedPath("/chat/list-contact", "/chat/list-contact");
  static ParamedPath CHAT_PERSONAL = ParamedPath("/chat/personal/:id", "/chat/personal");
}

class ParamedPath {
  String path;
  String name;
  ParamedPath(this.path, this.name);
}
