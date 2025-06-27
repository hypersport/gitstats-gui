from PySide6.QtCore import Qt, QAbstractTableModel


class AuthorsModel(QAbstractTableModel):
    def __init__(self, data=[], parent=None):
        super().__init__(parent)
        self._data = data
        self._headers = ['Author', 'Commits', 'First Commit', 'Last Commit', 'Total Lines',
        'Insertions', 'Deletions', 'Days', 'Active Days', 'Active Percentage']
        self._total = [0] * 10
        self._calculatTotal()

    def rowCount(self, parent=None):
        return len(self._data)
    
    def columnCount(self, parent=None):
        return len(self._headers)
    
    def data(self, index, role):
        if not index.isValid() or not (0 <= index.row() < len(self._data)):
            return None
        row = index.row()
        column = index.column()
        value = self._data[row][column]
        if role == Qt.UserRole:
            return value
        elif role == Qt.DisplayRole:
            if column in [0, 2, 3, 9]:
                return value
            else:
                percent = (value / self._total[column] * 100) if self._total[column] else 0
                return f'{value} ({percent:.2f}%)'
        return None

    def resetData(self, data):
        self.beginResetModel()
        self._data = data
        self._calculatTotal()
        self.endResetModel()

    def _calculatTotal(self):
        self._total = [0] * 10
        for row in self._data:
            for i in range(len(row)):
                if i in [0, 2, 3, 9]:
                    continue
                self._total[i] += row[i]


class AuthorsOfYearModel(QAbstractTableModel):
    def __init__(self, data=[], parent=None):
        super().__init__(parent)
        self._data = data
        self._headers = ['Year', 'Total Authors', 'Total Commits', 'No.1', 'No.2', 'No.3']

    def rowCount(self, parent=None):
        return len(self._data)
    
    def columnCount(self, parent=None):
        return len(self._headers)
    
    def data(self, index, role):
        if not index.isValid() or not (0 <= index.row() < len(self._data)) or not (0 <= index.column() < len(self._headers)):
            return None
        row = index.row()
        column = index.column()
        value = self._data[row][column]
        if not value:
            return ''
        if role == Qt.UserRole:
            return value
        elif role == Qt.DisplayRole:
            if column in [0, 1]:
                return value
            elif column == 2:
                average = value / self._data[row][1]
                return f'{value} ({average:.2f} commits per author)'
            else:
                commits = self._data[row][column + 3]
                percent = (commits / self._data[row][2] * 100)
                return f'{value} ({commits} commits {percent:.2f}%)'
        return None

    def resetData(self, data):
        self.beginResetModel()
        self._data = data
        self.endResetModel()
