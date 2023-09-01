import 'package:flutter/material.dart';
import 'package:smart_resto/animation/ScaleRoute.dart';
import 'package:smart_resto/constants.dart';
import 'package:smart_resto/pages/SignInPage.dart';
import 'package:smart_resto/pages/identifierPage.dart';
import 'package:smart_resto/size_config.dart';

class IntroScreen extends StatefulWidget {
  final List<OnbordingData> onbordingDataList;
  final MaterialPageRoute pageRoute;
  IntroScreen(this.onbordingDataList, this.pageRoute);

  void skipPage(BuildContext context) {
    Navigator.push(context, ScaleRoute(page: LoginScreen()));
    
  }

  @override
  IntroScreenState createState() {
    return new IntroScreenState();
  }
}

class IntroScreenState extends State<IntroScreen> {
  final PageController controller = new PageController();
  int currentPage = 0;
  bool lastPage = false;

  void _onPageChanged(int page) {
    setState(() {
      currentPage = page;
      if (currentPage == widget.onbordingDataList.length - 1) {
        lastPage = true;
      } else {
        lastPage = false;
      }
    });
  }

  Widget _buildPageIndicator(int page) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2.0),
      height: page == currentPage ? 10.0 : 6.0,
      width: page == currentPage ? 10.0 : 6.0,
      decoration: BoxDecoration(
        color: page == currentPage ? Colors.blue : Colors.grey,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
  
      padding: const EdgeInsets.all(10.0),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          new Expanded(
            flex: 1,
            child: new Container(),
          ),
          new Expanded(
            flex: 3,
            child: new PageView(
              children: widget.onbordingDataList,
              controller: controller,
              onPageChanged: _onPageChanged,
            ),
          ),
          new Expanded(
            flex: 1,
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                new TextButton(
                  child: new Text(lastPage ? "" : "SKIP",
                      style: new TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0)),
                  onPressed: () => lastPage
                      ? null
                      : widget.skipPage(
                          context,
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Container(
                    child: Row(
                      children: [
                        _buildPageIndicator(0),
                        _buildPageIndicator(1),
                        _buildPageIndicator(2),
                        _buildPageIndicator(3),
                      ],
                    ),
                  ),
                ),
                TextButton(
                  child: new Text(lastPage ? "COMMENCER" : "SUIVANT",
                      style: new TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0)),
                  onPressed: () => lastPage
                      ? widget.skipPage(context)
                      : controller.nextPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeIn),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OnbordingData extends StatefulWidget {
  final imagePath;
  final title;
  final desc;

  OnbordingData({this.imagePath, this.title, this.desc});

  @override
  _OnbordingDataState createState() =>
      _OnbordingDataState(this.imagePath, this.title, this.desc);
}

class _OnbordingDataState extends State<OnbordingData> {
  final imagePath;
  final title;
  final desc;
 


  _OnbordingDataState(this.imagePath, this.title, this.desc);



  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image(
            fit: BoxFit.fitWidth,
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.40,
            image: AssetImage(imagePath),
          ),
          SizedBox(
            height: 12.0,
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                title,
                softWrap: true,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: kPrimaryColor),
              ),
            ),
          ),
          SizedBox(
            height: 12.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              desc,
              softWrap: true,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingScreen extends StatelessWidget {
  final List<OnbordingData> list = [
    OnbordingData(
      imagePath: "assets/images/pic1.png",
      title: "Commander",
      desc:
          "Avec votre smartphone commander votre repas dans le restaurant de votre choix.",
    ),
    OnbordingData(
      imagePath: "assets/images/pic2.png",
      title: "Restaurant",
      desc:
          "Découvrer le menu de vos restaurants préférés.",
    ),
    OnbordingData(
      imagePath: "assets/images/pic3.png",
      title: "Livraison",
      desc:
          "Faites vous Livrer depuis votre lieu de service sans vous déplacer.",
    ),
    OnbordingData(
      imagePath: "assets/images/pic4.png",
      title: "Dégustation",
      desc:
          "Déguster votre repas en toute sécurité et sans aucun stress.",
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: IntroScreen(
      list,
      MaterialPageRoute(builder: (context) => OnboardingScreen()),
    ));
  }
}
