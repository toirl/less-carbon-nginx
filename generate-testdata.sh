#!/bin/bash

# Create directory for test data
mkdir -p testdata

# File sizes in bytes
sizes=(1024 10240 102400 1048576 10485760)

# Function to generate repetitive content (easily compressible)
generate_repetitive_content() {
  head -c $1 /dev/zero | tr '\0' 'A' >testdata/repetitive_$1B.txt
}

# Function to generate random text (poorly compressible)
generate_random_text() {
  head -c $1 /dev/urandom | base64 | head -c $1 >testdata/random_$1B.txt
}

# Function to generate binary data (e.g. JPEG)
generate_binary_data() {
  dd if=/dev/urandom bs=1 count=$1 status=none | base64 >testdata/binary_$1B.jpg
}

# Generate files
for size in "${sizes[@]}"; do
  generate_repetitive_content $size
  generate_random_text $size
  generate_binary_data $size
done

echo "Test data has been generated and saved in 'testdata/'."
