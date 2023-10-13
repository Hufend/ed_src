/*
 * This is a joke about ed.
 * See <https://www.gnu.org/fun/jokes/ed.html>.
 */
#include <stdio.h>
int main() {
	for (;;) {
		scanf("%*[^\n]");
		scanf("%*c");
		printf("?\n"); // ?
	}
}
