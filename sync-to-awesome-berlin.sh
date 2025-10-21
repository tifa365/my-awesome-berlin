#!/bin/bash

# Sync script to add entries from my-awesome-berlin to awesome-berlin-data
# Usage: ./sync-to-awesome-berlin.sh "Section Name" "Entry to add"
# Example: ./sync-to-awesome-berlin.sh "Art & Street Culture" "- [Project Name](URL) - Description"

set -e

AWESOME_BERLIN_PATH="/Users/tim/Projekte/awesome-berlin-data"
MY_AWESOME_PATH="/Users/tim/Projekte/my-awesome-berlin"

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

if [ $# -lt 2 ]; then
    echo -e "${YELLOW}Usage: $0 \"Section Name\" \"Entry to add\"${NC}"
    echo ""
    echo "Example:"
    echo "  $0 \"Art & Street Culture\" \"- [New Project](https://github.com/user/project) - Amazing description\""
    echo ""
    echo "Available sections in awesome-berlin-data:"
    grep "^## " "$AWESOME_BERLIN_PATH/README.md" | sed 's/## /  - /'
    exit 1
fi

SECTION="$1"
ENTRY="$2"

# Check if awesome-berlin-data exists
if [ ! -d "$AWESOME_BERLIN_PATH" ]; then
    echo -e "${YELLOW}Error: awesome-berlin-data not found at $AWESOME_BERLIN_PATH${NC}"
    exit 1
fi

# Check if entry already exists in awesome-berlin-data
if grep -Fq "$ENTRY" "$AWESOME_BERLIN_PATH/README.md"; then
    echo -e "${YELLOW}Entry already exists in awesome-berlin-data!${NC}"
    exit 0
fi

echo -e "${BLUE}Adding entry to awesome-berlin-data...${NC}"
echo -e "Section: ${GREEN}$SECTION${NC}"
echo -e "Entry: ${GREEN}$ENTRY${NC}"
echo ""

# Create a temporary file with the updated content
cd "$AWESOME_BERLIN_PATH"

# Find the section and add the entry
# This uses awk to find the section and add the entry after it
awk -v section="## $SECTION" -v entry="$ENTRY" '
    $0 ~ section {
        print
        in_section = 1
        next
    }
    in_section && /^## / {
        print entry
        print ""
        in_section = 0
    }
    in_section && /^- \[/ {
        # Found first entry, add our entry before it if we want alphabetical
        # For now, just add at the end of section
    }
    in_section && /^-{5,}/ {
        print entry
        print ""
        in_section = 0
    }
    { print }
    END {
        if (in_section) {
            print entry
            print ""
        }
    }
' "$AWESOME_BERLIN_PATH/README.md" > "$AWESOME_BERLIN_PATH/README.md.tmp"

mv "$AWESOME_BERLIN_PATH/README.md.tmp" "$AWESOME_BERLIN_PATH/README.md"

# Update the "Last updated" date
sed -i '' "s/Last updated: .*/Last updated: $(date +%Y-%m-%d)/" "$AWESOME_BERLIN_PATH/README.md"

echo -e "${GREEN}✓ Entry added to awesome-berlin-data/README.md${NC}"
echo ""
echo -e "${BLUE}Next steps:${NC}"
echo "  1. Review the changes: cd $AWESOME_BERLIN_PATH && git diff"
echo "  2. Commit: cd $AWESOME_BERLIN_PATH && git add README.md && git commit -m 'Add [project name]'"
echo "  3. Push: cd $AWESOME_BERLIN_PATH && git push"
