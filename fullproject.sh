#!/bin/bash
<<doc
Name:Saran
Date:05 JULY 2023
Description:
Sample Input:
Sample Output:
doc

function options()
 {
    echo -e "\e[96mSelect the option: "
    echo -e "1.Sign up"
    echo -e  "2.Sign in"
    echo -e "3.Exit\e[0m"
}


function sign_up() 

{
    read -p "Enter username: " username
    user_arr=(`cat user_name.csv`)

    for i in "${user_arr[@]}"
    do
        if [ "${user_arr[i]}" = "$username" ]
        then
            echo -e "\e[91;5mError: Username already exists. Please try different username.\e[27m\e[0m"
            sign_up
            return
        fi
    done

    read -sp "Enter password: " password
    echo
    read -sp "Confirm password: " c_password
    echo

    if [ "$password" != "$c_password" ]
    then
        echo -e "\e[91;5mError: Passwords do not match.\e[27m\e[0m"
        sign_up
        return
    fi

    echo "$username" >> user_name.csv
    echo "$password" >> password.csv

    echo -e "\e[92mSign up successful.\e[0m"
    options
}


function sign_in() 
{
    read -p "Enter username: " username
    user_arr=(`cat user_name.csv`)
    password_arr=(`cat password.csv`)

    for i in "${user_arr[@]}"
    do
        if [ "${user_arr[i]}" = "$username" ]
        then
            read -sp "Enter password: " password
            echo
            if [ "${password_arr[i]}" = "$password" ]
            then
                echo -e "\e[92mSign in successful.\e[0m"
                conduct_test
                return
            else
            
            
                echo -e "\e[91;5mError: Incorrect password.\e[0m"
                sign_in
                return
            fi
        fi
    done

    echo -e "\e[91;5mError: User not found.\e[0m"
    sign_in
}

function conduct_test() 
{
 
      echo -n > useranswer.csv
     for l in `seq 5 5 50`
      do
  	head -$l question.csv | tail -5
	f=0
        for m in `seq 10 -1 0`
	do
	echo -ne "\r\e[41mEnter the answer in $m \e[0m "
	read -t 1 ans
	if [ -n "$ans" ]
	then
        f=1
	echo "$ans" >> useranswer.csv
	break
	else
	   ans="e"
	fi
	done
	
	if [ $f -eq 0 ]
	then
	  echo "e" >> useranswer.csv
	fi
	done
						
	  user_answer=(`cat useranswer.csv`)
	  correct_answer=(`cat correct_ans.csv`)
	  mark=0
	  for n in $(seq 1 10)
	  do
	     head -$((5*n)) question.csv | tail -5
	     
	  if [ "${user_answer[$n-1]}" = "${correct_answer[$n-1]}" ]
	  then
	       echo -e "\e[34mCORRECT_ANSWER\n\e[0mYour_answer: \e[0m${user_answer[$n-1]}"
	       mark=$((mark+1))
	       elif [ "${user_answer[$n-1]}" = "e" ]
	       then
		    echo -e "\e[0mTIMED_OUT\n\e[0mCORRECT_ANSWER: \e[0m${correct_answer[$n-1]}"
		else
		     echo -e "\e[91mWrong_answer\e[0m\n\e[92mCorrect_answer: \e[0m${correct_answer[$n-1]}"
		fi
		   done
		echo -e "\e[101mMarks obtained: $mark/10\e[0m"
  
}



options

while true
do
    read -p "Enter the choice: " ch

    case $ch in
        1)
            sign_up
            ;;
        2)
            sign_in
            ;;
        3)
            echo -e "\e[40;38;5;82mExiting\e[30;48;5;82m....\e[0m"
            exit 0
            ;;
        *)
            echo -e "\e[40;38;5;82mInvalid choice.\e[30;48;5;82m Please try again.\e[0m"
            ;;
    esac
done
