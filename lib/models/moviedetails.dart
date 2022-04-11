import 'package:flutter/cupertino.dart';

class MovieDetails {
  final String imdbID;
  final String title;
  final String year;
  final String poster;
  final String genre;
  final String actors;

  const MovieDetails({
    required this.imdbID,
    required this.title,
    required this.year,
    required this.poster,
    required this.genre,
    required this.actors,
  });

  factory MovieDetails.fromJson(Map<String, dynamic> json) {
    return MovieDetails(
        imdbID: json['imdbID'],
        title: json['Title'],
        year: json['Year'],
        poster: json['Poster'],
        genre: json['Type'],
        actors: json['Actors']
    );
  }
}