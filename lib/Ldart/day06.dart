class A {
  printMessage() => print('A');
}

class B {
  printMessage() => print('B');
}

mixin C on A {
  printMessage() {
    super.printMessage();
    print('C');
  }
}

class D with A, B, C {
  @override
  printMessage() {
    // TODO: implement printMessage
    return super.printMessage();
  }
}

void main() {
  D().printMessage();
}
