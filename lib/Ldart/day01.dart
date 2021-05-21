String name = "job";
final String nickname = "job2";

const bar = 100000;
const double atm = 1.01325 * bar;

var foo = [];
final ba1r = const [];
const baz = [];

void test01() {
  name = "Alice";
  print(name);
  foo.add("1");
  print(foo);
}

void main(List<String> args) {
  test01();
  foo.add('2');
  print(foo.map((e) => e + "aaa").toList());
  print(foo.map((e) => e + "aaa"));
  // print(foo);
  print(foo.length);
}
