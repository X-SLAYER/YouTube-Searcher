import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:yourtube/Models/VideoInfo.dart';
import 'package:intl/intl.dart';

import 'Models/Channel.dart';

class VideoDisplay extends StatefulWidget {
  final VideoInfo video;
  final String thumbnail;
  final int index;
  final Channel vd;

  const VideoDisplay({this.thumbnail, this.video, this.index, this.vd});

  @override
  _VideoDisplayState createState() => _VideoDisplayState();
}

class _VideoDisplayState extends State<VideoDisplay> {
  @override
  Widget build(BuildContext context) {
    var publishDate =
        DateTime.parse(widget.vd.items[widget.index].snippet.publishedAt);
    var bgColor = Color.fromRGBO(20, 35, 60, 1);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        backgroundColor: bgColor,
        child: Icon(
          Icons.home,
          color: Colors.white70,
        ),
      ),
      body: SafeArea(
        child: Container(
          color: bgColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    height: 250,
                    width: double.infinity,
                    // decoration: BoxDecoration(
                    //   image: DecorationImage(
                    //       fit: BoxFit.cover,
                    //       image: NetworkImage(widget.thumbnail)),
                    //   borderRadius: BorderRadius.circular(5.0),
                    // ),
                    child: WebviewScaffold(
                      url:
                          "https://youtube.com/embed/${widget.vd.items[widget.index].id.videoId}",
                    ),
                  ),
                  Positioned(
                    top: 0.0,
                    left: 0.0,
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: IconButton(
                          iconSize: 24.0,
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          }),
                    ),
                  )
                ],
              ),
              Flexible(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0, left: 10.0),
                  child: Text(
                    widget.vd.items[widget.index].snippet.title,
                    style: TextStyle(color: Colors.white, fontSize: 18.0),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 14.0, left: 15),
                child: Row(
                  children: <Widget>[
                    Text(
                      FlutterMoneyFormatter(
                            amount: double.parse(
                                widget.video.items[0].statistics.viewCount),
                          ).output.withoutFractionDigits +
                          " Views",
                      style: TextStyle(color: Colors.white70, fontSize: 14.0),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: Icon(Icons.directions,
                          color: Colors.white70, size: 14.0),
                    ),
                    Text(
                      DateFormat('yyyy-MM-dd kk:mm').format(publishDate),
                      style: TextStyle(color: Colors.white70, fontSize: 14.0),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  buildInfo(widget.video.items[0].statistics.likeCount,
                      Icons.thumb_up, true),
                  buildInfo(widget.video.items[0].statistics.dislikeCount,
                      Icons.thumb_down, true),
                  buildInfo(widget.video.items[0].statistics.commentCount,
                      Icons.comment, true),
                  buildInfo("Download", Icons.arrow_downward, false),
                  buildInfo("Share", Icons.share, false),
                ],
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 22.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        widget.vd.items[widget.index].snippet.channelTitle,
                        style: TextStyle(fontSize: 18.0, color: Colors.white),
                      ),
                      Row(
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              print(widget.vd.items[widget.index].id.videoId);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 8.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25.0),
                                  border: Border.all(color: Colors.white24)),
                              child: Text(
                                "Subscribe",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14.0),
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.notifications_active,
                              color: Colors.white70,
                            ),
                          )
                        ],
                      )
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildInfo(String displayText, IconData ico, bool isDouble) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, top: 23.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          InkWell(
            onTap: () {},
            child: Container(
              margin: const EdgeInsets.all(5.0),
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white24)),
              child: Icon(
                ico,
                color: Colors.white,
                size: 22.0,
              ),
            ),
          ),
          SizedBox(
            height: 8.0,
          ),
          Text(
            isDouble
                ? FlutterMoneyFormatter(
                    amount: double.parse(displayText),
                  ).output.compactNonSymbol
                : displayText,
            style: TextStyle(color: Colors.white, fontSize: 13.0),
          ),
        ],
      ),
    );
  }
}
