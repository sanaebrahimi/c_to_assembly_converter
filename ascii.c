#include <unistd.h>
#include <stdlib.h>
#include <strings.h>

void printc(char c)
{
  write(STDOUT_FILENO, &c, 1);
}

void printnum(char c)
{
  // Simple method:
  if (c >= 100) printc((c/100)+'0');
  else printc(' ');
  if (c >= 10) printc(((c/10)%10)+'0');
  else printc(' ');
  printc((c%10)+'0');

/*
  // Better method:
  char buf[32];
  int p = 31, min = 3;
  buf[p] = '\0';

  do {
    min--;
    if (c == 0 && p != 31) buf[--p] = ' ';
    else buf[--p] = (c % 10) + '0';
    c = c / 10;
  } while(c > 0 || min > 0);

  write(STDOUT_FILENO, buf+p, 31-p);
*/
}

void printascii(char c)
{
  printc('\t');
  printnum(c);
  printc(':');
  printc(' ');
  printc('\'');
  if (c >= 32 && c < 127) printc(c);
  else printc('.');
  printc('\'');
}

int main(void)
{
  for(char c=0; c < 32; c++) {
    printascii(c);
    printascii(c+32);
    printascii(c+64);
    printascii(c+96);
    printc('\n');
  }
}

