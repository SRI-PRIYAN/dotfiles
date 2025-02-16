import os
import shutil
import sys

import requests
from bs4 import BeautifulSoup

headers = {
    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36'
}

# Takes the url of the codeforces contest
def get_problem_ids(contest):
    r = requests.get(contest, headers=headers)
    soup = BeautifulSoup(r.text, 'lxml')
    table = soup.find('table', class_='problems')
    rows = table.find_all('tr')[1:]
    return [row.find('td').text.strip() for row in rows]


def create_file(file_name, content):
    with open(file_name, 'wt') as f:
        f.write(f'{content}\n')


def mcd(dir_name):
    if dir_name not in os.listdir('.'):
        os.mkdir(dir_name)
    os.chdir(dir_name)


def get_contest_dir(contest_id):
    contest_dir = f'contest-{contest_id}'

    if os.path.exists(contest_dir):
        print(
            f'{contest_dir} already exists. Wanna redownload the input and output files?'
        )
        print(
            "This won't affect any of the source code in that dir [yes/no] : ",
            end='')
        response = input()
        if response.lower() not in ['yes', 'y']:
            sys.exit(1)

    return contest_dir


def main():
    os.chdir(sys.argv[1])
    contest_id = sys.argv[2]
    contest = f'https://codeforces.com/contest/{contest_id}'

    contest_dir = get_contest_dir(contest_id)
    print(f'Creating {contest_dir} Directory for contest-{contest_id}...')
    mcd(contest_dir)

    problem_ids = get_problem_ids(contest)

    source = os.path.expanduser('~/dotfiles/cp_outline.cpp')
    template_exists = os.path.exists(source)
    for problem_id in problem_ids:
        print(f'Creating a Directory for Problem-{problem_id}...')
        mcd(problem_id)

        problem_file = f'{problem_id}.cpp'
        if template_exists and problem_file not in os.listdir('.'):
            shutil.copy(source, problem_file)

        problem = f'{contest}/problem/{problem_id}'
        r = requests.get(problem, headers=headers)
        soup = BeautifulSoup(r.text, 'lxml')

        cases = soup.find_all('div', class_='input')
        for ind, case in enumerate(cases):
            divs = case.pre.find_all('div')
            if not divs:
                content = case.pre.text.strip()
            else:
                content = ''.join([f'{div.text}\n' for div in divs]).strip()
            create_file(f'input{ind + 1}.txt', content)

        outputs = soup.find_all('div', class_='output')
        for ind, output in enumerate(outputs):
            content = output.pre.text.strip()
            create_file(f'output{ind + 1}.txt', content)

        os.chdir('..')

    if not template_exists:
        print(
            '\nCreate a cp_outline.cpp file in the home folder to create the template files for each problem\n'
        )


if __name__ == '__main__':
    main()
