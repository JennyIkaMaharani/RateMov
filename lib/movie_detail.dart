import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:moviecatalogue/movielist.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class MovieDetail extends StatelessWidget {
  final movie;
  var image_url = 'https://image.tmdb.org/t/p/w500/';
  MovieDetail(this.movie);
  Color mainColor = const Color(0xff3C3261);
  @override //OVERRIDE
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        elevation: 0.3,
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 40, 40, 50),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back, color: Color.fromARGB(255, 139, 140, 182),),
              onPressed: () {Navigator.pop(context,
                            new MaterialPageRoute(builder: (context) {
                          return new MovieList();
                        }));},
              tooltip: 'Back'
               );
                },
                 ),
        
        title: new Text(
          movie['title'],
          style: new TextStyle(
              color: Color.fromARGB(255, 139, 140, 182),
              fontFamily: 'Arvo',
              fontWeight: FontWeight.bold),
        )),
      body: new Stack(fit: StackFit.expand, children: [
        new Image.network(
          
          image_url + movie['poster_path'],
          fit: BoxFit.cover,
        )
        ,
        new BackdropFilter(
          filter: new ui.ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: new Container(
            color: Colors.black.withOpacity(0.5), //HALAMAN 1
          ),
        ),
        new SingleChildScrollView(
          child: new Container(
            margin: const EdgeInsets.all(20.0),
            child: new Column(
              children: <Widget>[
                new Container(
                  alignment: Alignment.center,
                  child: new Container(
                    width: 400.0,
                    height: 400.0,
                  ),
                  decoration: new BoxDecoration(
                      borderRadius: new BorderRadius.circular(10.0),
                      image: new DecorationImage(
                          image: new NetworkImage(
                              image_url + movie['poster_path']),
                          fit: BoxFit.cover),
                      boxShadow: [
                        new BoxShadow(
                            color: Colors.black,
                            blurRadius: 20.0,
                            offset: new Offset(0.0, 10.0))
                      ]),
                ), //GARISKEDUA
                new Container(
                  margin: const EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 0.0),
                  child: new Row(
                    children: <Widget>[
                      new Expanded(
                          child: new Text(
                        movie['title'],
                        style: new TextStyle(
                            color: Colors.white,
                            fontSize: 30.0,
                            fontFamily: 'Arvo'),
                      )),
                      new Text(
                        '${movie['vote_average']}/10',
                        style: new TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontFamily: 'Arvo'),
                      )
                    ],
                  ),
                ), //GARISKETIGA
                new Text(movie['overview'],
                    style:
                        new TextStyle(color: Colors.white, fontFamily: 'Arvo')),
                new Padding(padding: const EdgeInsets.all(10.0)),
                new Row(
                  children: <Widget>[
                    RatingBar.builder(
                      initialRating: 3,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        print(rating);
                      },   
                    ),
                    ElevatedButton.icon(
                      label: Text(
                        'Rate',
                      ),
                      icon: Icon(Icons.send),
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 34, 43, 62),
                      ),
                      onPressed: () {
                        print('under development');
                      },
                    )
                  ]
                )
              ],
            ),
          ),
        ),
      ]),
    );
  }
}