enum ImagePaths {
  pregnant('pregnant.png'),
  thought('thought.png');

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
