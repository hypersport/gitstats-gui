from PySide6.QtCore import Qt, QAbstractTableModel, QSortFilterProxyModel, Signal, Property, Slot


class AuthorsModel(QAbstractTableModel):
    def __init__(self, data, parent=None):
        super().__init__(parent)
        self._data = data
        self._headers = ['Author', 'Commits', 'Total Lines', 'Insertions', 'Deletions',
        'First Commit', 'Last Commit', 'Days', 'Active Days', 'Active Percentage']

    def rowCount(self, parent=None):
        return len(self._data)
    
    def columnCount(self, parent=None):
        return len(self._headers)
    
    def data(self, index, role):
        if role == Qt.DisplayRole and index.isValid() and (0 <= index.row() < len(self._data)):
            return self._data[index.row()][index.column()]
        return None

    def headerData(self, section, orientation, role):
        if role == Qt.DisplayRole and orientation == Qt.Horizontal:
            return self._headers[section]
        return None


class AuthorsSortableModel(QSortFilterProxyModel):
    sortOrderChanged = Signal() 

    def __init__(self, source_model, parent=None):
        super().__init__(parent)
        self.setSourceModel(source_model)
        self._headers = self.sourceModel()._headers
        self.setSortCaseSensitivity(Qt.CaseInsensitive)
        self.setSortRole(Qt.DisplayRole)
        self._sortOrder = Qt.DescendingOrder
        self._sortedColumn = 6
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
        print("kkkkkkkkkkkkkkk")
        print(self._headers)
        return self._headers
