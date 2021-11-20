#!/usr/bin/python3

"""
Stress Test

This is used to generate artiaficial requests for each machine in the system.
M threads are created to symulate M clients using the machine in parallel.
Each client sends N requests back to back, on a targeted machine.

Data is gathered after each request and stored in a log file (csv) :

<Machine ID>, <Region>, <Thread ID (aka client ID)>, <Requent count>, <Response time>, <Work time>, <Thinking time>


Take into account that the data is collected when the system is under stress.
"""

import sys
import requests
import threading
import time

# URL for the router deployment
base_url = "http://0.0.0.0:5000"

# Handle command line params
if len(sys.argv) != 5:
    print("usage: stress_test.py <thread number> <request number> <region> <machine>")
    exit(1)

thread_no = int(sys.argv[1])
N = int(sys.argv[2])
region = str(sys.argv[3])
machine = str(sys.argv[4])

# Compute URL for request
work_url = base_url + "/work/" + region + "/" + machine

exitFlag = 0

class myThread (threading.Thread):
    def __init__(self, threadID, requestsNo):
        threading.Thread.__init__(self)
        self.threadID = threadID
        self.requestsNo = requestsNo

    def run(self):
        print_time(self.threadID, self.requestsNo)

def print_time(threadID, requestsNo):
    # Send the specified number of requests
    for i in range(requestsNo):
        start = time.time()
        # Send HTTP GET
        try:
            r = requests.get(url = work_url)
            r.raise_for_status()  # Raises a HTTPError if the status is 4xx, 5xxx
        except (requests.exceptions.ConnectionError, requests.exceptions.Timeout):
            print ("DOWN. Thread " + str(threadID) + '. Requests sent: ' + str(i))
            return
        except requests.exceptions.HTTPError:
            print ("DOWN. 4xx, 5xx. Thread " + str(threadID) + '. Requests sent: ' + str(i))
            return
        else:
            # Extract data in json format
            data = r.json()

            # Present data
            print(data['machine'] + "," + data['region']  + ',' + str(threadID) + "," + str(i + 1) + "," + str(data['response_time']) + "," + str(data['work_time']), end =",")
                        
            # Stop request timer
            end = time.time()

            # NOTE: This is meant to pe concatentated to the previous print. Not syncronized tough. Some prints might screw up. 
            #       Happens rarely tough and I don't really want to worry about sync-ing the threads. Prefer to fix log by hand.
            print(data['response_time'] - (end - start))

# Create new threads
threads = []
for i in range(thread_no):
    threads.append(myThread(i, N))

# Start new Threads
for my_thread in threads:
    my_thread.start()

# Join threads
for my_thread in threads:
    my_thread.join()
