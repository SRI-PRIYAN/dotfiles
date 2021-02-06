from bs4 import BeautifulSoup
import sys
import os
import requests
import shutil

#Takes the url of the codeforces contest
def get_number_of_problems(contest):
    r = requests.get(contest)
    soup = BeautifulSoup(r.text, "lxml")
    return len(soup.find("table", class_="problems").find_all("tr")) - 1

def create_file(file_name, content):
    with open(file_name, "wt") as f:
        f.write(f"{content}\n")

def mcd(dir_name):
    if dir_name not in os.listdir("."):
        os.mkdir(dir_name)
    os.chdir(dir_name)

def get_contest_dir(contest_id):
    contest_dir = f"contest-{contest_id}"

    if os.path.exists(contest_dir):
        print(f"{contest_dir} already exists. Do you wanna redownload the input and output files?")
        print("This won't affect any of the already written source code in that dir [yes/no] : ", end="")
        response = input()
        if response.lower() not in ["yes", "y"]:
            sys.exit(1)

    return contest_dir

def main():
    os.chdir(sys.argv[1])
    contest_id = sys.argv[2]
    contest = f"https://codeforces.com/contest/{contest_id}"

    contest_dir = get_contest_dir(contest_id)
    print(f"Creating {contest_dir} Directory for contest-{contest_id}...")
    mcd(contest_dir)

    n = get_number_of_problems(contest)

    source = os.path.expanduser("~/cp_outline.cpp")
    template_exists = os.path.exists(source)
    for i in range(n):
        problem_id = chr(ord('A') + i)
        print(f"Creating a Directory for Problem-{problem_id}...")
        mcd(problem_id)

        problem_file = f"{problem_id}.cpp"
        if template_exists and problem_file not in os.listdir("."):
            shutil.copy(source, problem_file)

        problem = f"{contest}/problem/{problem_id}"
        r = requests.get(problem)
        soup = BeautifulSoup(r.text, "lxml")
        
        cases = soup.find_all("div", class_="input")
        for ind, case in enumerate(cases):
            content = case.pre.text.strip()
            create_file(f"input{ind + 1}.txt", content)

        outputs = soup.find_all("div", class_="output")
        for ind, output in enumerate(outputs):
            content = output.pre.text.strip()
            create_file(f"output{ind + 1}.txt", content)

        os.chdir("..")

    if not template_exists:
        print("\nCreate a cp_outline.cpp file in the home folder to create the template files for each problem\n")



if __name__ == "__main__":
    main()
