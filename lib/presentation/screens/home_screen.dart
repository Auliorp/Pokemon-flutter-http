import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http_app/infrastructure/models/Pokemon.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //Usamos el modelo mapeado "Pokemon"
  Pokemon? pokemon;
  int pokemonId = 0;
  @override
  void initState() {
    super.initState();
    getPokemon();
  }

  Future<void> getPokemon() async {
    pokemonId++;
    final response =
        await Dio().get("https://pokeapi.co/api/v2/pokemon/$pokemonId");
    response;
    pokemon = Pokemon.fromJson(response.data);
    setState(() {});

    print("Data -->${pokemon?.name}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Pokemon Id: $pokemonId'),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(pokemon?.name ?? "No data"),
          if (pokemon != null) ...[
            Image.network(pokemon!.sprites.frontDefault),
            Image.network(pokemon!.sprites.backDefault),
          ]
        ],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: getPokemon,
        child: const Icon(Icons.navigate_next),
      ),
    );
  }
}
