import 'package:flutter/cupertino.dart';

class Movie {
  final String imdbID;
  final String title;
  final String year;
  final String poster;
  final String genre;

  const Movie({
    required this.imdbID,
    required this.title,
    required this.year,
    required this.poster,
    required this.genre,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      imdbID: json['imdbID'],
      title: json['Title'],
      year: json['Year'],
      poster: json['Poster'],
      genre: json['Type']
    );
  }

  static List<Movie> moviesFromJson(dynamic json){
    var searchResult = json["Search"];
    List <Movie> results = new List.empty(growable: true);
    if(searchResult != null){
      searchResult.forEach((v)=>{
        results.add(Movie.fromJson(v))
      });
      return results;
    }
    return results;
  }
}