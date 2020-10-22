import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _appBar = AppBar(
      elevation: 0,
      title: Text(
        "About App",
        style: TextStyle(
          fontFamily: "Roboto",
        ),
      ),
    );
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: _appBar,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Card(
              elevation: 8,
              child: Container(
                width: 80,
                height: 80,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: AspectRatio(
                  aspectRatio: 1 / 1,
                  child: Image.asset(
                    "images/logo-text.png",
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            Text(
              "Latte POS",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: "Roboto",
                color: Colors.white,
              ),
            ),
            Divider(
              height: 46,
              color: Colors.white60,
            ),
            Row(
              children: [
                Text(
                  "Developers",
                  style: TextStyle(
                    fontFamily: "Roboto",
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                SizedBox(width: 16),
                Icon(
                  Icons.circle,
                  size: 8,
                  color: Colors.white,
                ),
                SizedBox(width: 16),
                Text(
                  "Phyo Htet Arkar",
                  style: TextStyle(
                    fontFamily: "Roboto",
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                SizedBox(width: 16),
                Icon(
                  Icons.circle,
                  size: 8,
                  color: Colors.white,
                ),
                SizedBox(width: 16),
                Text(
                  "Theinmwe Naing",
                  style: TextStyle(
                    fontFamily: "Roboto",
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                SizedBox(width: 16),
                Icon(
                  Icons.circle,
                  size: 8,
                  color: Colors.white,
                ),
                SizedBox(width: 16),
                Text(
                  "Khin Zarli",
                  style: TextStyle(
                    fontFamily: "Roboto",
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                SizedBox(width: 16),
                Icon(
                  Icons.circle,
                  size: 8,
                  color: Colors.white,
                ),
                SizedBox(width: 16),
                Text(
                  "Minn Khant Kyaw",
                  style: TextStyle(
                    fontFamily: "Roboto",
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Spacer(),
            SafeArea(
              child: Text(
                "Made with \u2661 using Flutter",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "Roboto",
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
