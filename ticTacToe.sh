#!/bin/bash -x

echo "Welcome To Tic Tac Toe"

#array for game board
declare -a gameBoard

#Restting game board
function resetBoard()
{
	gameBoard=(- - - - - - - - -)
}

#Assiging letter X or O to player and decide who play first
function tossForPlay()
{
	if [ $(( RANDOM % 2 )) -eq 0 ]; then
		player=X
		playerTurn=true
	else
		player=O
		playerTurn=true
	fi
}

resetBoard
tossForPlay
