/// @author jv.lee
/// @date 2022/8/15
/// @description app事件总线
class EventBus {
  EventBus._internal();

  static final EventBus _instance = EventBus._internal();

  static EventBus getInstance() => _instance;

  final _events = <String, List<EventCallback>>{};

  void bind(eventKey, EventCallback callback) {
    _events[eventKey] ??= [];
    _events[eventKey]?.add(callback);
  }

  void unbind(eventKey, EventCallback callback) {
    _events[eventKey]?.remove(callback);
  }

  void send(eventKey, arg) {
    _events[eventKey]?.forEach((element) {
      element(arg);
    });
  }
}

typedef EventCallback = Function(dynamic arg);

final eventBus = EventBus.getInstance();
