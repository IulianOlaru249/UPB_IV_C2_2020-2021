#!/usr/bin/python3

"""
Weighted Round Robin

The weighted round-robin scheduling is designed to better handle servers with different processing capacities.
Each server is assigned a weight (an integer value that indicates the processing capacity).
Servers with higher weights receive new connections before those with less weights and servers with higher
weights get more connections than those with less weights.

This symulates a Weighted Round Robin load balancer processing batches on N requests
sent by 1000 concurrent clients (threads)

Data is saved in logs just like stress_test.py

@cli_param: N = number of requests to be sent by each user

"""

import sys
from threading import Thread, Lock
import requests
import fractions
from functools import reduce

if len(sys.argv) != 2:
    print("usage: weighted_round_robin.py <N>")
    exit(1)

batch_size = int(sys.argv[1])

# Pool of URLs of worker servers with weights.
## The weights have been assigned based on the 
## number of requests that can be handlel by a single 
## machine. (Percentage based). See README.
url_pool = [('http://0.0.0.0:5000/work/emea/0' ,20),
        ('http://0.0.0.0:5000/work/us/0'       ,19),
        ('http://0.0.0.0:5000/work/us/1'       ,18),
        ('http://0.0.0.0:5000/work/asia/0'     ,21),
        ('http://0.0.0.0:5000/work/asia/1'     ,22)]

# Implementation on Round Robin balancer
class WeightedRoundRobin ():
    def __init__(self, max_weight, total_weight, current_weight, index, pool):
        self.max_weight = max_weight
        self.total_weight = total_weight
        self.current_weight = current_weight
        self.index = index
        self.pool = pool
        self.pool_size = len(pool)
        # Get gcd of weights
        self.gcd_s =  reduce(fractions.gcd, [ weight for data, weight in pool])

    # Select a server from the pool
    def get(self):
        while True:
            # Increment index
            self.index = (self.index + 1) % self.pool_size
            if self.index == 0:
                # Compute current weight by 
                self.current_weight = self.current_weight - self.gcd_s
                if self.current_weight <= 0:
                    self.current_weight = self.max_weight
                    # Not good enough; keep looking
                    if self.current_weight == 0:
                        return None
            # Return the better option
            if self.pool[self.index][1] >= self.current_weight:
                return self.pool[self.index]

# Threads, aka clients doing requests in parallel
class myThread (Thread):
    def __init__(self, threadID, requestsNo):
        Thread.__init__(self)
        self.threadID = threadID
        self.requestsNo = requestsNo

    def run(self):
        send(self.threadID, self.requestsNo)

# Send http requests
def send(threadID, requestsNo):
    # Send the specified number of requests
    for i in range(requestsNo):
        # Send HTTP GET
        try:
            url = robin.get()[0]
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

# max_weight, total_weight, current_weight, index, pool)
robin = WeightedRoundRobin(24, 100, 20, 0, url_pool)
# Create new threads
threads = []
for i in range(100):
    threads.append(myThread(i, batch_size))

# Start new Threads
for my_thread in threads:
    my_thread.start()

# Join threads
for my_thread in threads:
    my_thread.join()
