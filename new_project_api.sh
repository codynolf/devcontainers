#!/bin/bash
bashrc_full=$(realpath ~/.bashrc)

# c++
cpp_rel="./src/cpp/.devcontainer"
cpp_full=$(realpath "$cpp_rel")
cpp_function=$(cat <<EOF
#c++ new project
newcpp() {
    mkdir \$1
    cp -rp $cpp_full ./\$1
    echo "Successfully created new c++ project: \$1"
}
export -f newcpp
EOF
)

# Remove existing alias function if it exists
sed -i '/#c++ new project/,/export -f newcpp/d' $bashrc_full
# Write function to bashrc
echo "$cpp_function" >> $bashrc_full


# scala2
scala2_rel="./src/scala2/.devcontainer"
scala2_full=$(realpath "$scala2_rel")
scala2_function=$(cat <<EOF
#scala2 new project
newscala2() {
    mkdir \$1
    cp -rp $scala2_full ./\$1
    echo "Successfully created new scala 2 project: \$1"
}
export -f newscala2
EOF
)

# Remove existing alias function if it exists
sed -i '/#scala2 new project/,/export -f newscala2/d' $bashrc_full
# Write function to bashrc
echo "$scala2_function" >> $bashrc_full

# scala3
scala3_rel="./src/scala3/.devcontainer"
scala3_full=$(realpath "$scala3_rel")
scala3_function=$(cat <<EOF
#scala3 new project
newscala3() {
    mkdir \$1
    cp -rp $scala3_full ./\$1
    echo "Successfully created new scala 3 project: \$1"
}
export -f newscala3
EOF
)

# Remove existing alias function if it exists
sed -i '/#scala3 new project/,/export -f newscala3/d' $bashrc_full
# Write function to bashrc
echo "$scala3_function" >> $bashrc_full

