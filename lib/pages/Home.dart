import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:numerical_methods/pages/NewtonRaphsonMethod.dart';
import 'package:url_launcher/url_launcher.dart';

import "./BisectionMethod.dart";
import "./FalsePositionMethod.dart";
import "./SecantMethod.dart";

class Root extends StatelessWidget {
  Widget buildGridView(BuildContext context) {
    return GridView(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 15,
        mainAxisSpacing: 10,
      ),
      children: [
        InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(BisectionMethod.routeName);
          },
          child: Card(
            child: Center(
              child: Text(
                "Bisection Method",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(FalsePositionMethod.routeName);
          },
          child: Card(
            child: Center(
                child: Text(
              "False Position Method",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline1,
            )),
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(SecantMethod.routeName);
          },
          child: Card(
            child: Center(
                child: Text(
              "Secant Method",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline1,
            )),
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(NewtonRaphsonMethod.routeName);
          },
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Card(
              child: Center(
                  child: Text(
                "Newton Raphson Method",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline1,
              )),
            ),
          ),
        ),
      ],
    );
  }

  Widget build(BuildContext context) {
    void _bottomModalSheetHandler(BuildContext context) {
      showModalBottomSheet(
          context: context,
          builder: (ctx) {
            return Container(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Developed By:",
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 70,
                          backgroundImage: NetworkImage(
                              "https://avatars.githubusercontent.com/u/54496134?v=4"),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "Ernest Neo",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.black,
                        child: IconButton(
                          color: Colors.white,
                          icon: FaIcon(FontAwesomeIcons.github),
                          onPressed: () async {
                            final url = "https://github.com/PrameshKarki";
                            if (await canLaunch(url)) {
                              await launch(url, forceSafariVC: false);
                            }
                          },
                        ),
                      ),
                      SizedBox(width: 10),
                      CircleAvatar(
                        backgroundColor: Colors.blue,
                        child: IconButton(
                          color: Colors.white,
                          icon: FaIcon(FontAwesomeIcons.globeAsia),
                          onPressed: () async {
                            final url = "https://T41496.com.np/";
                            if (await canLaunch(url)) {
                              await launch(
                                url,
                                forceSafariVC: false,
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  )
                ],
              ),
            );
          });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Numerical Methods"),
        actions: [
          IconButton(
            icon: Icon(
              Icons.contact_support_outlined,
              size: 30,
            ),
            onPressed: () {
              _bottomModalSheetHandler(context);
            },
          )
        ],
      ),
      body: buildGridView(context),
    );
  }
}
