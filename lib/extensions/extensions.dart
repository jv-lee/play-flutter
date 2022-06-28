/// @author jv.lee
/// @date 2022/6/28
/// @description
extension FunctionExtension on Function? {
  void checkNullInvoke() {
    if (this != null) {
      this!();
    }
  }
}