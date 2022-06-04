import 'package:flutter/material.dart';
import 'package:tictac/constants.dart';
import 'package:tictac/logic.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String activePlayer = 'x';
  bool gameOver = false;
  int turn = 0;
  String result = '';
  Game game = Game();
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Column(
          children: [
            SwitchListTile.adaptive(
                title: const Text(
                  'Tern off/on two player',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
                value: isSwitched,
                onChanged: (bool newValue) {
                  setState(() {
                    isSwitched = newValue;
                  });
                }),
            Text(
              "it's $activePlayer turn".toUpperCase(),
              style: TextStyle(color: Colors.white, fontSize: 52),
              textAlign: TextAlign.center,
            ),
            Expanded(
                child: GridView.count(
              padding: const EdgeInsets.all(16),
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 1.0,
              crossAxisCount: 3,
              children: List.generate(
                  9,
                  (index) => InkWell(
                        borderRadius: BorderRadius.circular(16),
                        onTap: gameOver ? null : () => _onTap(index),
                        child: Container(
                          decoration: BoxDecoration(
                            color: shadowColor,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Center(
                            child: Text(
                                Player.playerX.contains(index)
                                    ? 'X'
                                    : Player.playerO.contains(index)
                                        ? "O"
                                        : "",
                                style: TextStyle(
                                    color: Player.playerX.contains(index)
                                        ? Colors.blue
                                        : Colors.pink,
                                    fontSize: 52)),
                          ),
                        ),
                      )),
            )),
            Text(
              result,
              style: const TextStyle(color: Colors.white, fontSize: 42),
              textAlign: TextAlign.center,
            ),
            ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    Player.playerX = [];
                    Player.playerO = [];
                    activePlayer = 'x';
                    gameOver = false;
                    turn = 0;
                    result = '';
                  });
                },
                icon: const Icon(Icons.replay),
                label: const Text("Repeat the game"))
          ],
        ),
      ),
    );
  }

  _onTap(int index) async {


    if ((Player.playerX.isEmpty || !Player.playerX.contains(index)) &&
        (Player.playerO.isEmpty || !Player.playerO.contains(index)))
      game.playGame(index, activePlayer);
      updateStata();

      if(!isSwitched && !gameOver && turn!=9){
        await game.autoplay(activePlayer);
        updateStata();
      }



  }

  void updateStata() {
    setState(() {
      activePlayer = (activePlayer == "x") ? "O" : "x";
turn++;
      String  winnerPlayer = game.checkWinner();
      if(winnerPlayer != ""){
        gameOver=true;
        result = "$winnerPlayer is the winner";
      }
      else if (!gameOver && turn==9){
        result= 'It\'s Draw!';
      }
    });
  }
}
