/* Windows build only (Asciiverse): nstars includes <ncurses.h>; PDCurses
 * calls it <curses.h>. MinGW's C library has no strndup(), which nstars
 * uses for its command history, so one is supplied here. */
#ifndef ASCIIVERSE_WIN32_NCURSES_H
#define ASCIIVERSE_WIN32_NCURSES_H
#include <curses.h>
#include <stdlib.h>
#include <string.h>

static inline char *strndup(const char *s, size_t n)
{
	size_t len = strnlen(s, n);
	char *copy = malloc(len + 1);
	if (copy) {
		memcpy(copy, s, len);
		copy[len] = '\0';
	}
	return copy;
}
#endif
