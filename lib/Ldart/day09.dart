import 'dart:io';

Future<Null> s1() async {
  sleep(Duration(seconds: 2));
  print("S1" + DateTime.now().toString());
}

s2() async {
  bool t = await t1();
  if (t) {
    print("T1E");
  }
  print("S2" + DateTime.now().toString());
}

Future<bool> t1() async {
  sleep(Duration(seconds: 2));
  print("T1" + DateTime.now().toString());
  return true;
}

main(List<String> args) {
  print("A1" + DateTime.now().toString());
  s1();
  s2();
  print("A2" + DateTime.now().toString());
}
