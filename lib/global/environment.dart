import 'dart:io';

class Environment {
  static String apiUrl = Platform.isAndroid
      ? "http://10.0.2.2:3000/api"
      : "http://localhost:3000/api";
  static String socketUrl =
      Platform.isAndroid ? "http://10.0.2.2:3000" : "http://localhost:3000";

  static String apiPrueba = "https://gorest.co.in/public-api/users/123/posts";

  //"https://server-app-chat-bsa.herokuapp.com/api"
}
