import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/io.dart';

class CodeProvider extends ChangeNotifier {
  IOWebSocketChannel _channel;
  String _code = '';
  String get code => _code;
  set code(String sequence) {
    this._code = sequence;
    notifyListeners();
  }

  void connect() {
    _channel = IOWebSocketChannel.connect('wss://192.168.0.46:80');
  }
  
  void sendMessage(String msg) {
    _channel.sink.add(msg);
  }

  void disconnect() {
    _channel.sink.close();
  }
}
