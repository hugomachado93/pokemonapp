import 'package:flutter/material.dart';
import 'package:proj1/homePage.dart';
import 'package:proj1/dataSearch.dart';
import 'package:proj1/favouritePokemon.dart';
import 'package:proj1/preferences.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Pokeapp'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int _currentIndex = 0;
  HomePage homePage;
  FavouritePokemons favouritePokemons;
  Widget _currentPage;

  List<Widget> pages;

  @override
  void initState(){
    homePage = HomePage();
    favouritePokemons = FavouritePokemons();

    pages = [homePage, favouritePokemons];
    _currentPage = homePage;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              showSearch(context: context, delegate: DataSearch());
            },
          )
        ],
      ),
      body: _currentPage,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index){
          setState(() {
            _currentIndex = index;
            _currentPage = pages[index];
          });
        },
        items: [
          BottomNavigationBarItem(
            title: Text("Home"),
            icon: Icon(Icons.home)
          ),
          BottomNavigationBarItem(
            title: Text("Favoritos"),
            icon: Icon(Icons.favorite)
          ),
        ]
      ),
    );
  }
}
