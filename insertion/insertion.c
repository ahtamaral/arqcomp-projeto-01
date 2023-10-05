// C program for insertion sort
#include <stdio.h>
 
/* Function to sort an array using insertion sort*/
void insertionSort(int arr[], int n)
{
    int i, key, j;
    for (i = 1; i < n; i++) {
        key = arr[i];
        j = i - 1;
    
        printf("%d%d%d", i,j,key);

        /* Move elements of arr[0..i-1], that are
          greater than key, to one position ahead
          of their current position */
        // while (j >= 0 && arr[j] > key) {
        //     // printf("%d", j);
        //     j = j - 1;
        // }
    }
}

 
/* Driver program to test insertion sort */
int main()
{
    int arr[] = { 64, 34, 25, 12, 22, 11, 90, 3, 55, 78 };
    int n = 10;
 
    insertionSort(arr, n);
 
    return 0;
}