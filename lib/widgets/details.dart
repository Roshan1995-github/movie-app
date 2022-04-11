import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:movies_app/models/movie.dart';
import 'package:movies_app/models/moviedetails.dart';
import 'package:http/http.dart' as http;

class DetailsPage extends StatefulWidget {

  final imdbID;
  DetailsPage({required this.imdbID});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {

  MovieDetails? a;

  @override
  void initState() {
    // TODO: implement initState
    fetchMovieDetails(widget.imdbID).then((value) => {
      setState(() {
        a = value;
      })
    });
    super.initState();
  }

  Future <MovieDetails> fetchMovieDetails(imdbID) async {
    final response = await http
        .get(Uri.parse('https://www.omdbapi.com/?i='+imdbID+'&apikey=87d10179'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return MovieDetails.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Movie Details"),),
      body: Center(
        child: Column(
          children: [
            Image.network(a!.poster),
            Text(a!.title),
            Text(widget.imdbID),
            Text(a!.actors),
            Text(a!.year),


          ],
        ),
      ),
    );
  }
}
