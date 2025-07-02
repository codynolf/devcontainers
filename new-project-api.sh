#!/bin/bash
bash_aliases_full=$(realpath ~/.bash_aliases)

# create the .bash_aliases file if it doesn't exist
if [ ! -f "$bash_aliases_full" ]; then
    touch "$bash_aliases_full"
fi

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
sed -i '/#c++ new project/,/export -f newcpp/d' $bash_aliases_full
# Write function to bash_aliases
echo "$cpp_function" >> $bash_aliases_full


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
sed -i '/#scala2 new project/,/export -f newscala2/d' $bash_aliases_full
# Write function to bash_aliases
echo "$scala2_function" >> $bash_aliases_full

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
sed -i '/#scala3 new project/,/export -f newscala3/d' $bash_aliases_full
# Write function to bash_aliases
echo "$scala3_function" >> $bash_aliases_full


# .NET
dotnet_rel="./src/dotnet/.devcontainer"
dotnet_full=$(realpath "$dotnet_rel")
dotnet_function=$(cat <<EOF
#dotnet new project
newdotnet() {
    mkdir \$1
    cp -rp $dotnet_full ./\$1
    echo "Successfully created new .NET project: \$1"
}
export -f newdotnet
EOF
)

# Remove existing alias function if it exists
sed -i '/#dotnet new project/,/export -f newdotnet/d' $bash_aliases_full
# Write function to bash_aliases
echo "$dotnet_function" >> $bash_aliases_full

