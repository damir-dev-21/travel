import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:test_anim/models/place.dart';
import 'package:video_player/video_player.dart';

class MainPage extends StatefulWidget {
  MainPage({
    Key? key,
  }) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _pageController = PageController(viewportFraction: 0.85);
  //List<Map<String, dynamic>> listOfController = [];
  late VideoPlayerController _controller;

  double _currentPage = 0.0;
  double indexPage = 0.0;

  void _listener() {
    setState(() {
      _currentPage = _pageController.page!;
      if (_currentPage >= 0 && _currentPage < 0.8) {
        indexPage = 0;
      } else if (_currentPage > 0.8 && _currentPage < 1.8) {
        indexPage = 1;
      } else if (_currentPage > 1.8 && _currentPage < 2.8) {
        indexPage = 2;
      } else if (_currentPage > 2.8 && _currentPage < 3.8) {
        indexPage = 3;
      } else if (_currentPage > 3.8 && _currentPage < 4.8) {
        indexPage = 4;
      }
    });
  }

  // final imgUrl = [
  //   'assets/1.jpg',
  //   'assets/2.jpg',
  //   'assets/3.jpg',
  //   'assets/4.jpg',
  //   'assets/5.jpg',
  // ];

  final categoryList = [
    'Thailand',
    'Vietnam',
    'Italy',
    'Turkey',
    'Albania',
    'Moscow',
    'Montenegro',
  ];

  var idx = 0;

  void setVideo(path) {
    _controller = VideoPlayerController.asset(path)
      ..initialize().then((_) {
        // Once the video has been loaded we play the video and set looping to true.
        _controller.play();
        _controller.setLooping(true);
        _controller.setVolume(0);
        // Ensure the first frame is shown after the video is initialized.
        setState(() {});
      });
    // TravelPlace.places.forEach((element) {
    //   var controller = VideoPlayerController.asset(element.videoUrl);
    //   listOfController.add({'id': element.videoUrl, 'controller': controller});
    // });
  }

  // VideoPlayerController getVideo(path) {
  //   Map<String, dynamic> controllerVideo =
  //       listOfController.firstWhere((element) => element['id'] == path);
  //   return controllerVideo['controller']
  //     ..initialize().then((value) {
  //       // Once the video has been loaded we play the video and set looping to true.
  //       value.play();
  //       value.setLooping(true);
  //       value.setVolume(0);
  //       // Ensure the first frame is shown after the video is initialized.
  //       setState(() {});
  //     });
  // }

