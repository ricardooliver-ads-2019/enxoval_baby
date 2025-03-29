enum ImagePaths {
  pregnant('pregnant.png'),
  thought('thought.png'),
  googleLogo('google_logo.png');

  final String name;
  const ImagePaths(this.name);

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
