#include <stdio.h>

int m1, n1, m2, n2;
int f[10][10];
int h[10][10];

int cal(int x, int y)
{
    int res = 0;
    for (int i = 0; i < m2; i++)
    {
        for (int j = 0; j < n2; j++)
            res += f[i + x][j + y] * h[i][j];
    }
    return res;
}

int main()
{
    scanf("%d %d %d %d", &m1, &n1, &m2, &n2);
    for (int i = 0; i < m1; i++)
    {
        for (int j = 0; j < n1; j++)
            scanf("%d", &f[i][j]);
    }
    for (int i = 0; i < m2; i++)
    {
        for (int j = 0; j < n2; j++)
            scanf("%d", &h[i][j]);
    }
    for (int i = 0; i <= m1 - m2; i++)
    {
        for (int j = 0; j <= n1 - n2; j++)
        {
            printf("%d ", cal(i, j));
        }
        printf("\n");
    }
    return 0;
}