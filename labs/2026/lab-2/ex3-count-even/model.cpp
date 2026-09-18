#include <iostream>
using namespace std;

int main() {
    int arr[] = {1, 2, 3, 4, 5, 6};
    int n = 6;
    int count = 0;
    for (int i = 0; i < n; i++)
        if (arr[i] % 2 == 0)
            count++;
    cout << count << endl;
    return 0;
}