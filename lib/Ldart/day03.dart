// 命名可选参数 （{}）
String test01({String s = "2", String b}) {
  return s + b.toString();
}

// 位置可选参数  （） 默认值[]
String test02(String s, [String b = "2"]) {
  return s + b;
}

void main(List<String> args) {
  print(args);
  print(test01(s: "1", b: "2")); //调用命名可选参数
  print(test02("1", "2")); // 调用位置可选参数
}
