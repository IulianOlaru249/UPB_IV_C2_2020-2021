#include <stdio.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <dirent.h>
#include <string.h>
#include <stdlib.h>

int main(int argc, char **argv) {

    DIR *d;
	FILE *fptr;
    char ch;
	int count=0;
    struct dirent *dir;
    char dir_name[] = "./files/";
    char *filename = malloc(100 * sizeof(char));
    long sum = 0;
    int *apparitions = NULL;

    d = opendir(dir_name);
    if (d) {

        //#pragma omp parallel for reduction( +:sum )
        while ((dir = readdir(d)) != NULL) {
            memset(filename, 0, 100);
            strcat(filename, dir_name);
            strcat(filename, dir->d_name);

            count = 0;
            if (apparitions != NULL)
                free(apparitions);
            apparitions = calloc(1024, sizeof(int));

            fptr=fopen(filename,"r");
            int sum = 0;

            #pragma omp parallel shared(apparitions) reduction(+: sum)
            while((ch=fgetc(fptr))!=EOF) {
                int index = ch;
                sum = apparitions[index];
                sum ++;
                apparitions[index] = sum;
            }
            fclose(fptr);

            int start = 'A';
            int stop = 'Z';
            for (int i = start; i <= stop; i++) {
                printf("%c:%d,", i, apparitions[i]);
            }
            printf("\n");
        }

        closedir(d);
    }

    free(filename);
    return 0;
}