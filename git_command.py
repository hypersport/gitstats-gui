import os
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
        command = 'git log -1 --pretty=format:"%H"'
        result = self._runCommand(command, path)
        if result[0]:
            last_commit = result[0].strip()
            # Get commit stats
            command = f'git rev-list --pretty=format:"%at %ai %aN" {last_commit} | grep -v ^commit'
            result = self._runCommand(command, path)
            self._commit_stats = result[0].strip().split('\n')
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
            authors.add(commit.split(' ')[4])
        return len(authors)