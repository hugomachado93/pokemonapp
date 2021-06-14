import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesConfig {

  static final String _favorites = "favorites";
  static final String _lastSearch = "lastsearch";

  static Future<List<String>> getFavorite() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getStringList(_favorites);
  }

  static Future<bool> setFavorite(List<String> value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setStringList(_favorites, value);
  }

  static Future<bool> setLastSearch(List<String> value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setStringList(_lastSearch, value);
  }

  static Future<List<String>> getLastSearch() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getStringList(_lastSearch);
  } 

}