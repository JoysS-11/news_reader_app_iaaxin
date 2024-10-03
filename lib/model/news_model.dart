import 'dart:convert';

import 'package:flutter/widgets.dart';

class NewsModel {
  NewsSourceModel? source;
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  String? publishedAt;
  String? content;
  NewsModel({
    this.source,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });

  NewsModel copyWith({
    ValueGetter<NewsSourceModel?>? source,
    ValueGetter<String?>? author,
    ValueGetter<String?>? title,
    ValueGetter<String?>? description,
    ValueGetter<String?>? url,
    ValueGetter<String?>? urlToImage,
    ValueGetter<String?>? publishedAt,
    ValueGetter<String?>? content,
  }) {
    return NewsModel(
      source: source != null ? source() : this.source,
      author: author != null ? author() : this.author,
      title: title != null ? title() : this.title,
      description: description != null ? description() : this.description,
      url: url != null ? url() : this.url,
      urlToImage: urlToImage != null ? urlToImage() : this.urlToImage,
      publishedAt: publishedAt != null ? publishedAt() : this.publishedAt,
      content: content != null ? content() : this.content,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'source': source?.toMap(),
      'author': author,
      'title': title,
      'description': description,
      'url': url,
      'urlToImage': urlToImage,
      'publishedAt': publishedAt,
      'content': content,
    };
  }

  factory NewsModel.fromMap(Map<String, dynamic> map) {
    return NewsModel(
      source:
          map['source'] != null ? NewsSourceModel.fromMap(map['source']) : null,
      author: map['author'],
      title: map['title'],
      description: map['description'],
      url: map['url'],
      urlToImage: map['urlToImage'],
      publishedAt: map['publishedAt'],
      content: map['content'],
    );
  }

  String toJson() => json.encode(toMap());

  factory NewsModel.fromJson(String source) =>
      NewsModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'NewsModel(source: $source, author: $author, title: $title, description: $description, url: $url, urlToImage: $urlToImage, publishedAt: $publishedAt, content: $content)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NewsModel &&
        other.source == source &&
        other.author == author &&
        other.title == title &&
        other.description == description &&
        other.url == url &&
        other.urlToImage == urlToImage &&
        other.publishedAt == publishedAt &&
        other.content == content;
  }

  @override
  int get hashCode {
    return source.hashCode ^
        author.hashCode ^
        title.hashCode ^
        description.hashCode ^
        url.hashCode ^
        urlToImage.hashCode ^
        publishedAt.hashCode ^
        content.hashCode;
  }
}

class NewsSourceModel {
  String? id;
  String? name;
  NewsSourceModel({
    this.id,
    this.name,
  });

  NewsSourceModel copyWith({
    ValueGetter<String?>? id,
    ValueGetter<String?>? name,
  }) {
    return NewsSourceModel(
      id: id != null ? id() : this.id,
      name: name != null ? name() : this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory NewsSourceModel.fromMap(Map<String, dynamic> map) {
    return NewsSourceModel(
      id: map['id'],
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory NewsSourceModel.fromJson(String source) =>
      NewsSourceModel.fromMap(json.decode(source));

  @override
  String toString() => 'NewsSourceModel(id: $id, name: $name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NewsSourceModel && other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
