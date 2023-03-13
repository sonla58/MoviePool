# bash sh script to get started with the project
# 1. Ask for OMDB API key = key
# 2. Auto create Config.xcconfig file with content: OMDB_KEY = key

echo "Enter OMDB API key: "
read key

echo "OMDB_KEY = $key" > Config.xcconfig
