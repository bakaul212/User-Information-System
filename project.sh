#!/bin/bash

# Function to validate age as a positive integer
validate_age() {
    age=$1
    if ! [[ $age =~ ^[0-9]+$ ]]; then
        echo "Invalid age. Please enter a valid positive integer."
        exit 1
    fi
}

# Function to validate color as a string
validate_color() {
    color=$1
    if ! [[ $color =~ ^[a-zA-Z]+$ ]]; then
        echo "Invalid color. Please enter a valid string."
        exit 1
    fi
}

# Function to validate date of birth in YYYY-MM-DD format
validate_dob() {
    dob=$1
    if ! [[ $dob =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}$ ]]; then
        echo "Invalid date of birth. Please enter a valid date in YYYY-MM-DD format."
        exit 1
    fi
}

# Function to validate NID number as a numeric value
validate_nid() {
    nid=$1
    if ! [[ $nid =~ ^[0-9]+$ ]]; then
        echo "Invalid NID number. Please enter a valid numeric value."
        exit 1
    fi
}

# Main script
echo "What is your name?"
read name

echo "How old are you?"
read age
validate_age "$age"

echo "What is your date of birth? (YYYY-MM-DD)"
read dob
validate_dob "$dob"

echo "What is your favorite color?"
read color
validate_color "$color"

echo "What is your NID number?"
read nid
validate_nid "$nid"

# Display user information
echo "Hello, $name! You are $age years old, born on $dob, with NID number $nid, and your favorite color is $color."

# Ask user if they want to save the information to a password-protected ZIP file
echo "Do you want to save this information to a password-protected ZIP file? (yes/no)"
read save_choice

case $save_choice in
    [Yy][Ee][Ss])
        # Prompt for the filename
        echo "Enter the filename to save:"
        read filename

        # Prompt for a password
        echo "Enter a password for the ZIP file:"
        read -s password

        # Save user information to a temporary text file
        temp_file="temp_info.txt"
        echo "Name: $name" > "$temp_file"
        echo "Age: $age" >> "$temp_file"
        echo "Date of Birth: $dob" >> "$temp_file"
        echo "NID: $nid" >> "$temp_file"
        echo "Color: $color" >> "$temp_file"

        # Create a password-protected ZIP file
        zip --encrypt --password "$password" "${filename}.zip" "$temp_file"

        # Remove the temporary text file
        rm "$temp_file"

        echo "Information saved to ${filename}.zip (password-protected)."
        ;;
    *)
        echo "Information not saved."
        ;;
esac

