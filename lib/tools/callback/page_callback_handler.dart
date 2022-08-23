import 'dart:collection';

/// @author jv.lee
/// @date 2022/8/19
/// @description
class PageCallbackHandler<T> {
  final _callbacks = HashMap<String, T>();

  addCallback(String key, T callback) {
    if (!_callbacks.containsKey(key)) {
      _callbacks[key] = callback;
    }
  }

  removeCallback(String key) {
    if (_callbacks.containsKey(key)) {
      _callbacks.remove(key);
    }
  }

  notifyAll(PageCallback<T> callback) {
    _callbacks.forEach((key, value) {
      callback(value);
    });
  }

  notifyAllStick(PageCallback<T> callback) {
    _callbacks.forEach((key, value) {
      callback(value);
    });
  }

  notifyAt(String key, PageCallback<T> callback) {
    if (_callbacks.containsKey(key)) {
      callback(_callbacks[key] as T);
    }
  }

  dispose() {
    _callbacks.clear();
  }
}

typedef PageCallback<T> = void Function(T callback);
