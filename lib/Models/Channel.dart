class Channel {
	String nextPageToken;
	PageInfo pageInfo;
	List<Items> items;

	Channel({this.nextPageToken, this.pageInfo, this.items});

	Channel.fromJson(Map<String, dynamic> json) {
		nextPageToken = json['nextPageToken'];
		pageInfo = json['pageInfo'] != null ? new PageInfo.fromJson(json['pageInfo']) : null;
		if (json['items'] != null) {
			items = new List<Items>();
			json['items'].forEach((v) { items.add(new Items.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['nextPageToken'] = this.nextPageToken;
		if (this.pageInfo != null) {
      data['pageInfo'] = this.pageInfo.toJson();
    }
		if (this.items != null) {
      data['items'] = this.items.map((v) => v.toJson()).toList();
    }
		return data;
	}
}

class PageInfo {
	int totalResults;
	int resultsPerPage;

	PageInfo({this.totalResults, this.resultsPerPage});

	PageInfo.fromJson(Map<String, dynamic> json) {
		totalResults = json['totalResults'];
		resultsPerPage = json['resultsPerPage'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['totalResults'] = this.totalResults;
		data['resultsPerPage'] = this.resultsPerPage;
		return data;
	}
}

class Items {
	Snippet snippet;
	Id id;

	Items({this.snippet, this.id});

	Items.fromJson(Map<String, dynamic> json) {
		snippet = json['snippet'] != null ? new Snippet.fromJson(json['snippet']) : null;
		id = json['id'] != null ? new Id.fromJson(json['id']) : null;
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.snippet != null) {
      data['snippet'] = this.snippet.toJson();
    }
		if (this.id != null) {
      data['id'] = this.id.toJson();
    }
		return data;
	}
}

class Snippet {
	String publishedAt;
	String channelId;
	String title;
	Thumbnails thumbnails;
	String channelTitle;

	Snippet({this.publishedAt, this.channelId, this.title, this.thumbnails, this.channelTitle});

	Snippet.fromJson(Map<String, dynamic> json) {
		publishedAt = json['publishedAt'];
		channelId = json['channelId'];
		title = json['title'];
		thumbnails = json['thumbnails'] != null ? new Thumbnails.fromJson(json['thumbnails']) : null;
		channelTitle = json['channelTitle'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['publishedAt'] = this.publishedAt;
		data['channelId'] = this.channelId;
		data['title'] = this.title;
		if (this.thumbnails != null) {
      data['thumbnails'] = this.thumbnails.toJson();
    }
		data['channelTitle'] = this.channelTitle;
		return data;
	}
}

class Thumbnails {
	Default thumbnailsDefault;

	Thumbnails({this.thumbnailsDefault});

	Thumbnails.fromJson(Map<String, dynamic> json) {
		thumbnailsDefault = json['default'] != null ? new Default.fromJson(json['default']) : null;
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.thumbnailsDefault != null) {
      data['default'] = this.thumbnailsDefault.toJson();
    }
		return data;
	}
}

class Default {
	String url;

	Default({this.url});

	Default.fromJson(Map<String, dynamic> json) {
		url = json['url'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['url'] = this.url;
		return data;
	}
}

class Id {
	String videoId;

	Id({this.videoId});

	Id.fromJson(Map<String, dynamic> json) {
		videoId = json['videoId'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['videoId'] = this.videoId;
		return data;
	}
}
