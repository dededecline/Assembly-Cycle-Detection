#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

struct Node;

typedef struct Node Node;

struct Node {
    Node* next;
    int data;
};

Node* makeList(int loop, int count, int* data) {
    Node* back = 0;
    Node* prev = 0;
    Node* first = 0;

    for (int i=0; i<count; i++) {
        Node* p = (Node*) malloc(sizeof(Node));
        p->data = data[i];
        if (prev != 0) {
            prev->next = p;
        } else {
            first = p;
        }
        if (loop == i) {
            back = p;
        }
        prev = p;
    }
    if (prev != 0) {
        prev->next = back;
    }
    return first;
}

extern int check(Node* p);
extern void reverse(Node* p);

void doit(int loop, int count) {
    int* data = calloc(count, sizeof(int));
    for (int i=0; i<count; i++) {
        data[i] = rand();
    }
    printf("%8d %s cycle : ",count,(loop == -1) ? "without" : "with   ");
    fflush(stdout);
    Node* p = makeList(loop,count,data);
    int x = check(p);

    if (loop == -1) {
        /* no loop */
        if (x != count) {
            printf("check returned %d, expecting %d\n",x,count);
            goto done;
        }
        reverse(p);
        Node* q = p;
        for (int i=0; i<count; i++) {
            if (q == 0) {
                printf("list is too short\n");
                goto done;
            }
            int expect = data[count - i - 1];
            if (expect != q->data) {
                printf("list[%d] is %d but expecting %d\n",
                   i,q->data,expect);
                goto done;
            }
            q = q->next;
        }
        if (q != 0) {
            printf("list is too long\n");
            goto done;
        }
    } else {
        if (x != -1) {
            printf("check returned %d, expecting -1\n",x);
            goto done;
        }
    }

        
    printf("pass\n");
done:
    free(data);
}



int main(int argc, char* argv[]) {
    alarm(10);

    doit(-1,0);
    doit(-1,1);
    doit(-1,2);
    doit(-1,9);
    doit(-1,1000);
    doit(-1,1000005);
    doit(0,1);
    doit(0,2);
    doit(1,2);
    doit(5,9);
    doit(29,1000);
    doit(10,1000005);

    return 0;
}
