#include <stdio.h>
#include <stdlib.h>

int n;
int path[5] = {0};
int visited[5] = {0};
int pathSize = 0;

void permute()
{
    if (pathSize == n)
    {
        for (int i = 0; i < n; i++)
            printf("%d ", path[i]);
        printf("\n");
        return;
    }
    else
    {
        for (int i = 0; i < n; i++)
        {
            if (visited[i])
                continue;
            path[pathSize++] = i + 1;
            visited[i] = 1;
            permute();
            pathSize--;
            visited[i] = 0;
        }
    }
}

int main()
{
    scanf("%d", &n);
    permute();
    return 0;
}