# Workflow: Managing Two Awesome Lists

This document explains how to manage both **my-awesome-berlin** (personal curated list) and **awesome-berlin-data** (comprehensive public list).

## Repository Structure

```
/Users/tim/Projekte/
├── my-awesome-berlin/          # Your personal curated collection
│   ├── README.md               # Your refined list
│   ├── sync-to-awesome-berlin.sh  # Sync script
│   └── WORKFLOW.md             # This file
│
└── awesome-berlin-data/        # Comprehensive public collection
    ├── README.md               # Full community list
    └── CONTRIBUTING.md
```

## Workflows

### 1. Adding an Entry ONLY to Your Personal List

```bash
cd /Users/tim/Projekte/my-awesome-berlin
# Edit README.md and add your entry
git add README.md
git commit -m "Add [project name] to my collection"
```

### 2. Adding an Entry to BOTH Lists

**Step 1:** Add to your personal list first
```bash
cd /Users/tim/Projekte/my-awesome-berlin
# Edit README.md and add your entry
git add README.md
git commit -m "Add [project name]"
```

**Step 2:** Use the sync script to add to awesome-berlin-data
```bash
cd /Users/tim/Projekte/my-awesome-berlin
./sync-to-awesome-berlin.sh "Section Name" "- [Project Name](URL) - Description"
```

**Step 3:** Review and commit to awesome-berlin-data
```bash
cd /Users/tim/Projekte/awesome-berlin-data
git diff  # Review changes
git add README.md
git commit -m "Add [project name]"
git push origin main
```

### 3. Manual Sync (Alternative Method)

If you prefer manual control:

1. Edit `my-awesome-berlin/README.md` and add your entry
2. Copy the entry text
3. Open `awesome-berlin-data/README.md`
4. Paste the entry in the appropriate section
5. Commit both repositories separately

## Examples

### Example: Adding a new dataset about Berlin transportation

```bash
# 1. Add to personal list
cd /Users/tim/Projekte/my-awesome-berlin
# Edit README.md, add entry under appropriate section
git add README.md
git commit -m "Add Berlin Transport Dataset"

# 2. Sync to public list
./sync-to-awesome-berlin.sh "Transportation & Mobility" \
  "- [Berlin Transport Data](https://github.com/user/berlin-transport) - Real-time and historical data for Berlin's public transportation network including BVG and S-Bahn."

# 3. Push to public repo
cd /Users/tim/Projekte/awesome-berlin-data
git diff  # Verify the entry looks good
git add README.md
git commit -m "Add Berlin Transport Dataset"
git push origin main
```

## Tips

- **Keep my-awesome-berlin small**: Only add entries you personally use or find essential
- **awesome-berlin-data is comprehensive**: Include anything that might be useful to the broader community
- **Not everything needs to be synced**: It's fine for entries to exist only in awesome-berlin-data
- **Review before pushing**: Always review changes to awesome-berlin-data before pushing to GitHub

## Maintenance

Update the "Last updated" date manually in both READMEs when making changes, or let the sync script handle it for awesome-berlin-data.
