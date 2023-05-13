#include <iostream>
#include <vector>

using namespace std;

typedef long long ll;

template<typename T>
T ceil(T, T);

template<typename T>
bool isPrime(T);

int main() {
  ios::sync_with_stdio(false);
  cin.tie(nullptr);

  int t;
  cin >> t;

  while (t--) {

  }

  return 0;
}

template<typename T>
T ceil(T a, T b) {
  return (a / b) + (a % b != 0);
}

template<typename T>
bool isPrime(T n) {
  if (n <= 1) return false;
  if (n == 2 || n == 3) return true;

  if (n % 2 == 0 || n % 3 == 0) return false;
  for (T i = 5; i * i <= n; i+=6) {
    if ((n % i == 0) || (n % (i + 2) == 0)) return false;
  }

  return true;
}

