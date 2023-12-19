#include <stdio.h>

int main()
{
    int matrix1[8][8] = {0}, matrix2[8][8] = {0};
    int n;
    scanf("%d", &n);
    for (int i = 0; i < n; i++)
    {
        for (int j = 0; j < n; j++)
            scanf("%d", &matrix1[i]);
    }
    for (int i = 0; i < n; i++)
    {
        for (int j = 0; j < n; j++)
            scanf("%d", &matrix2[i]);
    }
    for (int i = 0; i < n; i++)
    {
        for (int j = 0; j < n; j++)
        {
            int ans = 0;
            for (int k = 0; k < n; k++)
            {
                ans += matrix1[i][k] * matrix1[k][j];
            }
            printf("%d\n", ans);
        }
    }
    return 0;
}