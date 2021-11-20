#!/usr/bin/python3

"""
Compute Average Request Time

Take into account that the data is collected when the system is under stress.

This scipt is used to parse data from a log file and
extract relevant information such as:
    - Response times ~ Overall time user waits for response (latency)
    - Thinking times ~ Time spent for user decision (here symulated by some prints, therefore negligable)
    - Travel times   ~ Time spent over the network
    - Work Times     ~ Time spent on workload
"""

import sys
import csv

if len(sys.argv) != 2:
    print("usage: compute_avg_request_time.py <path_to_log>")
    exit(1)

# Compute the average
def Average(lst):
    return sum(lst) / len(lst)

# Time for overall request
response_times = []
# Time spent for user decision (here symulated by some prints, therefore negligable)
thinking_times = []
# Time spent without work loads
travel_times = []
# Time spent on work loads
work_times = []

# Parse the CSV log file
with open(sys.argv[1], newline='\n') as csvfile:
    spamreader = csv.reader(csvfile, delimiter=',')
    for row in spamreader:
        # This is needed in order to ingore the DOWN logs
        if len(row) > 5:
            response_times.append(int(row[4]))
            work_times.append(int(row[5]))
            # Based on logs, safe tu asusme that travel time >> work time for this system. No need for abs
            travel_times.append(int(row[4]) - int(row[5]))
            thinking_times.append(int(row[4]) - int(float(row[6])))

# Compute the average response time / request (s)
print('Serving: ' + str(len(response_times)) + ' requests')
print('Average: ' + str(Average(response_times) * 0.001) + " seconds/request")
print('Average thinking time: ' + str(Average(thinking_times) * 0.001) + " seconds/request")
print('Average working time: ' + str(Average(work_times) * 0.001) + " seconds/request")
print('Average travel time: ' + str(Average(travel_times) * 0.001) + " seconds/request")
