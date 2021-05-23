String numberToStringWithComma(int number) {
  RegExp reg = new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
  Function(Match) match = (Match m) => '${m[1]},';
  return number.toString().replaceAllMapped(reg, match);
} 