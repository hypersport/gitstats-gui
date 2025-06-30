import os
import re
import subprocess
import datetime


class GitCommand:
    def __init__(self):
        self._commit_stats = []
        self._file_stats = {'Unknown': 0}

    def _runCommand(self, command: str, path=None):
        result = subprocess.run(command, cwd=path, shell=True, capture_output=True,
                                text=True, encoding='utf-8', errors='ignore')
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
            pattern = re.compile(r'(\d+) (\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}) [\+\-]\d{4} (.+?)\n')
            for commit in commits:
                match = pattern.match(commit)
                if not match:
                    continue
                timestamp, datetime_, user = match.groups()
                insertions = re.search(r"(\d+) insertions?\(\+\)", commit)
                deletions = re.search(r"(\d+) deletions?\(-\)", commit)
                insertions_count = insertions.group(1) if insertions else '0'
                deletions_count = deletions.group(1) if deletions else '0'
                self._commit_stats.append([timestamp, datetime_, user, insertions_count, deletions_count])
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
        first_commit_info = self._commit_stats[-1]
        return first_commit_info[1]
    
    def getLastCommitTime(self):
        if not self._commit_stats:
            return ''
        last_commit_info = self._commit_stats[0]
        return last_commit_info[1]

    def getAge(self):
        if not self._commit_stats:
            return ''
        first_commit_info = self._commit_stats[-1]
        first_date = datetime.datetime.fromtimestamp(int(first_commit_info[0]))
        last_commit_info = self._commit_stats[0]
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
            authors.add(commit[2])
        return len(authors)

    def getTotalLines(self):
        total_insertions = 0
        total_deletions = 0
        for commit in self._commit_stats:
            insertions, deletions = commit[3:5]
            total_insertions += int(insertions)
            total_deletions += int(deletions)
        return f'{total_insertions - total_deletions} {total_insertions} {total_deletions}'

    def getAuthorsData(self):
        authors = {}
        for commit in self._commit_stats:
            _, datetime_, user, insertions, deletions = commit
            date_ = datetime_.split(' ')[0]
            if user in authors:
                authors[user][0] += 1
                authors[user][1] = date_
                if authors[user][3] != date_:
                    authors[user][3] = date_
                    authors[user][4] += 1
                authors[user][5] += int(insertions)
                authors[user][6] += int(deletions)
            else:
                # [commits, first_commit, last_commit, current_day, active_days, insertions, deletions]
                authors[user] = [1, date_, date_, date_, 1, int(insertions), int(deletions)]
        # [user, commits, first_commit, last_commit, total_lines, insertions, deletions, days, active_days, active_percentage]
        result = []
        date_format = "%Y-%m-%d"
        for user, data in authors.items():
            first_commit_date = datetime.datetime.strptime(data[1], date_format)
            last_commit_date = datetime.datetime.strptime(data[2], date_format)
            days = (last_commit_date - first_commit_date).days + 1
            active_percentage = round((data[4] / days) * 100, 2)
            result.append([user, data[0], data[1], data[2], data[5] - data[6], data[5], data[6], days, data[4], active_percentage])
        return result

    def getAuthorsOfYearMonthData(self):
        years = {}
        months = {}
        for commit in self._commit_stats:
            _, datetime_, user, _, _ = commit
            year = datetime_.split(' ')[0].split('-')[0]
            month = '-'.join(datetime_.split(' ')[0].split('-')[:2])
            if year in years:
                years[year][0] += 1
                years[year][1][user] = years[year][1].get(user, 0) + 1
            else:
                years[year] = [1, {user: 1}]
            if month in months:
                months[month][0] += 1
                months[month][1][user] = months[month][1].get(user, 0) + 1
            else:
                months[month] = [1, {user: 1}]
        result = [[], []]
        for year, data in years.items():
            sorted_authors = dict(sorted(data[1].items(), key=lambda item: item[1], reverse=True))
            top3 = list(sorted_authors.items())[:3]
            result[0].append([year, len(data[1]), data[0], top3[0][0], top3[1][0] if len(top3) > 1 else '', top3[2][0] if len(top3) > 2 else '',
                           top3[0][1], top3[1][1] if len(top3) > 1 else 0, top3[2][1] if len(top3) > 2 else 0])
        for month, data in months.items():
            sorted_authors = dict(sorted(data[1].items(), key=lambda item: item[1], reverse=True))
            top3 = list(sorted_authors.items())[:3]
            result[1].append([month, len(data[1]), data[0], top3[0][0], top3[1][0] if len(top3) > 1 else '', top3[2][0] if len(top3) > 2 else '',
                           top3[0][1], top3[1][1] if len(top3) > 1 else 0, top3[2][1] if len(top3) > 2 else 0])
        return result
