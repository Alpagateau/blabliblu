List findSubs(String Base, String motif) {
  List<int> indexes = [];
  int mLenght = motif.length;

  for (int i = 0; i < Base.length - mLenght; i++) {
    String test = Base.substring(i, mLenght + i);
    if (test == motif) {
      indexes.add(i);
    }
  }
  return indexes;
}
