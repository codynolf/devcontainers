#!/bin/bash

set -e  # Exit on any error

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# Source logging functions
source "$SCRIPT_DIR/logging.sh"
# Set JSON file path relative to script location
PROJECTS_JSON_FILE="$SCRIPT_DIR/projects.json"

# Check if jq is installed
if ! command -v jq &> /dev/null; then
    log_warn "jq is required but not installed. Installing jq..."
    sudo apt-get update && sudo apt-get install jq -y
fi

# Check if JSON file exists
if [ ! -f "$PROJECTS_JSON_FILE" ]; then
    log_error "$PROJECTS_JSON_FILE not found"
    exit 1
fi

bash_aliases_full=$(realpath ~/.bash_aliases)

# Create the .bash_aliases file if it doesn't exist
if [ ! -f "$bash_aliases_full" ]; then
    touch "$bash_aliases_full"
fi

log_info "Reading project configurations from $PROJECTS_JSON_FILE..."

# Create a temporary file for the new content
temp_file=$(mktemp)

# Read projects from JSON file and create functions
while IFS= read -r project_data; do
    name=$(echo "$project_data" | jq -r '.name')
    path=$(echo "$project_data" | jq -r '.path')
    
    # Resolve the full path
    full_path=$(realpath "$path")
    
    # Create the function content
    function_content=$(cat <<EOF
# $name new project
new$name() {
    if [ ! -d "\$1" ]; then
        mkdir "\$1"
    fi
    cp -rp $full_path ./"\$1"
    echo "Successfully created new $name project: \$1"
}
export -f new$name

EOF
)
    
    log_info "Processing $name project..."
    
    # Write function to temporary file
    echo "$function_content" >> "$temp_file"
    
done < <(jq -c '.projects[]' "$PROJECTS_JSON_FILE")

# Replace the aliases file with the new content
mv "$temp_file" "$bash_aliases_full"

log_success "Successfully updated .bash_aliases with project functions"
