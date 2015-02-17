#Hangman

###Usage
---
**To install all dependencies**, cd into the hangman directory and execute:
`>bundle install`

**To run test for a specific class**, execute: `>rspec spec/{classname}_spec.rb`

**To run all tests**, execute: `>bundle exec rspec`

**To run a single game**, execute: `>ruby lib/hangman.rb`

###Testing
---
RSpec tests are included for the following classes:

* Dictionary
* Player
* Game

Where possible, these tests are designed to operate in isolation of code outside of the unit tested.  Test doubles stand in for actual objects and are designed to return known values.

Occasionally methods are stubbed, particularly in the case of dealing with STDIN.

###Class Structure
---

####Dictionary
The dictionary class public API:
* **#new**: Constructor function.  Optional argument is a path to a words file.  If none is provided it defaults to the words.txt file located in the lib directory.

* **#has_word?**  Takes a string as an argument and returns true or false if the word is in the dictionary.

* **#random_word**  Takes no arguments and will return a random word in the dictionary.

####Player
The player class is used when a human is playing a game.

The player class public API:

* **#new**: Constructor function.  Takes a name for the player as an optional argument.  If none is provided, name will default to "Human".

* **#score**: Takes no arguments, returns the players score.

* **#guessed_letters**: Takes no arguments, returns the player's guessed letters.

* **#guessed_words**: Takes no arguments, returns the player's guessed words.

* **#register_word_length**: Takes an integer argument of the word length chosen by the Game class.  In the player class, this method does not change the internal state of the player but is provided so the APIs of Player and ComputerPlayer are identical.

* **#wrong_answer**: Takes no arguments.  Calls to this method increment the player's score as needed.

* **#right_answer**: Takes a string argument which reflects the current state of the board.  This method does not change the internal state of the Player but is provided for an identical API to the ComputerPlayer.

####Game
The Game class controls the flow of the game.

The Game class public API:

* **#new**: Takes an optional options hash as an argument.  Options allow for the following to be specified: `:player`, `:dictionary`, `:quiet`.  Quiet allows for Game to run without printing anything to SDOUT.

* **#start_game**: Takes no arguments.  Initiates the sequence of game steps until the game is over.  Logic involving communicating with Player or ComputerPlayer objects is broken out into the #tick method, which is called internally by #start_game.

The game class has a large private API which will not be discussed here.  It is currently not private for testing purposes (see comments in game.rb).

####ComputerPlayer

The ComputerPlayer public API:

* **#new**: Takes a Dictionary object as its first argument and an optional string representing the Computer's name as a second argument.  If no name is provided it will default to 'Computer'.

* **#score**: Takes no arguments, returns the computer's score.

* **#guessed_letters**: Takes no arguments, returns the computer's guessed letters.  

* **#guessed_words**: Takes no arguments, returns the computer's guessed words.  Note that this will always be empty for the ComputerPlayer, but is provided to match the API of the Player object.

* **#register_word_length**: Takes an integer argument of the word length chosen by the Game class.  This method creates a regular expression for the initial cleaning of its dictionary of possible words and removes all words from its dictionary which are not the correct length.

* **#wrong_answer**: Takes no arguments.  Calls to this method increment the computer's score as needed.  It also creates a regular expression which is used later to remove words which contain the letter it just guessed.

* **#right_answer**: Takes a string argument which reflects the current state of the board.  Uses input to create a regular expression for further reducing the number of possible words it is considering.

####Implementation of ComputerPlayer

Generally the idea behind ComputerPlayer is to have its own hash (dictionary) of words and remove words as they are disqualified, either based on word length, or mismatching characters in the sequence.  The implementation is rather simplistic, but when the ComputerPlayer receives a message from the game that it has made a good or bad guess, it will further filter its possible words.  It does this by iterating through the keys of its hash representing possible words and applies a regular expression to the key.  The regular expression is derived from the current state of the board.  If the key matches, then it remains in the list of possible moves.  It it doesn't, it is removed.  Additionally, if the ComputerPlayer receives a message from the Game that it has made a bad move, it will remove any keys from its hash of possible words which contain the last letter it guessed.

Other implementations are possible for doing this more efficiently.  One possibility would be to build a trie based on the dictionary words.  This would lead to more efficient retrievals but would perform more poorly from a space complexity standpoint.
