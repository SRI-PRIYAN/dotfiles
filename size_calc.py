import os
import sys


def get_size_of_dir(dirname):
    res = 0

    for name in os.listdir(dirname):
        file_path = os.path.join(dirname, name)
        if os.path.isdir(file_path):
            res += get_size_of_dir(file_path)
        else:
            res += os.path.getsize(file_path)

    return res


def main():
    dirname = sys.argv[1]
    total_size = get_size_of_dir(dirname) / (1024 * 1024)
    print(f"Total Size : {total_size} MB")


if __name__ == "__main__":
    main()
