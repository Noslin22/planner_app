final accents = {
  'á': 'a',
  'à': 'a',
  'ã': 'a',
  'â': 'a',
  'é': 'e',
  'è': 'e',
  'ê': 'e',
  'ì': 'i',
  'í': 'i',
  'î': 'i',
  'ó': 'o',
  'ò': 'o',
  'ô': 'o',
  'õ': 'o',
  'ú': 'u',
  'ù': 'u',
  'û': 'u',
};

extension AccentsExtension on String {
  bool get hasAccent {
    return split('').any(
      (letter) => accents.keys.contains(letter),
    );
  }

  String get withoutAccents {
    if (hasAccent) {
      String result = this;
      for (final accent in accents.keys) {
        result = result.replaceAll(accent, accents[accent] ?? '');
      }
      return result;
    } else {
      return this;
    }
  }
}
