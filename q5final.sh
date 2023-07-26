#!/bin/bash

print_chessboard() {
    for row in {1..8}; do
        for col in {1..8}; do
            if (( (row + col) % 2 == 0 )); then
                echo -n "█ "  # Black square
            else
                echo -n "  "  # White square
            fi
        done
        echo
    done
}

print_chessboard
