#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>
#include <sys/socket.h>
#include <unistd.h>
#include <netinet/in.h>

#define PORT 3065

int main() {
    int sockfd = socket(AF_INET, SOCK_STREAM, 0);
    if (sockfd < 0) {
        perror("Failed to create socket");
        exit(1);
    }
    else {
        printf("Socket Created Successfully!\n");
    }

    struct sockaddr_in servaddr;
    bzero(&servaddr, sizeof(servaddr));
    servaddr.sin_family = AF_INET;
    servaddr.sin_port = htons(PORT);
    servaddr.sin_addr.s_addr = INADDR_ANY;

    if (bind(sockfd, (struct sockaddr *)&servaddr, sizeof(servaddr)) < 0) {
        perror("Failed to bind");
        exit(1);
    }
    else {
        printf("Socket Binded Successfully!\n");
    }

    if (listen(sockfd, 1) < 0) {
        perror("Failed to listen");
        exit(1);
    }
    else {
        printf("Listening to port %d\n", PORT);
    }

    int connfd = accept(sockfd, NULL, NULL);
    if (connfd < 0) {
        perror("Failed to accept client");
        exit(1);
    }
    else {
        printf("Client accepted and its fd = %d\n", connfd);
    }

    return 0;
}
