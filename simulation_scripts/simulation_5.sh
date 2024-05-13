#!/bin/sh

# Define the output file
output_file="user_data.csv"

# Create or clear the file
echo "" > $output_file

# Function to generate a random string for username or password
generate_random_string() {
    tr -dc A-Za-z0-9 </dev/urandom | head -c 8  # Generates a random 8 character string
}

# Add data to the file
for i in $(seq 1 10); do
    user_id=$i
    user_name=$(generate_random_string)

    # Ensure two specific entries have the password "hello123"
    if [ $i -eq 3 ] || [ $i -eq 7 ]; then
        password="hello123"
    else
        password=$(generate_random_string)
    fi

    # Append the generated data to the file
    echo "$user_id,$user_name,$password" >> $output_file
done

echo "Data generation complete. File: $output_file"