  @override
  void initState() {
    super.initState();
    _pageController.addListener(_listener);
    _controller = VideoPlayerController.asset(TravelPlace.places[idx].videoUrl)
      ..initialize().then((_) {
        // Once the video has been loaded we play the video and set looping to true.
        //_controller.play();
        _controller.setLooping(false);
        _controller.setVolume(0);
        // Ensure the first frame is shown after the video is initialized.
        setState(() {});
      });
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(TravelPlace.places[idx].imgUrl),
                  fit: BoxFit.cover)),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Column(
              children: [
                SizedBox(
                  height: kToolbarHeight + 30,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.menu, color: Colors.white)),
                        const Text('Test anim app',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white)),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.search, color: Colors.white))
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.keyboard_arrow_down,
                              color: Colors.white),
                          Expanded(
                            child: ListView.builder(
                              itemCount: categoryList.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                    margin: const EdgeInsets.only(right: 25),
                                    child: Text(
                                      categoryList[index],
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 15),
                                    ));
                              },
                            ),
                          )
                        ]),
                  ),
                ),
                Expanded(
                  child: PageView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: TravelPlace.places.length,
                      controller: _pageController,
                      onPageChanged: (value) {
                        idx = value;

                        setState(() {
                          _controller.dispose();
                          _controller = VideoPlayerController.asset(
                              TravelPlace.places[idx].videoUrl)
                            ..initialize().then((_) {
                              // Once the video has been loaded we play the video and set looping to true.
                              _controller.play();
                              _controller.setLooping(false);
                              _controller.setVolume(0);
                              // Ensure the first frame is shown after the video is initialized.
                              setState(() {});
                            });
                        });
                        _onTapVideo(idx);
                      },
                      itemBuilder: (context, index) {
                        final item = TravelPlace.places[index].imgUrl;
                        return Padding(
                          padding: EdgeInsets.only(
                            right: index == indexPage ? 0 : 30,
                          ),
                          child: Transform.translate(
                            offset: Offset(index == indexPage ? 5 : 20, 0),
                            child:
                                LayoutBuilder(builder: (context, constraints) {
                              return AnimatedContainer(
                                clipBehavior: Clip.antiAlias,
                                duration: const Duration(milliseconds: 250),
                                margin: const EdgeInsets.only(
                                  top: 30,
                                  bottom: 30,
                                ),
                                foregroundDecoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFF256062),
                                      Colors.transparent,
                                      Colors.transparent,
                                      Color(0xFF256062)
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    stops: [0, 0, 0.4, 1.5],
                                  ),
                                  borderRadius: BorderRadius.circular(36),
                                ),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(36),
                                    color: Colors.white),
                                child: FittedBox(
                                  // If your background video doesn't look right, try changing the BoxFit property.
                                  // BoxFit.fill created the look I was going for.
                                  fit: BoxFit.cover,
                                  child: SizedBox(
                                      width: _controller.value.size.width,
                                      height: _controller.value.size.height,
                                      child: index == indexPage
                                          ? Stack(
                                              children: [
                                                VideoPlayer(_controller),
                                                Center(
                                                  child: Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            top: 150),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        const Text(
                                                          "Phuket",
                                                          style: TextStyle(
                                                            fontSize: 55,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        Container(
                                                          width: _controller
                                                                  .value
                                                                  .size
                                                                  .height -
                                                              250,
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  vertical: 20),
                                                          child: const Text(
                                                            "Funny shit this came up randomly on Autoplay and once I got near when the original song ends I thought “I fucking love this song it’s such a banger, too bad it’s not longer.”",
                                                            style: TextStyle(
                                                              fontSize: 20,
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          : Stack(
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          image: AssetImage(
                                                              TravelPlace
                                                                  .places[idx]
                                                                  .imgUrl),
                                                          fit: BoxFit.cover)),
                                                )
                                              ],
                                            )),
                                ),
                              );
                            }),
                          ),
                        );
                      }),
                ),
                SizedBox(
                  height: 120,
                  child: SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                          activeTrackColor: Colors.red[700],
                          inactiveTrackColor: Colors.red[100],
                          trackShape: RoundedRectSliderTrackShape(),
                          trackHeight: 2.0,
                          thumbShape:
                              RoundSliderThumbShape(enabledThumbRadius: 12.0),
                          thumbColor: Colors.redAccent,
                          overlayColor: Colors.red.withAlpha(32),
                          overlayShape:
                              RoundSliderOverlayShape(overlayRadius: 28.0),
                          tickMarkShape: RoundSliderTickMarkShape(),
                          activeTickMarkColor: Colors.red[700],
                          inactiveTickMarkColor: Colors.red[100],
                          valueIndicatorShape:
                              PaddleSliderValueIndicatorShape(),
                          valueIndicatorColor: Colors.redAccent,
                          valueIndicatorTextStyle:
                              TextStyle(color: Colors.white)),
                      child: Slider(
                          value: max(0, min(_progress * 100, 100)),
                          min: 0,
                          max: 100,
                          divisions: 100,
                          label: _position?.toString().split(".")[0],
                          onChanged: (value) {
                            setState(() {
                              _progress = value * 0.01;
                            });
                          },
                          onChangeStart: (value) {
                            _controller?.pause();
                          },
                          onChangeEnd: (value) {
                            final duration = _controller?.value?.duration;
                            if (duration != null) {
                              var newValue = max(0, min(value, 99)) * 0.01;
                              var millis =
                                  (duration.inMilliseconds * newValue).toInt();
                              _controller
                                  ?.seekTo(Duration(milliseconds: millis));
                              _controller?.play();
                            }
                          })),
                )
              ],
            ),
          ),
        ));
  }

  bool _isPlaying = false;
  int _isPlayingIndex = -1;

  bool _dispose = false;
  var onUpdateController;
  Duration? _duration;
  Duration? _position;
  var _progress = 0.0;

  void _onControllerUpdate() async {
    if (_dispose) {
      return;
    }
    onUpdateController = 0;
    final now = DateTime.now().millisecondsSinceEpoch;
    if (onUpdateController > now) {
      return;
    }

    onUpdateController = now + 500;
    final controller = _controller;
    if (controller == null) {
      debugPrint('controller is null');
      return;
    }
    if (!controller.value.isInitialized) {
      debugPrint('controller is not initialized');
      return;
    }

    if (_duration == null) {
      _duration = _controller?.value.duration;
    }

    var duration = _duration;

    if (duration == null) return;

    var position = await controller.position;

    _position = position;

    final playing = controller.value.isPlaying;

    if (playing) {
      if (_dispose) return;
      setState(() {
        _progress = position!.inMilliseconds.ceilToDouble() /
            duration.inMilliseconds.ceilToDouble();
      });
    }

    _isPlaying = playing;
  }

  _onTapVideo(index) {
    final controller =
        VideoPlayerController.asset(TravelPlace.places[idx].videoUrl);
    final old = _controller;
    _controller = controller;
    if (old != null) {
      old.removeListener(_onControllerUpdate);
      old.pause();
    }
    setState(() {});
    controller
      ..initialize().then((_) {
        old?.dispose();
        _isPlayingIndex = index;
        controller.addListener(_onControllerUpdate);
        controller.play();
        setState(() {});
      });
  }
}
