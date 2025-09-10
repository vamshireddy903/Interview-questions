#!/bin/bash

echo "========== Welcome to Calculator =========="
echo "--------------------------------------------"

echo -e "[aA]Addition\n[bB]Substration\n[cC]Multiplication\n[dD]Division\n"

read -p "Enter your choice: " choice

case $choice in
        [aA])
                read -p "Enter first number: " num1
                read -p "Enter second number: " num2
                result=$((num1+num2))
                echo "The Addition  result is: $result"
                ;;
        [bB])
                read -p "Enter first number: " num1
                read -p "Enter second number: " num2
                result1=$((num1-num2))
                echo "The Substraction  result is: $result1"
                ;;
       [cC])
                read -p "Enter first number: " num1
                read -p "Enter second number: " num2
                result2=$((num1*num2))
                echo "The Multiplication result is: $result2"
                ;;
        [dD])
                read -p "Enter first number: " num1
                read -p "Enter second number: " num2
                result3=$((num1/num2))
                echo "The Division  result is: $result3"
                ;;
        *)
                echo " Please select a valid choice"
esac
