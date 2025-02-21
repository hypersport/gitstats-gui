import os
import subprocess


class GitCommand:
    def _runCommand(self, command: str, path=None):
        result = subprocess.run(command, cwd=path, shell=True,
                                capture_output=True, text=True)
        return (result.stdout, result.stderr)

    def hasGit(self):
        command = "git version"
        result = self._runCommand(command)
        return "git version" in result[0]

    def isGitRepo(self, path: str):
        command = "git rev-parse --is-inside-work-tree"
        result = self._runCommand(command, path)
        return 'true' in result[0].lower()

    def getProjectName(self, path: str):
        return os.path.basename(os.path.abspath(path))
