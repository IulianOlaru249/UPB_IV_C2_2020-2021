#!/usr/bin/python3

"""
Least-Connection

This method directs traffic to a random server.

This symulates a Least-Connection load balancer processing batches on N requests
sent by 1000 concurrent clients (threads)

Data is saved in logs just like stress_test.py

@cli_param: N = number of requests to be sent by each user
"""

import sys
from threading import Thread
import requests
import random

if len(sys.argv) != 2:
    print("usage: random_load.py <N>")
    exit(1)

batch_size = int(sys.argv[1])

# Pool of URLs of worker servers with weights and connections.
## The weights have been assigned based on the 
## number of requests that can be handlel by a single 
## machine. (Percentage based). The connection number is mocked. See README.
url_pool = ['http://0.0.0.0:5000/work/emea/0' ,
        'http://0.0.0.0:5000/work/us/0'       ,
        'http://0.0.0.0:5000/work/us/1'       ,
        'http://0.0.0.0:5000/work/asia/0'     ,
        'http://0.0.0.0:5000/work/asia/1'     ]

# Implementation on Round Robin balancer
class RandomLoad ():
    def __init__(self, pool):
        self.pool = pool

    # Select a server from the pool
    def get(self):
        # Harnessing the raw power and wisdom of the python random number generator.
        return self.pool[random.randint(0, len(self.pool) - 1)]

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
            url = random_load.get()
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

random_load = RandomLoad(url_pool)
# Create new threads
threads = []
for i in range(500):
    threads.append(myThread(i, batch_size))

# Start new Threads
for my_thread in threads:
    my_thread.start()

# Join threads
for my_thread in threads:
    my_thread.join()
