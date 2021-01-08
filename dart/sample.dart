import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

///class uses share preferences to save data on device
class LocalStorage {
  //final String authStoreKey = '_auth_store';
  final String lastRoute = '_last_route';
  final String userInfoStore = '_user_info_store';

  ///gets the store instance
  Future<SharedPreferences> _store() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs;
  }

  ///fetches the store value assigned to the
  ///passed [key]
  Future<String> fetch(String key) async {
    SharedPreferences dbInstance = await this._store();
    String content = dbInstance.getString(key);
    return content;
  }

  ///binds [data] as value to [key] passed
  ///and stores on disk
  Future<bool> save(String key, Map<String, dynamic> data) async {
    SharedPreferences dbInstance = await this._store();
    String d = json.encode(data);
    bool state = await dbInstance.setString(key, d);
    return state;
  }

  ///removes data tied to a [key]
  Future<bool> delete(String key) async {
    SharedPreferences dbInstance = await this._store();
    bool state = await dbInstance.remove(key);
    return state;
  }
}

class UserStore extends LocalStorage {
  ///fetches user information from the localstorage
  Future<Map<String, dynamic>> fetchUserInfo() async {
    Map<String, dynamic> store = await this._storageContent();
    if (store != null) {
      return store['user'];
    }
    return null;
  }

  ///fetches the access token for user's request
  Future<String> fetchAccessToken() async {
    Map<String, dynamic> store = await this._storageContent();
    if (store != null) {
      return store['token'];
    }
    return null;
  }

  ///gets the store content for this store
  Future<Map<String, dynamic>> _storageContent() async {
    String data = await this.fetch(this.userInfoStore);
    if (data != null) {
      return json.decode(data);
    }
    return null;
  }

  ///updates the user's access token
  ///[newToken]
  Future<bool> updateUserToken(String newToken) async {
    Map<String, dynamic> store = await this._storageContent();
    if (store != null) {
      store['token'] = newToken;
      this.save(this.userInfoStore, store);
      return true;
    }
    return false;
  }

  ///updates the user's profile information
  ///[data]
  Future<bool> updateUserInfo(Map<String, dynamic> data) async {
    Map<String, dynamic> store = await this._storageContent();
    if (store != null) {
      store['user'] = data;
      this.save(this.userInfoStore, store);
      return true;
    }
    return false;
  }

  ///updates the user's wallet information
  ///[data]
  Future<bool> updateWallet(Map<String, dynamic> data) async {
    Map<String, dynamic> store = await this._storageContent();
    if (store != null) {
      store['wallet'] = data;
      this.save(this.userInfoStore, store);
      return true;
    }
    return false;
  }

  ///updates the user's bank profile
  ///[data]
  Future<bool> updateBankProfile(Map<String, dynamic> data) async {
    Map<String, dynamic> store = await this._storageContent();
    if (store != null) {
      store['bank'] = data;
      this.save(this.userInfoStore, store);
      return true;
    }
    return false;
  }

  ///updates services rendered by the user
  Future<bool> updateServices(List<dynamic> data) async {
    Map<String, dynamic> store = await this._storageContent();
    if (store != null) {
      store['services'] = data;
      this.save(this.userInfoStore, store);
      return true;
    }
    return false;
  }

  ///fetches the user's wallet information
  Future<Map<String, dynamic>> fetchWallet() async {
    Map<String, dynamic> store = await this._storageContent();
    if (store != null) {
      return store['wallet'];
    }
    return null;
  }

  ///fetches the user's bank profile
  Future<Map<String, dynamic>> fetchBankProfile() async {
    Map<String, dynamic> store = await this._storageContent();
    if (store != null) {
      return store['bank'];
    }
    return null;
  }

  ///fetches the user's services from cache
  Future<List<dynamic>> fetchServices() async {
    Map<String, dynamic> store = await this._storageContent();
    if (store != null) {
      return store['services'];
    }
    return null;
  }

  ///cache profile
  ///data should contain keys [wallet], [userBankProfile] and [userServices]
  Future<void> updateProfile(dynamic data) async {
    await this.updateWallet(data['wallet']);
    await this.updateBankProfile(data['userBankProfile']);
    await this.updateServices(data['userServices']);
  }
}
