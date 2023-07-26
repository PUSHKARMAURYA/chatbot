#!/bin/bash

display_chessboard() {
    local -r board_size=8
    local -r tile_size=5

    declare -A chessboard

    # Set up the chessboard with alternating colors
    for ((row=0; row<$board_size; row++)); do
        for ((col=0; col<$board_size; col++)); do
            if (( (row + col) % 2 == 0 )); then
                chessboard[$row,$col]="\e[47m"
            else
                chessboard[$row,$col]="\e[100m"
            fi
        done
    done

    # Add chess pieces
    chessboard[0,0]="\e[91m♜\e[0m"
    chessboard[0,1]="\e[91m♞\e[0m"
    chessboard[0,2]="\e[91m♝\e[0m"
    chessboard[0,3]="\e[91m♛\e[0m"
    chessboard[0,4]="\e[91m♚\e[0m"
    chessboard[0,5]="\e[91m♝\e[0m"
    chessboard[0,6]="\e[91m♞\e[0m"
    chessboard[0,7]="\e[91m♜\e[0m"
    chessboard[1,0]="\e[91m♟\e[0m"
    chessboard[1,1]="\e[91m♟\e[0m"
    chessboard[1,2]="\e[91m♟\e[0m"
    chessboard[1,3]="\e[91m♟\e[0m"
    chessboard[1,4]="\e[91m♟\e[0m"
    chessboard[1,5]="\e[91m♟\e[0m"
    chessboard[1,6]="\e[91m♟\e[0m"
    chessboard[1,7]="\e[91m♟\e[0m"
    chessboard[7,0]="\e[96m♖\e[0m"
    chessboard[7,1]="\e[96m♘\e[0m"
    chessboard[7,2]="\e[96m♗\e[0m"
    chessboard[7,3]="\e[96m♕\e[0m"
    chessboard[
