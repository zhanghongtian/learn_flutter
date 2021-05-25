class A{
  String get Massage{
    return "A";
  }
}

class B{
  String get Massage{
    return "B";
  }
}


class P{
  String get Massage{
    return "P";
  }
}

class AB extends P with A,B{

}


class BA extends P with B,A{

}

main(List<String> args) {
  String result = '';
  AB ab = AB();
  result += ab.Massage;

  BA ba = BA();
  result += ba.Massage;

  print(result);

}