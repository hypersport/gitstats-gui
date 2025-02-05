import os
import subprocess


class GitCommand:
    def _runCommand(self, command: str):
        result = subprocess.run(command, shell=True,
                                capture_output=True, text=True)
        return (result.stdout, result.stderr)

    def hasGit(self):
        command = "git version"
        result = self._runCommand(command)
        return "git version" in result[0]

    def getProjectName(self, path: str):
        return os.path.basename(os.path.abspath(path))
