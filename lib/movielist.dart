import 'dart:async';
import 'dart:convert';
import 'dart:html';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'movie_detail.dart';
import 'config.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'main.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class MovieList extends StatefulWidget {
  @override
  MovieListState createState() {
    return new MovieListState();
  }
}

class MovieListState extends State<MovieList> {
  var movies;
  Color mainColor = Color.fromARGB(255, 139, 140, 182);
  void getData() async {
    var data = await getJson();
    setState(() {
      movies = data['results'];
    });
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return new Scaffold(
      backgroundColor: Color.fromARGB(221, 24, 25, 47),
      appBar: new AppBar(
        elevation: 0.3,
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 40, 40, 50),
        title: new Text(
          'RateMov',
          style: new TextStyle(
              color: mainColor,
              fontFamily: 'Arvo',
              fontWeight: FontWeight.bold),
        ),
      ),
      body: new Padding(
        padding: const EdgeInsets.all(16.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new MovieTitle(mainColor),
            new Expanded(
              child: new ListView.builder(
                  itemCount: movies == null ? 0 : movies.length,
                  itemBuilder: (context, i) {
                    return new TextButton(
                      child: new MovieCell(movies, i),
                      onPressed: () {
                        loading();
                        Navigator.push(context,
                            new MaterialPageRoute(builder: (context) {
                          return new MovieDetail(movies[i]);
                        }));
                      },
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}

Future<Map> getJson() async {
  var apiKey = getApiKey();
  var url =
      'http://api.themoviedb.org/3/discover/movie?api_key=${apiKey}&query=whiplash&language=en&region=id';
  var response = await http.get(Uri.parse(url));
  return json.decode(response.body);
}

class MovieTitle extends StatelessWidget {
  final Color mainColor;
  MovieTitle(this.mainColor);
  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      child: new Text(
        'Movies',
        style: new TextStyle(
            fontSize: 30.0,
            color: mainColor,
            fontWeight: FontWeight.bold,
            fontFamily: 'Arvo'),
        textAlign: TextAlign.left,
      ),
    );
  }
}

class MovieCell extends StatelessWidget {
  final movies;
  final i;
  Color mainColor = Color.fromARGB(255, 204, 197, 229);
  var image_url = 'https://image.tmdb.org/t/p/w500/';
  MovieCell(this.movies, this.i);
  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        new Row(
          children: <Widget>[
            new Padding(
              padding: const EdgeInsets.all(0.0),
              child: new Container(
                margin: const EdgeInsets.all(16.0),
                child: new Container(
                  width: 70.0,
                  height: 70.0,
                ),
                decoration: new BoxDecoration(
                  borderRadius: new BorderRadius.circular(10.0),
                  color: Colors.grey,
                  image: new DecorationImage(
                      image: new NetworkImage(
                          image_url + movies[i]['poster_path']),
                      fit: BoxFit.cover),
                  boxShadow: [
                    new BoxShadow(
                        color: mainColor,
                        blurRadius: 5.0,
                        offset: new Offset(2.0, 5.0))
                  ],
                ),
              ),
            ),
            new Expanded(
                child: new Container(
              margin: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
              child: new Column(
                children: [
                  new Text(
                    movies[i]['title'],
                    style: new TextStyle(
                        fontSize: 20.0,
                        fontFamily: 'Arvo',
                        fontWeight: FontWeight.bold,
                        color: mainColor),
                  ),
                  new Padding(padding: const EdgeInsets.all(2.0)),
                  new Text(
                    movies[i]['overview'],
                    maxLines: 3,
                    style: new TextStyle(
                        color: const Color(0xff8785A4), fontFamily: 'Arvo'),
                  )
                ],
                crossAxisAlignment: CrossAxisAlignment.start,
              ),
            )),
          ],
        ),
        new Container(
          width: 300.0,
          height: 0.5,
          color: const Color(0xD2D2E1ff),
          margin: const EdgeInsets.all(16.0),
        )
      ],
    );
  }
}

Widget loading() {
  return LoadingAnimationWidget.dotsTriangle(
    color: Colors.blue,
    size: 100.0,
  );
}
