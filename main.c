#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

char *ptr(char *str);
char *lines(char *str);


char *function(char *str)
{
	str = "Main with a feature, World!";
	return (str);
}

int	main()
{
	char *str = "Hello, World!";
	str = function(str);

	printf("%s%s%s\n", lines(str), ptr(str), str);
	return (0);
}
