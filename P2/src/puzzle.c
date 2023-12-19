#include <stdio.h>
#include <stdlib.h>

int n, m;
int maze[8][8] = {0};
int dirs[4][2] = {{1, 0}, {0, 1}, {-1, 0}, {0, -1}};
int beginX, beginY;
int endX, endY;
int ans;

void dfs(int x, int y)
{
    if (x == endX - 1 && y == endY - 1)
    {
        ans++;
        return;
    }
    else if (x < 0 || x >= n || y < 0 || y >= m || maze[x][y] == 1)
    {
        return;
    }
    maze[x][y] = 1;
    for (int i = 0; i < 4; i++)
    {
        int nx = x + dirs[i][0];
        int ny = y + dirs[i][1];
        dfs(nx, ny);
    }
    maze[x][y] = 0;
}

int main()
{
    scanf("%d %d", &n, &m);
    for (int i = 0; i < n; i++)
    {
        for (int j = 0; j < m; j++)
            scanf("%d", &maze[i][j]);
    }
    scanf("%d %d %d %d", &beginX, &beginY, &endX, &endY);
    dfs(beginX - 1, beginY - 1);
    printf("%d\n", ans);
    return 0;
}