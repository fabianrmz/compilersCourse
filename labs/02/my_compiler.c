#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
char *checkSign;
int lnNum;
FILE *f;
char *file;
char ch;
int ignore;

struct Node
{
    char data;
    int line;
    struct Node *next;
    struct Node *prev;
};

void printErrorsLeft(struct Node *n)
{
    while (n != NULL)
    {
        switch (n->data)
        {
        case ((char)0):
            /* code */
            break;

        default:
            printf("There is a missing %c in line: %d\n", n->data, n->line);

            break;
        }

        n = n->next;
    }
}

int main(int argc, char *argv[])
{

    struct Node *head = NULL;
    head = (struct Node *)malloc(sizeof(struct Node));
    struct Node *current = head;
    current->data = (char)0;
    current->prev = NULL;
    current->next = NULL;
    lnNum = 1;
    ignore = 0;
    if (argc < 2)
    {
        printf("Missing file\n");
        return (1);
    }
    else
    {
        file = argv[1];
    }

    f = fopen(file, "r");
    if (f)
    {

        while ((ch = fgetc(f)) != EOF)
        {

            switch (ch)
            {
            case '(':

                if (ignore == 0)
                {
                    if ((current) == NULL)
                    {
                        current = (struct Node *)malloc(sizeof(struct Node));
                        current->data = ch;
                        current->line = lnNum;
                        current->next = NULL;
                    }
                    else
                    {
                        current->next = (struct Node *)malloc(sizeof(struct Node));
                        current->next->prev = current;
                        current = current->next;
                        current->data = ch;
                        current->line = lnNum;
                        current->next = NULL;
                    }
                }

                break;
            case ')':

                if (ignore == 0)
                {
                    if (current != NULL)
                    {

                        char sign = current->data;

                        switch (sign)
                        {
                        case '(':
                            current = current->prev;
                            current->next = NULL;

                            break;

                        default:
                            printf("There is a missing ( in line: %d\n", lnNum - 1);

                            break;
                        }
                    }
                }
                break;
            case '{':

                if (ignore == 0)
                {
                    if ((current) == NULL)
                    {
                        current = (struct Node *)malloc(sizeof(struct Node));
                        current->data = ch;
                        current->line = lnNum;
                        current->next = NULL;
                    }
                    else
                    {
                        current->next = (struct Node *)malloc(sizeof(struct Node));
                        current->next->prev = current;
                        current = current->next;
                        current->data = ch;
                        current->line = lnNum;
                        current->next = NULL;
                    }
                }

                break;
            case '}':

                if (ignore == 0)
                {
                    if (current != NULL)
                    {

                        char sign = current->data;

                        switch (sign)
                        {
                        case '{':
                            current = current->prev;
                            current->next = NULL;

                            break;

                        default:
                            printf("There is a missing { in line: %d\n", lnNum - 1);

                            break;
                        }
                    }
                }
                break;
            case '[':
                if (ignore == 0)
                {
                    if ((current) == NULL)
                    {
                        current = (struct Node *)malloc(sizeof(struct Node));
                        current->data = ch;
                        current->line = lnNum;
                        current->next = NULL;
                    }
                    else
                    {
                        current->next = (struct Node *)malloc(sizeof(struct Node));
                        current->next->prev = current;
                        current = current->next;
                        current->data = ch;
                        current->line = lnNum;
                        current->next = NULL;
                    }
                }

                break;

            case ']':

                if (ignore == 0)
                {
                    if (current != NULL)
                    {

                        char sign = current->data;
                        switch (sign)
                        {
                        case '[':
                            current = current->prev;
                            current->next = NULL;
                            break;

                        default:
                            printf("There is a missing [ in line: %d\n", lnNum - 1);

                            break;
                        }
                    }
                }
                break;
            case '\'':

                if (ignore == 0)
                {
                    if (current->data == '\'')
                    {

                        current = current->prev;
                        current->next = NULL;
                    }
                    else
                    {

                        current->next = (struct Node *)malloc(sizeof(struct Node));
                        current->next->prev = current;
                        current = current->next;
                        current->data = ch;
                        current->line = lnNum;
                        current->next = NULL;
                    }
                }

                break;
            case '\"':

                if (ignore == 0)
                {
                    if (current->data == '\"')
                    {

                        current = current->prev;
                        current->next = NULL;
                    }
                    else
                    {

                        current->next = (struct Node *)malloc(sizeof(struct Node));
                        current->next->prev = current;
                        current = current->next;
                        current->data = ch;
                        current->line = lnNum;
                        current->next = NULL;
                    }
                }

                break;
            case '/':
                switch (ch = fgetc(f))
                {
                case ('/'):

                    ignore = 1;
                    break;

                default:
                    break;
                }
                lnNum++;

                break;

            case '\n':
                lnNum++;
                ignore = 0;
                break;

            default:

                break;
            }
        }
        printErrorsLeft(head);
    }

    else
    {
        printf("Failed to open the file\n");
    }

    return (0);
}
