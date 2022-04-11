import 'dart:convert';
import 'package:flutter/material.dart';
import 'details.dart';
import 'package:http/http.dart' as http;
import 'package:movies_app/models/movie.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}



class _HomePageState extends State<HomePage> {

  List<Movie> movies =[];

  var movieNameTF =TextEditingController();

  Future<List<Movie>> fetchMovies(movieName) async {
    final response = await http
        .get(Uri.parse('https://www.omdbapi.com/?s='+movieName+'&apikey=87d10179'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return Movie.moviesFromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Movie App"),),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: movieNameTF,
                      decoration: InputDecoration(hintText: "Enter movie name"),
                    ),
                  ),
                  TextButton(onPressed: (){
                    print(movieNameTF.text);
                    print('https://www.omdbapi.com/?s='+movieNameTF.text+'&apikey=87d10179');
                    print(fetchMovies(movieNameTF.text));


                    fetchMovies(movieNameTF.text).then((value) => {
                      setState(() {
                        movies = value;
                      })
                    });
                  }, child: Text("Search"))
                ],
              ),
              SizedBox(height: 10,),
              Expanded(
                child: ListView.builder(
                  itemCount: movies.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Image.network(movies[index].poster),
                      title: Text(movies[index].title),
                      subtitle: Text(movies[index].year),
                      trailing: Icon(Icons.more_vert),
                      onTap: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context)=>DetailsPage(imdbID: movies[index].imdbID))
                        );
                      },
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
