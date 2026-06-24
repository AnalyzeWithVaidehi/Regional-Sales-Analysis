# 📂 Scripts — Configuration & Dependencies

This folder contains the database connection config and Python dependencies used across all notebooks.

---

## Files

### `config.py` — Database Connection
Stores MySQL credentials used by all notebooks to connect to `sales_hybrid_db`.

```python
DB_CONFIG = {
    'user': 'root',
    'password': 'your_password',
    'host': 'localhost',
    'port': 3306,
    'database': 'sales_hybrid_db'
}
```

**Edit this file before running any notebook.** Replace `your_password` with your actual MySQL root password. All other values can stay as-is if you're running MySQL locally on the default port.

Every notebook imports this file like so:
```python
import sys
sys.path.append(r'path\to\04_scripts')
from config import DB_CONFIG

engine = create_engine(
    f"mysql+pymysql://{DB_CONFIG['user']}:{DB_CONFIG['password']}"
    f"@{DB_CONFIG['host']}:{DB_CONFIG['port']}/{DB_CONFIG['database']}"
)
```

> ⚠️ `config.py` is listed in `.gitignore` if your password is real. Never commit real credentials to a public repository — use environment variables or a secrets manager in production.

---

### `requirements.txt` — Python Dependencies

Install all dependencies with:
```bash
pip install -r 04_scripts/requirements.txt
```

| Library | Purpose |
|---|---|
| `pandas` | Data loading, cleaning, transformation |
| `numpy` | Numerical computing |
| `matplotlib` | Base plotting |
| `seaborn` | Statistical visualisation |
| `scikit-learn` | Linear regression models |
| `sqlalchemy` | Database connection layer |
| `pymysql` | MySQL driver for SQLAlchemy |
| `jupyter` | Notebook environment |

---

## Notes

- `Data_Import.ipynb` (in `05_notebooks/`) handles data loading — there is no separate upload script
- All notebooks must be run from `05_notebooks/` with `04_scripts/` on the Python path (handled automatically inside each notebook via `sys.path.append`)
- See `TECHNICAL_SETUP.md` in the root for the full reproduction walkthrough
