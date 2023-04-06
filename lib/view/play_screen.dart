import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/playscreen_db.dart';

//game_play_screen--------------------------------------------------------------
class PlayScreen extends StatelessWidget {
  final List<String> contents;
  final int rows;
  final int columns;

  const PlayScreen({
    Key? key,
    required this.contents,
    required this.rows,
    required this.columns,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PlayScreenProvider(contents, rows, columns),
      child: Scaffold(
        appBar: AppBar(centerTitle: true, title: const Text('Play Screen')),
        body: Column(
          children: [
//coustem_searche_bar-----------------------------------------------------------
            Consumer<PlayScreenProvider>(
              builder: (context, provider, _) => TextField(
                onChanged: provider.textChanged,
                decoration: const InputDecoration(
                  hintText: 'Search for an alphabet',
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
//grid_show_position------------------------------------------------------------
            Expanded(
              child: Consumer<PlayScreenProvider>(
                builder: (context, provider, _) => GridView.count(
                  crossAxisCount: provider.columns,
                  children: List.generate(provider.letters.length, (index) {
                    return GestureDetector(
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 5, top: 10, right: 5),
                        child: Container(
                          decoration: BoxDecoration(
                            color: provider.gridColors[index],
                            border: Border.all(),
                          ),
                          child: Center(
                            child: Text(
                              provider.letters[index],
                              style: const TextStyle(fontSize: 24),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
