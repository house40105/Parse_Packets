# Parse_Packets

We need to implement the following functionalities:  

1. Write a Perl script to parse packets and insert the packet data into the MySQL database.
2. Write an HTTP API (in JSON format) using Perl to confirm the MySQL connection.  
3. Write a Perl script that periodically connects to the above HTTP API and logs the results.  
4. Write a Bash script to query and retrieve data from the MySQL database.  
 
Below is a summary of each functionality along with the organized example code:  

#### Process in Perl for Packet Analysis  
**File name: Parse_Packets.pl**  
We create a data table called 'packets' with columns such as source_ip, destination_ip, protocol, and length in MySQL firstlly. We use the 'parse_packet' function to parse the offline packet data into the corresponding information, and then insert the parsed data into the database table.  

#### API in Perl to Confirm MySQL Connection  
**File name: Check_Connection.pl**  
Check_Connection.pl demonstrates how to use Perl to write an HTTP API that confirms the status of a MySQL connection. The '/check_connection' route handles GET requests and checks the status of the MySQL connection. Depending on whether the connection is successful or not, it returns a JSON response indicating the status of the connection.  

When launching the application, use the '-l' parameter to specify the IP address as your ip address and the port as 8000. This will make the API listen on that specific IP and port. Then, we can use a browser or an API testing tool on another device to send a GET request to "http://your_ip_sdderss:your_port/check_connection" to check the status of the MySQL connection.  

If the MySQL connection is successful, the API response will be a JSON-formatted string containing the 'status' field with the value 'Connection successful'. An example response is as follows:  
```json
{"status": "Connection successful"}
```  
If there is an error with the MySQL connection, the API response will be a JSON-formatted string containing the 'status' field with the value 'Connection error'. An example response is as follows:  
```json
{"status": "Connection error"}
```  


#### Periodically Connect to API and Log the Results  
**File name: API_Connection_for_log.pl**  
In  API_Connection_for_log.pl, we use the LWP::UserAgent module to send an HTTP GET request to the API and the Log::Log4perl module to log the results into a log file.  

We schedule the task using crontab to execute the API request at regular intervals and log the results to the log file. You can adjust the interval of the timer according to your requirements.  

Alternatively, you can set up a timer using the AnyEvent module in your code.  

#### Bash Script to Query the MySQL Database  
**File name: Search.sh**  
We use a bash script to execute MySQL queries and retrieve data from the mysql database. For this purpose, you can utilize the mysql command-line tool and incorporate variables and control flow statements within the bash script.

In Search.sh, we modify the configuration for connecting to the MySQL database and the query statement according to specific situation. The script uses the mysql command-line tool to connect to the MySQL database and execute the specified query statement.

By using the $? variable, we can check the exit status of the previous command. If the query execution is successful, the exit status will be 0, and we will output the query result. If the query fails, the exit status will be non-zero, and we will print an error message.  

Please note that you can expand and modify the script according to your specific needs. Also, ensure that you have installed the mysql command-line tool and have the appropriate permissions to access the database before running the script.
