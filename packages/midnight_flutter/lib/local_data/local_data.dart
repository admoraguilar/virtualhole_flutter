import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'package:midnight_flutter/midnight_flutter.dart';

class LocalData<T> {
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
    _file = File(_directory.path + '/' + _fileName + '.json');
    MLog.log(_file.path, prepend: (LocalData));
  }

  Future<T> load(T Function(dynamic) decoder, T fallback) async {
    if (await _loadData()) {
      MLog.log('Successfully loaded ${_directory.path}');
      return decoder(_data);
    }
    return fallback;
  }

  Future<void> write(T value) async {
    _checkInit();

    if (!await _loadData()) {
      await _file.create();
    }

    // _data[key] = value;
    await _file.writeAsString(json.encode(value));

    MLog.log('Successfully written at ${_directory.path}',
        prepend: (LocalData));
  }

  void _checkInit() {
    if (!_isInit) {
      throw Exception(
          "[${(LocalData)}] Data hasn't been initialized yet. Make sure to call .init() first.");
    }
  }

  Future<bool> _loadData() async {
    _checkInit();

    if (await _file.exists()) {
      String content = await _file.readAsString();
      _data = json.decode(content);
      return true;
    }

    return false;
  }
}
