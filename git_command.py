import os
import subprocess


class GitCommand:
    def __init__(self):
        self._commit_info = []

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

    def generateCommitInfo(self, path: str):
        command = 'git log -1 --pretty=format:"%H"'
        result = self._runCommand(command, path)
        if result[0]:
            last_commit = result[0].strip()
            command = f'git rev-list --pretty=format:"%at %ai %aN" {last_commit} | grep -v ^commit'
            result = self._runCommand(command, path)
            self._commit_info = result[0].strip().split('\n')

    def getFirstCommitTime(self):
        if not self._commit_info:
            return ''
        first_commit_info = self._commit_info[-1].split(' ')
        return ' '.join(first_commit_info[1:3])
    
    def getLastCommitTime(self):
        if not self._commit_info:
            return ''
        last_commit_info = self._commit_info[0].split(' ')
        return ' '.join(last_commit_info[1:3])
