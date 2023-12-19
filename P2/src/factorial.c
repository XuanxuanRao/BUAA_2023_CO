#include <stdio.h>

int result[1024] = {1, 0};
int digit = 1;

void mul(int num)
{
    int carry = 0;
    for (int i = 0; i < digit; i++)
    {
        int prod = result[i] * num + carry;
        result[i] = prod % 10;
        carry = prod / 10;
    }
    while (carry)
    {
        result[digit++] = carry % 10;
        carry /= 10;
    }
}

int main()
{
    int n = 54;
    for (int i = 2; i <= n; i++)
    {
        mul(i);
    }
    for (int i = digit - 1; i >= 0; i--)
    {
        printf("%d", result[i]);
    }
    return 0;
}