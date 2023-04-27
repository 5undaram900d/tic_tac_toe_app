
import 'dart:async';

import 'package:a01_tic_tac_toe/a02_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TicTacToe extends StatefulWidget {
  const TicTacToe({Key? key}) : super(key: key);

  @override
  State<TicTacToe> createState() => _TicTacToeState();
}

class _TicTacToeState extends State<TicTacToe> {

  bool oTurn = true;
  List<String> displayXO = ['', '', '', '', '', '', '', '', ''];
  List<int> matchedIndex = [];
  int attempts = 0;
  int oScore = 0;
  int xScore = 0;
  int filledBox = 0;
  var res = '';
  bool winnerFound = false;
  static const maxSecond = 30;
  int seconds = maxSecond;
  Timer? timer;


  void startTimer(){
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if(seconds > 0){
          seconds--;
        }
        else{
          stopTimer();
        }
      });
    });
  }

  void stopTimer(){
    resetTimer();
    timer?.cancel();
  }

  void resetTimer() {
    seconds = maxSecond;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UseColors.primaryColor,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text('Player O', style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),),
                      Text(oScore.toString(), style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),)
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text('Player X', style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),),
                      Text(xScore.toString(), style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),)
                    ],
                  )
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: GridView.builder(
                itemCount: 9,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                itemBuilder: (BuildContext context, int index){
                  return GestureDetector(
                    onTap: () {
                      _tapped(index);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(width: 5, color: UseColors.primaryColor),
                        color: matchedIndex.contains(index) ? UseColors.accentColor : UseColors.secondaryColor
                      ),
                      child: Center(
                        child: Text(displayXO[index], style: GoogleFonts.coiny(textStyle: TextStyle(fontSize: 90, color: UseColors.primaryColor, fontWeight: FontWeight.bold)),),
                      ),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: Column(
                  children: [
                    Text(res, style: const TextStyle(color: Colors.white, fontSize: 30, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),),
                    const SizedBox(height: 5,),
                    _buildTimer()
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _tapped(int index){
    final isRunning = timer==null ? false : timer!.isActive;

    if(isRunning){
      setState(() {
        if(oTurn && displayXO[index]==''){
          displayXO[index] = 'O';
          filledBox++;
          oTurn = !oTurn;
        }
        else if (!oTurn && displayXO[index]==''){
          displayXO[index] = 'X';
          filledBox++;
          oTurn = !oTurn;
        }
        _checkWinner();
      });
    }
  }

  void _checkWinner(){
    if(displayXO[0]==displayXO[1] && displayXO[0]==displayXO[2] && displayXO[0] != ''){
      setState(() {
        res = 'Player ${displayXO[0]} Win the match!!!!';
        matchedIndex.addAll([0, 1, 2]);
        stopTimer();
        _updateScore(displayXO[0]);
      });
    }
    else if(displayXO[3]==displayXO[4] && displayXO[3]==displayXO[5] && displayXO[3] != ''){
      setState(() {
        res = 'Player ${displayXO[3]} Win the match!!!!';
        matchedIndex.addAll([3, 4, 5]);
        stopTimer();
        _updateScore(displayXO[3]);
      });
    }
    else if(displayXO[6]==displayXO[7] && displayXO[6]==displayXO[8] && displayXO[6] != ''){
      setState(() {
        res = 'Player ${displayXO[6]} Win the match!!!!';
        matchedIndex.addAll([6, 7, 8]);
        stopTimer();
        _updateScore(displayXO[6]);
      });
    }
    else if(displayXO[0]==displayXO[3] && displayXO[0]==displayXO[6] && displayXO[0] != ''){
      setState(() {
        res = 'Player ${displayXO[0]} Win the match!!!!';
        matchedIndex.addAll([0, 3, 6]);
        stopTimer();
        _updateScore(displayXO[0]);
      });
    }
    else if(displayXO[1]==displayXO[4] && displayXO[1]==displayXO[7] && displayXO[1] != ''){
      setState(() {
        res = 'Player ${displayXO[1]} Win the match!!!!';
        matchedIndex.addAll([1, 4, 7]);
        stopTimer();
        _updateScore(displayXO[1]);
      });
    }
    else if(displayXO[2]==displayXO[5] && displayXO[2]==displayXO[8] && displayXO[2] != ''){
      setState(() {
        res = 'Player ${displayXO[2]} Win the match!!!!';
        matchedIndex.addAll([2, 5, 8]);
        stopTimer();
        _updateScore(displayXO[2]);
      });
    }
    else if(displayXO[0]==displayXO[4] && displayXO[0]==displayXO[8] && displayXO[0] != ''){
      setState(() {
        res = 'Player ${displayXO[0]} Win the match!!!!';
        matchedIndex.addAll([0, 4, 8]);
        stopTimer();
        _updateScore(displayXO[0]);
      });
    }
    else if(displayXO[2]==displayXO[4] && displayXO[2]==displayXO[6] && displayXO[2] != ''){
      setState(() {
        res = 'Player ${displayXO[2]} Win the match!!!!';
        matchedIndex.addAll([2, 4, 6]);
        stopTimer();
        _updateScore(displayXO[2]);
      });
    }

    else if(!winnerFound && filledBox == 9){
      setState(() {
        res = 'Match Draw!!!';
      });
    }
  }

  void _updateScore(String winner){
    if(winner == 'O'){
      oScore++;
      winnerFound = true;
    }
    else if(winner == 'X'){
      xScore++;
      winnerFound = true;
    }
  }

  _clearBoard(){
    setState(() {
      for(int i=0; i<9; i++){
        displayXO[i] = '';
      }
      res = '';
    });
    filledBox = 0;
  }

  Widget _buildTimer(){
    final isRunning = timer==null ? false : timer!.isActive;
    return isRunning
        ? SizedBox(
            width: 70,
            height: 70,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CircularProgressIndicator(
                  value: 1 - seconds / maxSecond,
                  valueColor: const AlwaysStoppedAnimation(Colors.white),
                  strokeWidth: 8,
                  backgroundColor: UseColors.accentColor,
                ),
                Center(
                  child: Text('$seconds', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 30),),
                )
              ],
            ),
          )
        : ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32)
            ),
            onPressed: (){
              startTimer();
              _clearBoard();
              attempts++;

              matchedIndex = [];      // this is line for again regain same color

            },
            child: Text( attempts==0 ? 'Start' : 'Play Again!', style: const TextStyle(fontSize: 18, color: Colors.black),),
          );
  }

}
