#!/bin/bash -x

echo "Welcome To Tic Tac Toe"

#array for game board
declare -a gameBoard

#Restting game board
function resetBoard()
{
	gameBoard=(- - - - - - - - -)
}

