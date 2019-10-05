import 'package:flutter/material.dart';
import 'package:yourtube/Helper.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:yourtube/VideoDisplay.dart';

import 'Models/Channel.dart';
import 'Models/VideoInfo.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Helper helper = Helper();
  bool isSearching = false;
  List<VideoInfo> videos = [];
  Channel video = new Channel();
  TextEditingController inputSearch = new TextEditingController();
  int vidCount = 0;

  Future search(String query) async {
    setState(
      () {
        isSearching = true;
        vidCount = 0;
      },
    );
    videos.clear();
    try {
      video = await helper.search(query);
    } catch (ex) {
      setState(() {
        isSearching = false;
      });
      return;
    }
    //-------------------Get The Videos Only
    video.items = video.items.where((item) {
      return item.id != null;
    }).toList();
    setState(() {
      isSearching = false;
    });
    //-------------------Get The Videos Only
    for (var item in video.items) {
      if (item.id != null) {
        VideoInfo vd = await helper.getInfo(item.id.videoId);
        setState(
          () {
            videos.add(vd);
            vidCount += 1;
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Container(
              width: screenWidth,
              height: screenHeight,
              color: Color.fromRGBO(20, 35, 60, 1),
            ),
            Padding(
              padding: EdgeInsets.only(left: 30.0, right: 30.0, top: 25.0),
              child: Container(
                padding: EdgeInsets.only(left: 8.0, right: 15.0),
                height: 45.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Color.fromRGBO(37, 53, 79, 1),
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      IconButton(
                        color: Color.fromRGBO(237, 237, 237, 1),
                        onPressed: () {
                          // showSearch(context: context, delegate: DataSearch());
                          inputSearch.text == ''
                              ? Fluttertoast.showToast(
                                  msg: "Enter a keyword to search",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIos: 2,
                                  backgroundColor: Colors.black,
                                  textColor: Colors.white,
                                  fontSize: 16.0)
                              : search(inputSearch.text);
                        },
                        icon: Icon(Icons.search),
                      ),
                      Expanded(
                        child: TextField(
                          textInputAction: TextInputAction.search,
                          onSubmitted: (keyword) {
                            keyword == ''
                                ? Fluttertoast.showToast(
                                    msg: "Enter a keyword to search",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIos: 2,
                                    backgroundColor: Colors.black,
                                    textColor: Colors.white,
                                    fontSize: 16.0)
                                : search(keyword);
                          },
                          controller: inputSearch,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Search On YouTube',
                            hintStyle: TextStyle(
                                color: Color.fromRGBO(237, 237, 237, 1),
                                fontSize: 16.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            isSearching == true
                ? Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Color.fromRGBO(37, 53, 79, 1),
                    ),
                  )
                : videos.length == 0
                    ? Center(
                        child: Text(
                          "YouTube Search",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                          ),
                        ),
                      )
                    : Positioned(
                        child: Container(
                          height: screenHeight,
                          width: screenWidth,
                          color: Color.fromRGBO(37, 53, 79, 1),
                          child: ListView.builder(
                            itemCount:
                                videos.length == 0 ? 0 : videos.length - 1,
                            itemBuilder: (context, index) {
                              return infoColumn(video, index);
                            },
                          ),
                        ),
                        top: screenHeight * 0.14,
                      )
          ],
        ),
      ),
    );
  }

  Column infoColumn(Channel vd, int index) {
    return Column(
      children: <Widget>[
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => VideoDisplay(
                  thumbnail:
                      vd.items[index].snippet.thumbnails.thumbnailsDefault.url,
                  video: videos[index],
                  index: index,
                  vd: vd,
                ),
              ),
            );
          },
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, top: 8.0),
                  child: Container(
                    height: 90.0,
                    width: 100.0,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(vd.items[index].snippet
                                .thumbnails.thumbnailsDefault.url)),
                        borderRadius: BorderRadius.circular(5.0)),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          vd.items[index].snippet.title,
                          style: TextStyle(fontSize: 15.0, color: Colors.white),
                        ),
                        Text(
                          vd.items[index].snippet.channelTitle,
                          style:
                              TextStyle(fontSize: 12.0, color: Colors.white70),
                        ),
                        Divider(
                          color: Colors.white12,
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            rowInfo(videos[index].items[0].statistics.viewCount,
                                Icons.remove_red_eye),
                            rowInfo(videos[index].items[0].statistics.likeCount,
                                Icons.thumb_up),
                            rowInfo(
                                videos[index].items[0].statistics.dislikeCount,
                                Icons.thumb_down),
                            rowInfo(
                                videos[index].items[0].statistics.commentCount,
                                Icons.comment),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 50.0),
          child: Divider(
            color: Color.fromRGBO(20, 35, 60, 1),
          ),
        ),
      ],
    );
  }

  Widget rowInfo(String displayText, IconData ico) {
    return Flexible(
      child: Row(
        children: <Widget>[
          Expanded(child: Icon(ico, color: Colors.blueAccent[100])),
          Expanded(
            child: Text(
              FlutterMoneyFormatter(amount: double.parse(displayText))
                  .output
                  .compactNonSymbol,
              style: TextStyle(color: Colors.white, fontSize: 10.0),
            ),
          ),
        ],
      ),
    );
  }
}
