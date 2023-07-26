#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct Node {
    char* data;
    struct Node* next;
};

// Function to create a new node
struct Node* createNode(char* line) {
    struct Node* newNode = (struct Node*)malloc(sizeof(struct Node));
    if (newNode == NULL) {
        perror("Memory allocation error");
        exit(EXIT_FAILURE);
    }
    newNode->data = strdup(line);
    newNode->next = NULL;
    return newNode;
}

// Function to add a node at the end of the linked list
void appendNode(struct Node** headRef, struct Node* newNode) {
    if (*headRef == NULL) {
        *headRef = newNode;
        return;
    }

    struct Node* current = *headRef;
    while (current->next != NULL) {
        current = current->next;
    }
    current->next = newNode;
}

// Function to free the entire linked list
void freeLinkedList(struct Node** headRef) {
    struct Node* current = *headRef;
    while (current != NULL) {
        struct Node* temp = current;
        current = current->next;
        free(temp->data);
        free(temp);
    }
    *headRef = NULL;
}

// Function to print the last n lines
void tailNLines(FILE* file, int n) {
    struct Node* head = NULL;
    char buffer[256]; // Assuming maximum line length is 255 characters

    while (fgets(buffer, sizeof(buffer), file) != NULL) {
        // Create a new node for the current line
        struct Node* newNode = createNode(buffer);

        // Add the node at the end of the linked list
        appendNode(&head, newNode);

        // If we have more than n lines, remove the first node
        if (n < 0) {
            struct Node* temp = head;
            head = head->next;
            free(temp->data);
            free(temp);
        }
    }

    // Print the last n lines
    struct Node* current = head;
    while (current != NULL) {
        printf("%s", current->data);
        current = current->next;
    }

    // Free the memory used by the linked list
    freeLinkedList(&head);
}

int main(int argc, char* argv[]) {
    if (argc != 3) {
        printf("Usage: %s -n <number_of_lines>\n", argv[0]);
        return 1;
    }

    int n = atoi(argv[2]);
    if (n <= 0) {
        printf("Invalid number of lines: %d\n", n);
        return 1;
    }

    // Open the file for reading
    FILE* file = fopen("input.txt", "r");
    if (file == NULL) {
        perror("Error opening the file");
        return 1;
    }

    // Process the file and print the last n lines
    tailNLines(file, -n);

    // Close the file
    fclose(file);
    return 0;
}
