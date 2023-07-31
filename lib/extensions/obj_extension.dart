extension ObjExt<T> on T {
  R let<R>(R Function(T value) op) => op(this);
}
