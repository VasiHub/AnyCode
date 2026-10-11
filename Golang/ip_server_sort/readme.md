
# Program Description

Title: Go-based Server IP Address and Port Sorting Utility.

Description:
This program is designed for efficient processing and sorting of text-based log files or lists containing network sockets formatted as IP:port.
It reads data from an input.txt file, orders the entries, and writes the sorted output to output.txt.

Key Features & Workflow:

* Line-by-Line Reading (bufio.Scanner): The program is optimized for processing large files because it reads data line by line,
  preventing high RAM consumption.
 
* Regex-based Parsing (regexp): It utilizes regular expressions to isolate valid IPv4 addresses and their corresponding port numbers from each line.
 
* Memory Optimization: Original text lines are kept as byte slices ([]byte) to minimize overhead and reduce garbage collection (GC) pressure in Go.
 
* Two-Tier Sorting Logic (sort.Slice):
 
	1. Primary criteria: Sorts by IP address in ascending order. IPv4 addresses are explicitly forced into a 4-byte format (.To4()) to ensure
  byte-by-byte comparison yields mathematically correct results.

    2. Secondary criteria: If the IP addresses are identical, the program evaluates the ports as integers. As a result, lines with matching
  IPs are sorted by port number in ascending order.

* Buffered Writing: The final sorted array is written back to the disk via bufio.Writer, minimizing system calls and boosting I/O performance.
