#!/bin/bash

##### Search.pl
#
# Version 1.0: 用 bash 寫一個 MYSQL 查詢資料庫資料
#
#####

# 配置MySQL連線
DB_HOST="localhost"
DB_USER="user"
DB_PASS="User40105"
DB_NAME="mydatabase"

# Function to display search menu
function search_menu {
  echo "Please select a search option:"
  echo "1. Print All Result"
  echo "2. Search by Protocol Number"
  echo "3. Quit"
  read -p "Enter your choice: " choice
}

# Function to print all data
function print_all {
    #查詢
    query="SELECT * FROM packets;"
    result=$(mysql -h $DB_HOST -u $DB_USER -p$DB_PASS -D $DB_NAME -e "$query")

    #確認查詢結果
    if [ $? -eq 0 ]; then
    # 查詢成功，輸出
    echo "$result"
    else
    # 查詢錯誤，輸出錯誤
    echo "MySQL query failed."
    fi
}

# Function to search by protocol
function search_by_protocol {

    read -p "Enter protocol number (TCP:6, UDP:17, ICMP:1): " protocol_number
    query="SELECT * FROM packets WHERE protocol=${protocol_number};"
    #echo $query
    result=$(mysql -h $DB_HOST -u $DB_USER -p$DB_PASS -D $DB_NAME -e "$query")

    #確認查詢結果
    if [ $? -eq 0 ]; then
    # 查詢成功，輸出
    echo "$result"
    else
    # 查詢錯誤，輸出錯誤
    echo "MySQL query failed."
    fi

}

# Main loop for search menu
while true
do
  search_menu
  case $choice in
    1) print_all ;;
    2) search_by_protocol ;;
    3) exit ;;
    *) echo "Invalid choice. Please try again." ;;
  esac
done





