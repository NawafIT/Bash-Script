#!/bin/bash

# Define variables
userName=""
groupName=""

# Function to ask the user for their username
ask_username() {
  # Display a message to the user
  echo "Enter your name as user: "

  # Read the username
  read userName

  # Check if the username is empty
  if [ -z "$userName" ]; then
    # Display an error message
    echo "Username cannot be empty."

    # Call the ask_username function again
    ask_username
  else
    echo "Creating with name: $userName"
  fi
}

# Function to ask for password
password() {
  # Display message to user
  echo "Enter your password (8 characters at least): "

  # Read password
  read pass

  # Check password length
  if [ ${#pass} -ge 8 ]; then

    # Display confirmation message for password
    echo "Your password is strong! Nice work."
    
  else
    # Display error message
    echo "Your password is too short. Please try again."
    # Call password function again
    password
  fi
}

ask_username
password

useradd "$userName"
echo "$userName:$pass" | chpasswd

# Function to ask the user for their group name
create_group() {
  # Display a message to the user
  # Read the group name
  read -p "Enter the default group name: " groupName

  # Check if the group name is empty
  if [ -z "$groupName" ]; then
    # Display an error message
    echo "Group name cannot be empty."

    # Call the ask_groupname function again
    create_group
  fi
  usermod -aG "$groupName" "$userName"
  if[ $? -ne 0 ]; then
      echo "Error happened try again"
      exit 1
  fi
}

create_group

# Function to create a user
confirm_user() {

  read -p "Do you want to crate the user? y/n:" confirm
  fi [ "$confirm" == "y" ]; then 
      echo "user created"
  else 
      userdel -r "$userName"
  fi
}

confirm_user


