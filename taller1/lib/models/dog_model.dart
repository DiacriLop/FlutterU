class DogBreed {
  final String name;
  final List<String> subBreeds;
  final String? imageUrl;

  DogBreed({
    required this.name,
    required this.subBreeds,
    this.imageUrl,
  });

  factory DogBreed.fromJson(Map<String, dynamic> json, String breedName) {
    return DogBreed(
      name: breedName,
      subBreeds: List<String>.from(json['message'][breedName] ?? []),
      imageUrl: null,
    );
  }
}