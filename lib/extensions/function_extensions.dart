/// @author jv.lee
/// @date 2022/8/24
/// @description 公共方法扩展函数
extension FunctionExtensions<T> on T {
  run(Function(T self) block) {
    block(this);
  }

  R let<R>(R Function(T self) block) {
    return block(this);
  }

  T also(Function(T self) block) {
    block(this);
    return this;
  }
}

extension FunctionExtension on Function? {
  void checkNullInvoke() => this?.run((self) => self());
}
