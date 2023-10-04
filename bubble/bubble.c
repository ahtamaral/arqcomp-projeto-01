#include <stdio.h>

int a[] = {9, 8, 6, 5, 1, 2, 3, 4};
int n = 10;

void swap(int a[], int j, int iMin) {
    int temp = a[j];
    a[j] = a[iMin];
    a[iMin] = temp;
}

void sort(int a[], int n) {
    int swapCount = 0;

    for (int j = 0; j < n - 1; j++) {
        int iMin = j;

        for (int i = j + 1; i < n; i++) {
            if (a[i] < a[iMin]) {
                iMin = i;
            }
        }

        if (iMin != j) {
            swap(a, j, iMin);
            swapCount++;
        }
    }

    printf("Contagem de Trocas: %d\n", swapCount);
}

void printArray(int a[], int n) {
    for (int i = 0; i < n; i++) {
        printf("%d ", a[i]);
    }
    printf("\n");
}

int main() {
    printf("Array não ordenado: ");
    printArray(a, n);
    sort(a, n);
    printf("Array ordenado: ");
    printArray(a, n);

    return 0;
}
