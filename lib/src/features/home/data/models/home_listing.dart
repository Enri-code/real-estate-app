class HomeListing {
  final String image;
  final String text;

  HomeListing({
    required this.image,
    required this.text,
  });

  static List<HomeListing> data = [
    HomeListing(
      image: 'assets/images/home/home_img_1.png',
      text: 'Gladkova St., 25',
    ),
    HomeListing(
      image: 'assets/images/home/home_img_2.png',
      text: 'Gubina St., 11',
    ),
    HomeListing(
      image: 'assets/images/home/home_img_4.png',
      text: 'Gladkova St., 25',
    ),
    HomeListing(
      image: 'assets/images/home/home_img_3.png',
      text: 'Trefoleva St., 43',
    ),
  ];
}
