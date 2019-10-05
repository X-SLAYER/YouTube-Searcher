class VideoInfo {
  List<Items> items;

  VideoInfo({this.items});

  VideoInfo.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = new List<Items>();
      json['items'].forEach((v) {
        items.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.items != null) {
      data['items'] = this.items.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  ContentDetails contentDetails;
  Statistics statistics;

  Items({this.contentDetails, this.statistics});

  Items.fromJson(Map<String, dynamic> json) {
    contentDetails = json['contentDetails'] != null
        ? new ContentDetails.fromJson(json['contentDetails'])
        : null;
    statistics = json['statistics'] != null
        ? new Statistics.fromJson(json['statistics'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.contentDetails != null) {
      data['contentDetails'] = this.contentDetails.toJson();
    }
    if (this.statistics != null) {
      data['statistics'] = this.statistics.toJson();
    }
    return data;
  }
}

class ContentDetails {
  String duration;

  ContentDetails({this.duration});

  ContentDetails.fromJson(Map<String, dynamic> json) {
    duration = json['duration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['duration'] = this.duration;
    return data;
  }
}

class Statistics {
  String viewCount;
  String likeCount;
  String dislikeCount;
  String favoriteCount;
  String commentCount;

  Statistics(
      {this.viewCount,
      this.likeCount,
      this.dislikeCount,
      this.favoriteCount,
      this.commentCount});

  Statistics.fromJson(Map<String, dynamic> json) {
    viewCount = json['viewCount'];
    likeCount = json['likeCount'];
    dislikeCount = json['dislikeCount'];
    favoriteCount = json['favoriteCount'];
    commentCount = json['commentCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['viewCount'] = this.viewCount;
    data['likeCount'] = this.likeCount;
    data['dislikeCount'] = this.dislikeCount;
    data['favoriteCount'] = this.favoriteCount;
    data['commentCount'] = this.commentCount;
    return data;
  }
}
