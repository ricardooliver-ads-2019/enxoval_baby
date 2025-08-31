// db_schema.dart
const createTableLayette = '''
CREATE TABLE layettes (
  id TEXT PRIMARY KEY,
  userId TEXT,
  nameBaby TEXT,
  dueDate INTEGER,
  totalBudget INTEGER,
  climate TEXT,
  numberOfBabies INTEGER,
  layetteDurationInMonths INTEGER,
  globalProgress REAL,
  totalSpentAll INTEGER,
  totalNeededAll INTEGER,
  totalPurchasedAll INTEGER,
  updatedAt INTEGER,
  remoteUpdatedAt INTEGER,
  deletedAt INTEGER,
  syncStatus INTEGER DEFAULT 1
);
''';

const createTableCategory = '''
CREATE TABLE categories (
  id TEXT PRIMARY KEY,
  layetteId TEXT NOT NULL,
  name TEXT NOT NULL,
  icon TEXT,
  progress REAL,
  isCustom INTEGER DEFAULT 0,
  totalNeeded INTEGER,
  totalPurchased INTEGER,
  totalSpent INTEGER,
  updatedAt INTEGER,
  remoteUpdatedAt INTEGER,
  deletedAt INTEGER,
  syncStatus INTEGER DEFAULT 1,
  FOREIGN KEY (layetteId) REFERENCES layettes(id) ON DELETE CASCADE
);
''';

const createTableItem = '''
CREATE TABLE items (
  id TEXT PRIMARY KEY,
  categoryId TEXT NOT NULL,
  name TEXT NOT NULL,
  icon TEXT,
  quantityNeeded INTEGER,
  quantityPurchased INTEGER,
  priority TEXT,
  notesItems TEXT,
  notesUser TEXT,
  purchaseLink TEXT,
  isPresente INTEGER DEFAULT 0,
  value INTEGER,
  isCustom INTEGER DEFAULT 0,
  updatedAt INTEGER,
  remoteUpdatedAt INTEGER,
  deletedAt INTEGER,
  syncStatus INTEGER DEFAULT 1,
  FOREIGN KEY (categoryId) REFERENCES categories(id) ON DELETE CASCADE
);
''';

const List<String> createIndexes = [
  'CREATE INDEX IF NOT EXISTS idx_items_category ON items(categoryId);',
  'CREATE INDEX IF NOT EXISTS idx_items_sync ON items(syncStatus);',
  'CREATE INDEX IF NOT EXISTS idx_categories_layette ON categories(layetteId);',
  'CREATE INDEX IF NOT EXISTS idx_categories_sync ON categories(syncStatus);',
  'CREATE INDEX IF NOT EXISTS idx_layettes_sync ON layettes(syncStatus);',
];
