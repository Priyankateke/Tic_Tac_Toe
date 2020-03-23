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
		player=X
	else
		player=O
	fi
	echo "player sign $player"
}

#Switching sign assign to players
function switchPlayerSign()
{
	#Checking condition using Ternary operators
	[ $player == X ] && player=O || player=X
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

#checking position is already filled or blank
function isCellEmpty() {
	local position=$1-1
	if((${gameBoard[position]}!=X && ${gameBoard[position]}!=O))
	then
		gameBoard[$position]=$player
		((playerMoves++))
	else
		echo "Position is Occupied"
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
		checkWinningCells
		switchPlayerSign
	done
	echo "Game Tie"
}

#Checking column, rows and diagonals
function checkWinningCells()
{
	col=0
	for((row=0;row<7;row+=3))
	do
		checkWinner ${gameBoard[$row]} ${gameBoard[$((row+1))]} ${gameBoard[$((row+2))]}
		checkWinner ${gameBoard[$col]} ${gameBoard[$((col+3))]} ${gameBoard[$((col+6))]}
		((col++))
	done
	checkWinner ${gameBoard[0]} ${gameBoard[4]} ${gameBoard[8]}
	checkWinner ${gameBoard[2]} ${gameBoard[4]} ${gameBoard[6]}
}

#Checking winner
function checkWinner()
{
	local cell1=$1 cell2=$2 cell3=$3
	if [ $cell1 == $cell2 ] && [ $cell2 == $cell3 ]; then
		echo "Player Win and have sign $player"
		exit
	fi
}

#starting game
resetBoard
tossForPlay
playTillGameEnd
