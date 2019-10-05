import 'package:http/http.dart' as http;
import 'dart:convert';

import 'Models/Channel.dart';
import 'Models/VideoInfo.dart';

class Helper {
  String apiToken =
      "AIzaSyA1n4M-fo2Y5NHUj0RsvXEAis3H6_lIjRg"; 
      //I recommend creating a new key because I can delete my key soon
      //get your api key from here : https://console.cloud.google.com/apis/library

  Future<dynamic> search(String query) async {
    String url =
        "https://www.googleapis.com/youtube/v3/search?part=snippet&maxResults=50&q=" +
            query +
            "&fields=items(id/videoId,snippet(publishedAt,channelId,channelTitle,thumbnails/default/url,title)),nextPageToken,pageInfo,prevPageToken&key=" +
            apiToken;
    try {
      http.Response response = await http.get(url);
      return Channel.fromJson(
        jsonDecode(response.body),
      );
    } catch (ex) {
      return "error";
    }
  }

//----------------------↓↓↓ Get VIdeo Info
  Future<dynamic> getInfo(String videoID) async {
    String url =
        "https://www.googleapis.com/youtube/v3/videos?part=contentDetails,statistics&id=" +
            videoID +
            "&fields=items(contentDetails/duration,statistics)&key=" +
            apiToken;
    http.Response response = await http.get(url);
    return VideoInfo.fromJson(jsonDecode(response.body));
  }

  //-----------------------------↓↓↓↓ Get Suggestions
//   static Future<List<String>> getSuggestions(String query) async {
//     String url =
//         "http://suggestqueries.google.com/complete/search?client=firefox&ds=yt&q=${query}";
//     http.Response response = await http.get(url);
//     var json = jsonDecode(response.body);
//     return json[1];
//   }
// }

// class DataSearch extends SearchDelegate<String> {
//   final List<String> currentSearches = [];
//   final List<String> recenctSearches = ['eminem', 'x-slayer'];

//   @override
//   List<Widget> buildActions(BuildContext context) {
//     return [
//       IconButton(
//         icon: Icon(Icons.clear),
//         onPressed: () {
//           query = '';
//         },
//       )
//     ];
//   }

//   @override
//   Widget buildLeading(BuildContext context) {
//     return IconButton(
//       onPressed: () {
//         close(context, null);
//       },
//       icon: AnimatedIcon(
//         progress: transitionAnimation,
//         icon: AnimatedIcons.menu_arrow,
//       ),
//     );
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     // TODO: implement buildResults
//     return null;
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     List<String> suggestionList = query.isEmpty ? recenctSearches : currentSearches;
//     return ListView.builder(
//       itemCount: suggestionList.length,
//       itemBuilder: (context, index) => ListTile(
//         leading: Icon(Icons.short_text),
//         title: Text(suggestionList[index]),
//       ),
//     );
//   }
}