#!/bin/bash

echo "Installing Git..."
echo "Installation started"

# Check if the OS is Linux
if [ "$(uname)" = "Linux" ]; then
    echo "This is a Linux box"

    # Check if Git is already installed
    if command -v git &> /dev/null; then
        echo "Git is already installed"
        git --version

    # Check for yum package manager (RHEL/CentOS/Fedora)
    elif command -v yum &> /dev/null; then
        echo "Detected yum (RHEL/CentOS/Fedora)"
        sudo yum update -y
        sudo yum install git -y
        git --version

    # Check for apt package manager (Ubuntu/Debian)
    elif command -v apt &> /dev/null; then
        echo "Detected apt (Ubuntu/Debian)"
        sudo apt update -y
        sudo apt install git -y
        git --version

    else
        echo "No supported package manager found"
    fi

else
    echo "Git installation is not supported on this OS"
fi
