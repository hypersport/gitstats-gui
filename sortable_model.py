from PySide6.QtCore import Qt, QSortFilterProxyModel, Signal, Property, Slot


class SortableModel(QSortFilterProxyModel):
    sortOrderChanged = Signal() 

    def __init__(self, source_model, sortOrder, defaultSortedColumn,
                 unsortedColumns = [], parent=None):
        super().__init__(parent)
        self.setSourceModel(source_model)
        self._headers = self.sourceModel()._headers
        self.setSortCaseSensitivity(Qt.CaseInsensitive)
        self.setSortRole(Qt.UserRole)
        self._sortOrder = sortOrder
        self._sortedColumn = defaultSortedColumn
        self._unsortedColumn = unsortedColumns
        self.sortOrderChanged.emit()

    @Slot(int)
    def toggleSort(self, column):
        if column in self._unsortedColumn:
            return
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

    @Property("QStringList", notify=sortOrderChanged)
    def headers(self):
        return self._headers
