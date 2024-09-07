extension StringX on String {
  bool get isWhiteSpaceOrEmpty => trim().isEmpty;
  bool get isNotEmptyOrWhiteSpace => !isWhiteSpaceOrEmpty;
}
