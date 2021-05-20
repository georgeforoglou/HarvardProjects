# Minesweeper Project

In this project I am coding an AI algorithm that can play the Minesweeper game. 

The runner.py file was already coded by the tutors, I had to fill the minesweeper.py code and then run the runner.py for the AI to play.

Each sentence of AI's knowledge is presented by a set of cells and a count. The set includes all neihgbor cells of a selected cell, while count represents the amount of mines in the neighbors. These sentences are represented by the class Sentence, which also contains functions known_mines and known_safes for determining if any of the cells in the sentence are known to be mines or known to be safe. It also contains functions mark_mine and mark_safe to update a sentence in response to new information about a cell.

The class MinesweeperAI implements the AI that plays the game. It takes into account the already made moves, the known safe cells and the known mines. While playing new knowledge is created, this knowledge is stored in the AI's knowledge by the add_knowledge function. Finally, if there are no safe moves to be made the AI makes a random move.
