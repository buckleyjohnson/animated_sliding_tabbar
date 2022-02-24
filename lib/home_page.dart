import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:ui' as ui;
import 'dart:html';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late Size size;
  late double? firstLeft = 0.0, secondLeft = 0.0;
  final double? top = 0;

  late TabController tabController;
  final IFrameElement _iframeElement = IFrameElement();
  late Widget _iframeWidget;
  var _isWideScreen = true;
  var _activeIndex = 0;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      initialIndex: 0,
      length: 2,
      vsync: this,
    );
    tabController.addListener(() {
      if (tabController.indexIsChanging) {
        setState(() {
          _activeIndex = tabController.index;
        });
      }
    });
    _iframeElement.src =
    'https://lookie.biz/lookie_virtual_tours/firstTourForTemplate.php?id_locations=52';
    _iframeElement.style.border = 'none';

    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      'iframeElement',
          (int viewId) => _iframeElement,
    );

    _iframeWidget = HtmlElementView(
      key: UniqueKey(),
      viewType: 'iframeElement',
    );
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    var _width = size.width;
    if (_activeIndex == 0) {
      firstLeft = 0;
      secondLeft = _width;
    } else {
      firstLeft = -size.width;
      secondLeft = 0;
    }
    double _iFrameWidth = max(_width * .65, 800);
    double _iFrameHeight = _iFrameWidth * .6;
    if (_iFrameWidth + 301 < _width) {
      _isWideScreen = true;
    } else {
      _isWideScreen = false;
    }
    print("firstLeft = $firstLeft");
    print("secondLeft = $secondLeft");

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Material(
              color: Colors.grey[100],
              child: SizedBox(
                height: 75,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _isWideScreen
                        ? Text(
                      'Lookie',
                      style: TextStyle(fontSize: 36),
                    )
                        : Container(),
                    Text(
                      'Acer Realty',
                      style: TextStyle(fontSize: 36),
                    ),
                    Text(
                      '888-3413',
                      style: TextStyle(fontSize: 36),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: SizedBox(
                height: 80,
                width: _iFrameWidth,
                // _isWideScreen ? _iFrameWidth - 350 : 350,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '56 Galaldon dr, Belen',
                      style: TextStyle(fontSize: 36, height: 1.2),
                    ),
                    Text(
                      '4br, 3br, Great house with a lot of style.',
                      style: TextStyle(fontSize: 18, height: 1.2),
                    ),
                  ],
                ),
              ),
            ),
            _buildTabRow(),
            Material(
              color: Colors.red,
              child: SizedBox(
                height: _iFrameWidth * .6,
                child: Stack(
                  children: [
                    AnimtedSteps(
                      child: Center(
                        child: SizedBox(
                            width: _iFrameWidth,
                            height: _iFrameWidth * .6,
                            child: _iframeWidget),
                      ),
                      top: top,
                      height: _iFrameHeight,
                      left: firstLeft ?? 0,
                      backgroundColor: Colors.blueGrey,
                    ),
                    AnimtedSteps(
                      child: Center(
                        child: _buildImageContainer(_iFrameWidth),
                      ),
                      top: top,
                      height: _iFrameHeight,
                      left: secondLeft ?? size.width,
                      backgroundColor: Colors.blueAccent,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: _iFrameWidth,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
                  child: Text(
                    'This is just a lot of dummy text. Performing hot restart Waiting for connection from debug service on Chrome..'
                        ' Restarted application in 207ms. width = 1468 '
                        'Height of Platform View type: [iframeElement] may not be set. '
                        ' Restarted application in 207ms. width = 1468 '
                        'Height of Platform View type: [iframeElement] may not be set. '
                        ' Restarted application in 207ms. width = 1468 '
                        'Height of Platform View type: [iframeElement] may not be set. '
                        ' Restarted application in 207ms. width = 1468 '
                        'Height of Platform View type: [iframeElement] may not be set. '
                        ' Restarted application in 207ms. width = 1468 '
                        'Height of Platform View type: [iframeElement] may not be set. '
                        ' Restarted application in 207ms. width = 1468 '
                        'Height of Platform View type: [iframeElement] may not be set. '
                        ' Restarted application in 207ms. width = 1468 '
                        'Height of Platform View type: [iframeElement] may not be set. '
                        'Defaulting to',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Container _buildImageContainer(width) {
    return Container(
      color: Colors.orange,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(width: width, height: width * .6,child: Image.asset("assets/fron.png", fit: BoxFit.contain,),),
            Image.asset("assets/Calendar.png"),
            SizedBox(width: width, height: width * .6,child: Image.asset("assets/fron.png", fit: BoxFit.contain,),),
            Image.asset("assets/Calendar.png"),
          ],
        ),
      ),
    );
  }

  Padding _buildTabRow() {
    return Padding(
      padding: const EdgeInsets.only(top: 18.0),
      child: Row(
        children: [
          Spacer(),
          Container(
            width: 400,
            child: Material(
              color: Colors.grey[400],
              child: TabBar(
                indicator: BoxDecoration(color: Colors.black),
                labelColor: Colors.white,
                labelStyle: TextStyle(fontSize: 14),
                indicatorColor: Color.fromRGBO(4, 2, 46, 1),
                unselectedLabelColor: Colors.grey,
                controller: tabController,
                tabs: [
                  Text('Virtual Tour'),
                  Text('Photos'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AnimtedSteps extends StatelessWidget {
  double? top;
  double? left;
  Color? backgroundColor;
  Widget? child;
  double height = 300;

  AnimtedSteps(
      {Key? key,
        this.top,
        this.left,
        this.backgroundColor,
        this.child,
        required this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 500),
      left: left,
      top: top,
      child: Container(
        width: width,
        height: height,
        color: backgroundColor,
        child: child,
      ),
    );
  }
}
