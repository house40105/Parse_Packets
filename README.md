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


#### Periodically Connect to API and Log the Results  
**File name: API_Connection_for_log.pl**  

#### Bash Script to Query the MySQL Database  
**File name: Search.sh**  
