#include <stdio.h>
#include <string.h>

int main()
{
    char s[22] = {0};
    scanf("%s", s);
    int i = 0, j = strlen(s) - 1;
    int res = 1;
    while (i < j)
    {
        if (s[i] != s[j])
        {
            res = 0;
            break;
        }
        i++;
        j--;
    }
    printf("%d\n", res);
    return 0;
}