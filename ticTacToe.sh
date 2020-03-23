#!/bin/bash -x

echo "Welcome To Tic Tac Toe"

#constants
TOTAL_MOVES=9

#variables
playerMoves=0
playerTurn=0

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
	for((i=0;i<7;i+=3))
	do
		echo "| ${gameBoard[$i]} | ${gameBoard[$((i+1))]} | ${gameBoard[$((i+2))]} |"
		echo "-------------"
	done
}

#Assiging letter X or O to player and decide who play first
function tossForPlay()
{
	if [ $(( RANDOM % 2 )) -eq 0 ]; then
		computer=X
		player=O
	else
		player=X
		computer=O
	fi
	[ $player == X ] && echo "Player play first with X sign" || echo "Computer play first with X sign"
	[ $player == X ] && playerTurn || computerTurn
}

#Switching players
function switchPlayer()
{
	#Checking condition using Ternary operators
	[ $playerTurn == 1 ] && computerTurn || playerTurn
}

#Function for user play
function playerTurn()
{
	#FUNCNAME is an array containing all the names of the functions in the call stack
	playerTurn=1
	[ ${FUNCNAME[1]} == switchPlayer ] && echo "Player Turn Sign : $player"
	read -p "Enter Position Between 1 to 9 : " position
	if [[ $position -ge 1 && $position -le 9 ]]; then
		isCellEmpty $position $player
	else
		echo "Please enter value"
		playerTurn
	fi
}

#Function for computer play
function computerTurn()
{
	[ ${FUNCNAME[1]} == switchPlayer ] && echo " Computer Turn Sign $computer"
	playerTurn=0
	position=$((RANDOM % 9))
	isCellEmpty $position $computer
}

#checking position is already filled or blank
function isCellEmpty() 
{
	local position=$1-1
	local sign=$2
	if((${gameBoard[position]}!=X && ${gameBoard[position]}!=O))
	then
		gameBoard[$position]=$sign
		((playerMoves++))
	else
		[ ${FUNCNAME[1]} == "playerTurn" ] && echo "Position is Occupied"
		${FUNCNAME[1]}
	fi
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
		[ $cell1 == $player ] && winner=player || winner=computer
		echo "$winner win and have sign $cell1"
		exit
	fi
}

#Running game untill game ends
function playTillGameEnd()
{
	resetBoard
	tossForPlay
	while [ $playerMoves -lt $TOTAL_MOVES ]
	do
		displayBoard
		checkWinningCells
		switchPlayer
	done
	displayBoard
	echo "Game Tie"
}

#starting game
playTillGameEnd
