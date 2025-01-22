enum ImagePaths {
  pregnant('pregnant.png'),
  thought('thought.png');

  final String name;
  const ImagePaths(this.name);

  String get path => 'assets/images/$name';
}
