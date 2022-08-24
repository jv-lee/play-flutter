/// @author jv.lee 
/// @date 2022/8/24
/// @description 
extension FunctionExtension on Function? {
  void checkNullInvoke() {
    if (this != null) {
      this!();
    }
  }
}