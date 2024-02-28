#!/bin/bash
<<doc
Name:Saran
Date:
Description:
Sample Input:
Sample Output:
doc

function option()
{
  echo -e "\e[1;96m1.SIGN UP\n2.SIGN IN\n3.EXIT\e[0m"
  read -p "Enter the Option: " ch
}

function sign_up()
{
  read -p "Enter Username : " username
  user_arr=(`cat user_name.csv`)
  
  for i in ${user_name[@]}
  do
    if [ "${user_arr[i]}" = "$username" ]
    then
    echo -e "Username is already exists.Please try different username."
    sign_up
    return    
    fi

  done
  
  read -sp "Enter password: " password
  echo
  read -sp "Confirm password: " cpassword
  
  if [ "$password" != "$cpassword" ]
  then
    echo "Error: Passwords do not match."
    sign_up
  return
  fi
  
  echo "$username"  >> user_name.csv
  echo "$password" >> password.csv
  
  echo "Sign up Successfully."

  option

  
}

function sign_in()
{
  read -p "Enter Username: " username
  user_arr=(`cat user_name.csv`)
  password_arr=(`cat password.csv`)

  for i in "${user_arr[@]}"
  do
   if [ "${user_arr[i]}" = "$password" ]
   then
      echo -sp "Enter password: " password
      echo
      if [ "${password_arr[i]}" = "$password" ]
        then
        echo "Sign in Successfully."
        conduct_test
        return
   else
      echo "Error: Incorrect password."
      sign_in  
      return
     fi
   fi
  done

  echo "Error: User not found."
  sign_in

}

function conduct_test()
{
   questions=(`cat question.csv`)
   correct_answers=(`cat correct_ans.csv`)
   user_answers=()

  echo "Test Conduction :"
  echo



}




