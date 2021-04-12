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
}
