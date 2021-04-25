class Valid {
  static bool email({String text}){
    return RegExp(r"[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$").hasMatch(text);
  }

  static bool password({String text}){
    return RegExp(r"""^(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$""").hasMatch(text);
  }

  static bool phone({String text}){
    return RegExp(r"^[0-9]{3}[-]+[0-9]{4}[-]+[0-9]{4}$").hasMatch(text);
  }
}