enum ImagePaths {
  pregnant('pregnant.png'),
  mommyWondering('mommy_wondering.png'),
  mamaThinking('mama_thinking.png'),
  thought('thought.png'),
  googleLogo('google_logo.png');

  final String name;
  const ImagePaths(this.name);

  String get path => 'assets/images/$name';
}

enum ImageOnboardingLayetteCustomizationPaths {
  climate('climate.png'),
  dueDate('due_date.png'),
  familyProfile('family_profile.png'),
  layetteDurationInMonths('layette_duration_in_months.png'),
  sexBaby('sex_baby.png'),
  summary('summary.png');

  final String name;
  const ImageOnboardingLayetteCustomizationPaths(this.name);

  String get path => 'assets/images/$name';
}

enum ImageThoughtPaths {
  girlClothes('girlClothes.png'),
  shoes('shoes.png'),
  boysClothes('boysClothes.png'),
  babySeat('babySeat.png');

  final String name;
  const ImageThoughtPaths(this.name);

  String get path => 'assets/images/$name';
}

enum ImageIconsPaths {
  googleLogo('google_logo.png');

  final String name;
  const ImageIconsPaths(this.name);

  String get path => 'assets/icons/$name';
}
