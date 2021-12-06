#!/usr/bin/python3

"""
Round Robin

This method cycles through a list of servers and sends each new request to the next server.
When it reaches the end of the list, it starts over at the beginning.
It is most useful when the servers are of equal specification and there are not
many persistent connections.

This symulates a Round Robin load balancer processing batches on N requests
sent by 1000 concurrent clients (threads)

Data is saved in logs just like stress_test.py

@cli_param: N = number of requests to be sent by each user

"""

import sys
from threading import Thread, Lock
import requests

if len(sys.argv) != 2:
    print("usage: round_robin.py <N>")
    exit(1)

batch_size = int(sys.argv[1])

# Pool of URLs of worker servers
url_pool = ['http://0.0.0.0:5000/work/emea/0',
        'http://0.0.0.0:5000/work/us/0',
        'http://0.0.0.0:5000/work/us/1',
        'http://0.0.0.0:5000/work/asia/0',
        'http://0.0.0.0:5000/work/asia/1']

# Implementation on Round Robin balancer
class RoundRobin ():
    def __init__(self, current, pool, mutex):
        self.current = current
        self.pool = pool
        self.mutex = mutex
    # Select a server from the pool
    def get(self):
        self.mutex.acquire()
        try:
            if self.current >= len(self.pool):
                self.current = self.current % len(self.pool)
            result = self.pool[self.current]
            self.current += 1
            return result
        finally:
            self.mutex.release()

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
            url = robin.get()
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
            print(data['machine'] + "," + data['region']  + ',' + str(threadID) + "," + str(i + 1) + "," + str(data['response_time']) + "," + str(data['work_time']) + ',1')

# Initiate lock and round robin balancer
mutex = Lock()
robin = RoundRobin(0, url_pool, mutex)
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
