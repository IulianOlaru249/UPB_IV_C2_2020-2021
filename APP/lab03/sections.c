#include <stdio.h> 
#include <stdlib.h>
#include <omp.h>

int main(void) 
{
  int threadId = 0;
  int numThreads = 0;

   numThreads = omp_get_num_threads();
   printf("Num threads: %d\n", numThreads);

   #pragma omp parallel private(threadId)
   {
        #pragma omp sections
        {

            #pragma omp section
            {
                threadId = omp_get_thread_num();
                printf("Thread ID in section 1: %d\n", threadId);

            }

            #pragma omp section
            {
                threadId = omp_get_thread_num();
                printf("Thread ID in section 2: %d\n", threadId);
            }

            #pragma omp section
            {

                threadId = omp_get_thread_num();
                printf("Thread ID in section 3: %d\n", threadId);
            }
       }

   }

   return 0;
}
