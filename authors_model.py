from PySide6.QtCore import Qt, QAbstractTableModel, QSortFilterProxyModel, Signal, Property, Slot


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


class AuthorsSortableModel(QSortFilterProxyModel):
    sortOrderChanged = Signal() 

    def __init__(self, source_model, parent=None):
        super().__init__(parent)
        self.setSourceModel(source_model)
        self._headers = self.sourceModel()._headers
        self.setSortCaseSensitivity(Qt.CaseInsensitive)
        self.setSortRole(Qt.UserRole)
        self._sortOrder = Qt.DescendingOrder
        self._sortedColumn = 3
        self.sortOrderChanged.emit()

    @Slot(int)
    def toggleSort(self, column):
        """Toggle between Ascending and Descending order when clicking a column."""
        if self._sortedColumn == column:
            self._sortOrder = Qt.DescendingOrder if self._sortOrder == Qt.AscendingOrder else Qt.AscendingOrder
        else:
            self._sortedColumn = column
            self._sortOrder = Qt.DescendingOrder  # Default to descending for a new column

        self.sort(self._sortedColumn, self._sortOrder)
        self.sortOrderChanged.emit()

    @Property(int, notify=sortOrderChanged)
    def sortedColumn(self):
        return self._sortedColumn
    
    @Property(int, notify=sortOrderChanged)
    def currentSortOrder(self):
        return 1 if self._sortOrder == Qt.DescendingOrder else 0
    
    @Property("QStringList")
    def headers(self):
        return self._headers
