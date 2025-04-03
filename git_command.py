import os
import re
import subprocess
import datetime


class GitCommand:
    def __init__(self):
        self._commit_stats = []
        self._file_stats = {'Unknown': 0}

    def _runCommand(self, command: str, path=None):
        result = subprocess.run(command, cwd=path, shell=True,
                                capture_output=True, text=True)
        return (result.stdout, result.stderr)

    def getGitVersion(self):
        command = 'git version'
        result = self._runCommand(command)
        return result[0]

    def isGitRepo(self, path: str):
        command = 'git rev-parse --is-inside-work-tree'
        result = self._runCommand(command, path)
        return 'true' in result[0].lower()

    def getProjectName(self, path: str):
        return os.path.basename(os.path.abspath(path))

    def getCurrentBranch(self, path: str):
        command = 'git branch --show-current'
        result = self._runCommand(command, path)
        return result[0]

    def generateGitStats(self, path: str):
        self._commit_stats = []
        command = 'git log -1 --pretty=format:"%H"'
        result = self._runCommand(command, path)
        if result[0]:
            last_commit = result[0].strip()
            # Get commit stats
            command = f'git log --shortstat --first-parent -m --pretty=format:"%at %ai %aN" {last_commit}'
            result = self._runCommand(command, path)
            commits = result[0].strip().split('\n\n')
            pattern = re.compile(r'(\d+) (\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}) [\+\-]\d{4} (\w+)')
            for commit in commits:
                match = pattern.match(commit)
                if not match:
                    continue
                timestamp, datetime_, user = match.groups()
                insertions = re.search(r"(\d+) insertions?\(\+\)", commit)
                deletions = re.search(r"(\d+) deletions?\(-\)", commit)
                insertions_count = insertions.group(1) if insertions else '0'
                deletions_count = deletions.group(1) if deletions else '0'
                self._commit_stats.append(f'{timestamp} {datetime_} {user} {insertions_count} {deletions_count}')
            # Get file stats
            self._file_stats = {'Unknown': 0}
            command = f'git ls-tree -r --name-only {last_commit}'
            result = self._runCommand(command, path)
            files = result[0].strip().split('\n')
            for file in files:
                _, file_extension = os.path.splitext(file)
                if file_extension:
                    self._file_stats[file_extension] = self._file_stats.get(file_extension, 0) + 1
                else:
                    self._file_stats['Unknown'] += 1

    def getFirstCommitTime(self):
        if not self._commit_stats:
            return ''
        first_commit_info = self._commit_stats[-1].split(' ')
        return ' '.join(first_commit_info[1:3])
    
    def getLastCommitTime(self):
        if not self._commit_stats:
            return ''
        last_commit_info = self._commit_stats[0].split(' ')
        return ' '.join(last_commit_info[1:3])

    def getAge(self):
        if not self._commit_stats:
            return ''
        first_commit_info = self._commit_stats[-1].split(' ')
        first_date = datetime.datetime.fromtimestamp(int(first_commit_info[0]))
        last_commit_info = self._commit_stats[0].split(' ')
        last_date = datetime.datetime.fromtimestamp(int(last_commit_info[0]))
        delta = last_date - first_date
        return delta.days

    def getTotalFiles(self):
        return sum(self._file_stats.values())

    def getTotalCommits(self):
        return len(self._commit_stats)

    def getTotalAuthors(self):
        authors = set()
        for commit in self._commit_stats:
            authors.add(commit.split(' ')[3])
        return len(authors)

    def getTotalLines(self):
        total_insertions = 0
        total_deletions = 0
        for commit in self._commit_stats:
            insertions, deletions = commit.split(' ')[4:6]
            total_insertions += int(insertions)
            total_deletions += int(deletions)
        return f'{total_insertions - total_deletions} {total_insertions} {total_deletions}'