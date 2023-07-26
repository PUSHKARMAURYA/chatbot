#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

#define MAX_LINE_LENGTH 256

typedef struct {
    char lines[MAX_LINE_LENGTH];
    bool valid;
} LineBuffer;

int main() {
    int n;
    printf("Enter the number of lines (n): ");
    scanf("%d", &n);

    if (n <= 0) {
        printf("Invalid value of n. Please enter a positive integer.\n");
        return 1;
    }

    LineBuffer *buffer = (LineBuffer *)malloc(n * sizeof(LineBuffer));
    if (!buffer) {
        printf("Memory allocation failed.\n");
        return 1;
    }

    for (int i = 0; i < n; i++) {
        buffer[i].valid = false;
    }

    int currentIndex = 0;
    int numLines = 0;

    char line[MAX_LINE_LENGTH];
    while (fgets(line, MAX_LINE_LENGTH, stdin)) {
        // Copy the line into the buffer
        int lineLen = snprintf(buffer[currentIndex].lines, MAX_LINE_LENGTH, "%s", line);
        buffer[currentIndex].valid = true;

        // Move to the next buffer index in a circular manner
        currentIndex = (currentIndex + 1) % n;

        // Increment the number of lines read
        numLines++;

        // If we have read more than 'n' lines, consider the last 'n' lines only
        if (numLines > n) {
            numLines = n;
        }
    }

    // Print the last 'n' lines in the order they were read
    int start = (currentIndex + n - numLines) % n;
    for (int i = 0; i < numLines; i++) {
        if (buffer[start].valid) {
            printf("%s", buffer[start].lines);
        }
        start = (start + 1) % n;
    }

    free(buffer);
    return 0;
}
