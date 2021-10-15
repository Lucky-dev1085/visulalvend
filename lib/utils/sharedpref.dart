import 'package:shared_preferences/shared_preferences.dart';
import 'package:visualvend/models/menu_option_model.dart';

class SharedPrefs {
  static SharedPreferences prefs;

  static const String KEY_HISTORY_OPTIONS = 'VISUAL_VEND_HISTORY_OPTIONS';

  static const String KEY_VEND_HISTORY_LAST_RECEIPTS = 'VEND_HISTORY_LAST_RECEIPTS';
  static const String KEY_VEND_HISTORY_ORDER_ITEM = 'VEND_HISTORY_ORDER_ITEM';
  static const String KEY_VEND_HISTORY_ITEM_FAVORITES = 'VEND_HISTORY_ITEM_FAVORITES';

  static const String KEY_VEND_MACHINE_NEARBY = 'VEND_MACHINE_NEARBY';
  static const String KEY_VEND_MACHINE_BY_LOCATION = 'VEND_MACHINE_BY_LOCATION';
  static const String KEY_VEND_MACHINE_FULL_LIST = 'VEND_MACHINE_FULL_LIST';

  static const String KEY_VEND_PRODUCT_MENU = 'VEND_PRODUCT_MENU';
  static const String KEY_VEND_PRODUCT_LAYOUT = 'VEND_PRODUCT_LAYOUT';
  static const String KEY_VEND_PRODUCT_KEYPAD = 'VEND_PRODUCT_KEYPAD';

  static const String KEY_VEND_FAVORITE_MACHINE = 'VEND_FAVORITE_MACHINE';
  static const String KEY_VEND_FAVORITE_PRODUCT = 'VEND_FAVORITE_PRODUCT';

  static const String KEY_CREDIT_CARD_ADDED = 'VEND_CREDIT_CARD_ADDED';
  static const String KEY_SEARCH_TYPE = 'VEND_SEARCH_TYPE';

  static const String KEY_BADGE_VALUE = 'VEND_BADGE_VALUE';

  static void saveBool(String key, bool value) {
    prefs.setBool(key, value);
  }

  static bool getBool(String key, {bool defaultValue: false}) {
    return prefs.getBool(key) ?? defaultValue;
  }

  static void saveInt(String key, int value) {
    prefs.setInt(key, value);
  }

  static int getInt(String key, {defaultValue: 0}) {
    return prefs.getInt(key) ?? defaultValue;
  }

  static void saveDouble(String key, double value)  {
    prefs.setDouble(key, value);
  }

  static double getDouble(String key, {defaultValue: 0}) {
    return prefs.getDouble(key) ?? defaultValue;
  }

  static void saveString(String key, String value)  {
    prefs.setString(key, value);
  }

  static String getString(String key, {String defalutValue = ''}) {
    return prefs.getString(key) ?? defalutValue;
  }

  static void clear()  {
    prefs.clear();
  }

  static void setMenuOption(String menuKey, MenuOptionModel menuOption){
    prefs.setString(menuKey + '_TITLE', menuOption.title);
    prefs.setString(menuKey + '_ASSET', menuOption.assetIcon);
    prefs.setBool(menuKey + '_ISHIDE', menuOption.isHide);
  }

  static MenuOptionModel getMenuOption(String menuKey, ) {
    String retVal = prefs.getString(menuKey + '_TITLE') ?? '';
    if(retVal != ''){
      MenuOptionModel model = new MenuOptionModel();
      model.title = prefs.getString(menuKey + '_TITLE') ?? '';
      model.assetIcon = prefs.getString(menuKey + '_ASSET') ?? '';
      model.isHide = prefs.getBool(menuKey + '_ISHIDE') ?? false;
      return model;
    }
    return new MenuOptionModel();
  }
}