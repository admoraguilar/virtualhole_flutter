import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'package:midnight_flutter/midnight_flutter.dart';

class LocalData {
  LocalData(this._fileName);

  final String _fileName;

  Map<String, dynamic> get data => _data;
  Map<String, dynamic> _data = {};

  File _file;
  Directory _directory;
  bool _isInit = false;

  Future<void> init() async {
    if (_isInit) {
      return;
    }

    _isInit = true;
    _directory = await getApplicationDocumentsDirectory();
    _file = File(_directory.path + '/' + _fileName);
    MLog.log(_file.path, prepend: (LocalData));

    load();
  }

  Future<bool> load() async {
    _checkInit();

    if (await _file.exists()) {
      String content = await _file.readAsString();
      _data = json.decode(content);
      return true;
    }

    return false;
  }

  Future<void> write(String key, dynamic value) async {
    _checkInit();

    if (!await load()) {
      await _file.create();
    }

    _data[key] = value;
    await _file.writeAsString(json.encode(_data));

    MLog.log('Write success', prepend: (LocalData));
  }

  void _checkInit() {
    if (!_isInit) {
      throw Exception(
          "[${(LocalData)}] Data hasn't been initialized yet. Make sure to call .init() first.");
    }
  }
}
