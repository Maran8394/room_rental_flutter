extension TitleCase on String {
  String get titleCase => split(' ')
      .map((word) => word[0].toUpperCase() + word.substring(1))
      .join(' ');
}
