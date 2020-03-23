#!/bin/bash -x

echo "Welcome To Tic Tac Toe"

#constants
TOTAL_MOVES=9

#variables
playerMoves=0

#array for game board
declare -a gameBoard

#Restting game board
function resetBoard()
{
	gameBoard=(1 2 3 4 5 6 7 8 9)
	displayBoard
}

#Displaying board
function displayBoard()
{
	echo "-------------"
	for((i=0;i<9;i+=3))
	do
		echo "| ${gameBoard[$i]} | ${gameBoard[$((i+1))]} | ${gameBoard[$((i+2))]} |"
		echo "-------------"
	done
}

#Assiging letter X or O to player and decide who play first
function tossForPlay()
{
	if [ $(( RANDOM % 2 )) -eq 0 ]; then
		player='X'
		playerTurn=true
	else
		player='O'
		playerTurn=true
	fi
	echo "player sign $player"
}

#Function for user play
function userPlay()
{
	read -p "Enter Position Between 1 to 9 : " position
	if [[ $position -ge 1 && $position -le 9 ]]; then
		isCellEmpty $position
	else
		echo "Invalid Position"
		userPlay
	fi
}

#Running game untill game ends
function playTillGameEnd()
{
	while [ $playerMoves -lt $TOTAL_MOVES ]
	do
		userPlay
		displayBoard
	done
}

#checking position is already filled or blank
function isCellEmpty() {
	local position=$1-1
	if((${gameBoard[position]}!=$player))
	then
		gameBoard[$position]=$player
		((playerMoves++))
	else
		echo "Position is Occupied"
	fi
}

#starting game
resetBoard
tossForPlay
playTillGameEnd
