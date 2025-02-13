#!/bin/bash
cpp_rel="./cpp/.devcontainer"
cpp_full=$(realpath "$cpp_rel")
alias_function=$(cat <<EOF
newscala3() {
    local project_name=\$1
    echo "project_name: \$project_name"
    echo "test cpp_full: $cpp_full"
}
export -f newscala3
EOF
)

bashrc_full=$(realpath ~/.bashrc)
echo "bashrc_full: $bashrc_full"
echo "$alias_function" >> $bashrc_full
