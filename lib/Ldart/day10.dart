test() async {
  int result = await Future.delayed(Duration(milliseconds: 2000), () {
    return Future.value(123);
  });
  print("t3" + DateTime.now().toString());
  print(result);
}

main(List<String> args) {
  print("t1");
  test();
  print("t2");
}
