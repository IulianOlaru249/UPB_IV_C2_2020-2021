#!/usr/bin/python3

"""
Source IP Hash

Source IP Hash load balancing uses an algorithm that takes the source and destination IP address
of the client and server to generate a unique hash key. This key is used to allocate the client to
a particular server. As the key can be regenerated if the session is broken, this method of load balancing
can ensure that the client is directed to the same server that it was using previously. This is useful if
it’s important that a client should connect to a session that is still active after a disconnection and reconnection.

NOTE: in order to mock diffrent IPs for diffrent clients, the thread (a.k.a. client) ID will be appended to the source IP.

This symulates a Least-Connection load balancer processing batches on N requests
sent by 1000 concurrent clients (threads)

Data is saved in logs just like stress_test.py

@cli_param: N = number of requests to be sent by each user
"""

import sys
from threading import Thread
import requests
import socket

if len(sys.argv) != 2:
    print("usage: source_ip_hash.py <N>")
    exit(1)

batch_size = int(sys.argv[1])

# Pool of URLs of worker servers with weights and connections.
url_pool = ['http://0.0.0.0:5000/work/emea/0',
        'http://0.0.0.0:5000/work/us/0'      ,
        'http://0.0.0.0:5000/work/us/1'      ,
        'http://0.0.0.0:5000/work/asia/0'    ,
        'http://0.0.0.0:5000/work/asia/1'    ]


# Implementation on Round Robin balancer
class SourceIPHash ():
    def __init__(self, pool):
        self.pool = pool
        # Hashes mapped to the servers IPs
        ## NOTE: this implementation is limited, because the map can blow up in proportions
        ## with a high volume of clients. This cluld be solved by capping the size this map can have.
        self.ip_table = {}

    # Select a server from the pool
    def get(self, thread_id):
        # Get host source IP
        hostname = socket.gethostname()
        # Append the thread ID as mentioned in the algo description (see line 4)    
        source_ip_addr = socket.gethostbyname(hostname) + str(thread_id)
        # Compute hash key
        hash_key = hash(self.pool[thread_id % len(self.pool)] + str(source_ip_addr))
        # If new client
        if hash_key not in self.ip_table:
            self.ip_table[hash_key] = self.pool[thread_id % len(self.pool)]
        
        return self.ip_table[hash_key]

# Threads, aka clients doing requests in parallel
class myThread (Thread):
    def __init__(self, threadID, requestsNo):
        Thread.__init__(self)
        self.threadID = threadID
        self.requestsNo = requestsNo

    def run(self):
        # for i in range(self.requestsNo):
            # print(source_ip_hash.get(self.threadID))
        send(self.threadID, self.requestsNo)

# Send http requests
def send(threadID, requestsNo):
    # Send the specified number of requests
    for i in range(requestsNo):
        # Send HTTP GET
        try:
            url = source_ip_hash.get(threadID)
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

source_ip_hash = SourceIPHash(url_pool)
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
