package main

import (
	"bufio"   // Package for buffered I/O (reading files line by line)
	"bytes"   // Package for byte slice operations (byte comparison function)
	"fmt"     // Package for formatted I/O (console output)
	"net"     // Package for network primitives (working with IP addresses)
	"os"      // Package for operating system interaction (opening/creating files)
	"regexp"  // Package for regular expressions
	"sort"    // Package providing sorting primitives
	"strconv" // Package for conversions to and from string representations
)

// readLines opens the file, reads it line by line, and parses each line
func readLines(path string) ([]LogLine, error) {
	// Open the file for reading
	file, err := os.Open(path)
	if err != nil {
		return nil, err // Return the error if the file is missing or restricted
	}
	// defer guarantees that the file will close automatically when readLines exits
	defer file.Close()

	var lines []LogLine // Create an empty slice to store our structures

	// Regular expression with capture groups (parentheses):
	// Group 1: `([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3})` — matches IPv4
	// Separator `:` — colon between IP and port
	// Group 2: `([0-9]+)` — matches consecutive digits of the port
	re := regexp.MustCompile(`\b([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}):([0-9]+)\b`)

	// Scanner allows memory-efficient, line-by-line file reading
	scanner := bufio.NewScanner(file)
	for scanner.Scan() {
		text := scanner.Text() // Get the current line as a string
		if text == "" {
			continue // Skip empty lines if any
		}

		// FindStringSubmatch searches for regex matches.
		// Returns a slice of strings: [0] - full match, [1] - first group (IP), [2] - second group (port)
		matches := re.FindStringSubmatch(text)

		var ip net.IP
		var port int

		// Verify that the regex found both IP and port (matches slice length must be 3)
		if len(matches) == 3 {
			// Parse the IP string into the specialized net.IP type
			parsedIP := net.ParseIP(matches[1])
			if parsedIP != nil {
				// .To4() converts the IP to a 4-byte representation. This is critical,
				// otherwise bytes.Compare may fail (Go stores IPv4 as 16 bytes by default)
				ip = parsedIP.To4()
			}

			// Convert the port string (e.g., "8080") to a standard integer (int)
			if parsedPort, err := strconv.Atoi(matches[2]); err == nil {
				port = parsedPort
			}
		}

		// Append the created structure to our main slice
		lines = append(lines, LogLine{
			Raw:  []byte(text), // Convert the string to a byte slice for preservation
			IP:   ip,
			Port: port,
		})
	}

	// Check for any errors that occurred during the scanning process (e.g., disk failure)
	return lines, scanner.Err()
}

// writeLines takes a slice of structures and writes them sequentially to a file
func writeLines(path string, lines []LogLine) error {
	// Create (or overwrite) the file to save the result
	file, err := os.Create(path)
	if err != nil {
		return err
	}
	defer file.Close()

	// Use a buffered writer to accelerate disk operations
	writer := bufio.NewWriter(file)
	for _, line := range lines {
		// Write the original line to the file
		_, err := writer.Write(line.Raw)
		if err != nil {
			return err
		}
		// Add a newline character since scanner.Text() stripped it during reading
		_, err = writer.Write([]byte{'\n'})
		if err != nil {
			return err
		}
	}
	// Flush any remaining data from the RAM buffer directly to the disk
	return writer.Flush()
}

// LogLine represents a structure that bundles the raw line string and the
// parsed data extracted for subsequent sorting.
type LogLine struct {
	Raw  []byte // Original line from the file, stored as a byte slice to optimize memory
	IP   net.IP // Extracted IP address (net.IP is internally a byte slice)
	Port int    // Extracted port as an integer (for proper numerical sorting)
}

func main() {
	inputPath := "input.txt"   // Path to the source data file
	outputPath := "output.txt" // Path to the file where the sorted result will be written

	// 1. Call the function to read and parse the file
	lines, err := readLines(inputPath)
	if err != nil {
		fmt.Printf("Error reading file: %v\n", err)
		return // Terminate execution if the file could not be read
	}

	// 2. Sort the slice of LogLine structures using sort.Slice
	// The comparator function (second argument) determines which element should come first
	sort.Slice(lines, func(i, j int) bool {
		// bytes.Compare compares the bytes of two IP addresses.
		// Returns: -1 if i < j, 1 if i > j, and 0 if they are equal.
		ipCompare := bytes.Compare(lines[i].IP, lines[j].IP)

		// If the IP addresses are NOT equal, sort strictly by IP (ascending)
		if ipCompare != 0 {
			return ipCompare < 0 // Returns true if the IP at index i is less than at index j
		}

		// If the IP addresses are identical (ipCompare == 0), the fallback condition applies:
		// sort ports in ascending order (smaller port goes higher)
		return lines[i].Port < lines[j].Port
	})

	// 3. Write the sorted data back to the disk
	if err := writeLines(outputPath, lines); err != nil {
		fmt.Printf("Error writing file: %v\n", err)
		return // Terminate execution in case of a write error
	}

	fmt.Println("File successfully sorted by IP and ports in ascending order!")
}
