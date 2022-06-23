// ignore_for_file: file_names

class TravelPlace {
  final String imgUrl;
  final String videoUrl;
  TravelPlace({required this.imgUrl, required this.videoUrl});

  static final List<TravelPlace> places = [
    TravelPlace(imgUrl: 'assets/1.jpg', videoUrl: 'assets/1.mp4'),
    TravelPlace(imgUrl: 'assets/2.jpg', videoUrl: 'assets/2.mp4'),
    TravelPlace(imgUrl: 'assets/3.jpg', videoUrl: 'assets/1.mp4'),
    TravelPlace(imgUrl: 'assets/4.jpg', videoUrl: 'assets/2.mp4'),
    TravelPlace(imgUrl: 'assets/5.jpg', videoUrl: 'assets/1.mp4'),
  ];
}
