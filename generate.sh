#!/bin/bash

# Create a directory to hold the text files if it doesn't exist
mkdir -p text_files

# Generate 100 JavaScript files, each containing random text and console.log
for i in {1..100}
do
    # Generate a random string of approximately 10KB
    random_text=$(base64 /dev/urandom | head -c 10240)
    
    # Create a JavaScript file with the random text and a console log
    echo "const text_$i = \`$random_text\`;" > "text_files/file_$i.js"
    echo "console.log('Parsed file_$i.js');" >> "text_files/file_$i.js"
done

# For the single 1MB file, create one text declaration and one console.log
# Generate 1MB of random text
random_text=$(base64 /dev/urandom | head -c 1048576)

# Create a single JavaScript file with 1MB of random text and one console log
echo "const text = \`$random_text\`;" > "text_files/all_files_concatenated.js"
echo "console.log('Parsed all_files_concatenated.js');" >> "text_files/all_files_concatenated.js"

# Create index_multi.html for multi-file test with automatic download using direct <script> tags
cat <<EOF > index_multi.html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Download Test - Multi File</title>
</head>
<body>
    <h1>Download Test - Multi File (Automatic)</h1>
EOF

# Add a <script> tag for each file to trigger the downloads
for i in {1..100}
do
    echo "    <script src=\"text_files/file_$i.js\"></script>" >> index_multi.html
done

# Finish the index_multi.html file
cat <<EOF >> index_multi.html
</body>
</html>
EOF

# Create index_single.html for single-file test using a single <script> tag
cat <<EOF > index_single.html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Download Test - Single File</title>
</head>
<body>
    <h1>Download Test - Single File (Automatic)</h1>
    <script src="text_files/all_files_concatenated.js"></script>
</body>
</html>
EOF

echo "100 JavaScript files and a single 1MB file have been generated."
echo "index_multi.html and index_single.html now include <script> tags directly for automatic downloads."
