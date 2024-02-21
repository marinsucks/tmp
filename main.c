#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

char *function(char *str)
{
	str = "Main, World!";
	return (str);
}

int	main()
{
	char *str = "Hello, World!";
	str = function(str);

	printf("%s\n", str);
	return (0);
}