

// C program for implementation of selection sort
#include <stdio.h>
 
void swap(int *xp, int *yp)
{
    int temp = *xp;
    *xp = *yp;
    *yp = temp;
}
 
void selectionSort(int arr[], int n)
{
    int i, j, min_idx;

    // One by one move boundary of unsorted subarray
    for (i = 0; i < n-1; i++)
    {
        min_idx = i;
        
        for (j = i+1; j < n; j++) 
        {
            printf("%d%d%d%d%d", i, min_idx, j, arr[j], arr[min_idx]);
            if (arr[j] < arr[min_idx])
                min_idx = j;

            if(min_idx != i)
                printf("%d%d", min_idx, i);
            //     swap(&arr[min_idx], &arr[i]);

        }
    }
}

void printArray(int arr[], int size)
{
    int i;
    for (i=0; i < size; i++)
        printf("%d ", arr[i]);
    printf("\n");
}

// Driver program to test above functions
int main()
{
    int arr[] = {64, 34, 25, 12, 22, 11, 90, 3, 55, 78};
    int n = 10; //sizeof(arr)/sizeof(arr[0]);
    selectionSort(arr, n);
    // printArray(arr, n);
    return 0;
}
