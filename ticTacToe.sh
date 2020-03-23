#!/bin/bash -x

echo "Welcome To Tic Tac Toe"

#array for game board
declare -a gameBoard

#Restting game board
function resetBoard()
{
	gameBoard=(- - - - - - - - -)
}

function assignSignToPlayer()
{
	if [ $(( RANDOM % 2 )) -eq 1 ]; then
		player=X
	else
		player=O
	fi
}

resetBoard
assignSignToPlayer
