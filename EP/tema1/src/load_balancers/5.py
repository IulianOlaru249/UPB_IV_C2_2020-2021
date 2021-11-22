#!/usr/bin/python3

"""
Least-Connection

This method directs traffic to the server with the fewest active connections.
This approach is quite useful when there are a large number of persistent client
connections which are unevenly distributed between the servers.

This symulates a Least-Connection load balancer processing batches on N requests
sent by 1000 concurrent clients (threads)

Data is saved in logs just like stress_test.py

@cli_param: N = number of requests to be sent by each user
"""

import sys
from threading import Thread, Lock
import requests
from functools import reduce

if len(sys.argv) != 2:
    print("usage: weighted_round_robin.py <N>")
    exit(1)

batch_size = int(sys.argv[1])

# Pool of URLs of worker servers with weights and connections.
## The weights have been assigned based on the 
## number of requests that can be handlel by a single 
## machine. (Percentage based). The connection number is mocked. See README.
url_pool = [('http://0.0.0.0:5000/work/emea/0' ,20, 10),
        ('http://0.0.0.0:5000/work/us/0'       ,19, 12),
        ('http://0.0.0.0:5000/work/us/1'       ,18, 14),
        ('http://0.0.0.0:5000/work/asia/0'     ,21, 20),
        ('http://0.0.0.0:5000/work/asia/1'     ,22, 9)]

# Implementation on Round Robin balancer
class LeastConnection ():
    def __init__(self, pool):
        self.pool = pool

    # Select a server from the pool
    def get(self):
        test(self.pool)

# Threads, aka clients doing requests in parallel
class myThread (Thread):
    def __init__(self, threadID, requestsNo):
        Thread.__init__(self)
        self.threadID = threadID
        self.requestsNo = requestsNo

    def run(self):
        for i in range(self.requestsNo):
            print(least_connection.get())
        #send(self.threadID, self.requestsNo)

def test(pool):
    return None

# Send http requests
def send(threadID, requestsNo):
    # Send the specified number of requests
    for i in range(requestsNo):
        # Send HTTP GET
        try:
            url = least_connection.get()[0]
            r = requests.get(url = url)
            r.raise_for_status()  # Raises a HTTPError if the status is 4xx, 5xxx
        except (requests.exceptions.ConnectionError, requests.exceptions.Timeout):
            print ("DOWN. " + url + "Thread " + str(threadID) + '. Requests sent: ' + str(i))
            return
        except requests.exceptions.HTTPError:
            print ("DOWN. 4xx, 5xx. Thread " + str(threadID) + '. Requests sent: ' + str(i))
            return
        else:
            # Extract data in json format
            data = r.json()

            # Present data
            ## NOTE: that +1 in the end is a mock because: 
            #   - I wouldn't have to change the compute_avg_request_time.py script
            ##  - thinking time is not important for this
            print(data['machine'] + "," + data['region']  + ',' + str(threadID) + "," + str(i + 1) + "," + str(data['response_time']) + "," + str(data['work_time']) + ',1', end='\n')

least_connection = LeastConnection(url_pool)
# Create new threads
threads = []
for i in range(1):
    threads.append(myThread(i, batch_size))

# Start new Threads
for my_thread in threads:
    my_thread.start()

# Join threads
for my_thread in threads:
    my_thread.join()
