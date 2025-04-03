from PySide6.QtCore import QAbstractTableModel, Qt


class AuthorsModel(QAbstractTableModel):
    def __init__(self, data):
        super().__init__()
        self.headers = ['Author', 'Commits', 'Total Lines', 'Insertions', 'Deletions',
        'First Commit', 'Last Commit', 'Days', 'Active Days', 'Active Percentage']
        self._authors = data

    def rowCount(self, index):
        return len(self._authors)
    
    def columnCount(self, index):
        return len(self.headers)

    def data(self, index, role):
        if not index.isValid() or not (0 <= index.row() < len(self._authors)):
            return None
        if role == Qt.DisplayRole:
            return self._authors[index.row()][index.column()]
        return None

    def headerData(self, section, orientation, role):
        if role == Qt.DisplayRole and orientation == Qt.Horizontal:
            return self.headers[section]
        return None

    def sort(self, column, order):
        self.beginResetModel()
        self._authors.sort(key=lambda x: x[column], reverse=order == Qt.DescendingOrder)
        self.endResetModel()
