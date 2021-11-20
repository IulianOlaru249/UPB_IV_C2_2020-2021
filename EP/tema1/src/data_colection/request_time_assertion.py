#!/usr/bin/python3

"""
Request Time Assertion

This is used to plot some data about each machine's latency and work time,
over a period of N back to back requests.
"""

import sys
import requests
import numpy as np
import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt
import warnings
from datetime import datetime

warnings.filterwarnings('ignore')

# URL for the router deployment
base_url = "http://0.0.0.0:5000"

# Handle command line params
if len(sys.argv) != 4:
    print("usage: request_time_assertion.py <N> <region> <machine>")
    exit(1)
N = int(sys.argv[1])
region = str(sys.argv[2])
machine = str(sys.argv[3])

# Compute URL for request
work_url = base_url + "/work/" + region + "/" + machine


work_time_data = []
response_time_data = []
request_no = []
# Send the specified number of requests
for i in range(N):
    # Send HTTP GET
    r = requests.get(url = work_url)
  
    # Extract data in json format
    data = r.json()

    # Save data
    work_time_data.append(data['work_time'])
    response_time_data.append(data['response_time'])
    request_no.append(i + 1)

    # Present data
    print("Request " + str(i + 1) + ": Machine < " + data['machine'] + " > from < " + data['region'] +" >: Response Time:" +
        str(data['response_time']) + "; Work Time:" + str(data['work_time']) + ".")


# Plot the data

# Creating our own dataframe
data = {"Response Time": response_time_data,
        "Work Time" : work_time_data,
        "Request No": request_no}
 
# Convert this dictionary type data into a pandas dataframe
df = pd.DataFrame(data, columns=['Request No', 'Response Time', 'Work Time'])

# Reshape data frame
df = pd.melt(df, id_vars="Request No", var_name="Work Time", value_name="Response Time")

# Defining the plot aspect
plt.figure(figsize=(8, 8))
plt.yticks(np.arange(0, max(response_time_data), 15))
plt.xticks(np.arange(1, len(response_time_data)+1, 1))
plt.gcf().set_size_inches(16, 7)
plt.title("Response Time & Work Time / request for " + region + ":" + machine)
plt.xlabel("Request No.", size=14)
plt.ylabel("Time (ms)", size=14)

plots = sns.barplot(x='Request No', y='Response Time', hue='Work Time', data=df)

# Iterrating over the bars one-by-one
for bar in plots.patches:
    plots.annotate(format(bar.get_height(), '.2f'),
        (bar.get_x() + bar.get_width() / 2,
        bar.get_height()), ha='center', va='center',
        size=15, xytext=(0, 8),
        textcoords='offset points')
 
# plt.show()
plt.savefig('../data/Response_Time_And_Work_Time_Per_Request_'+ region + '_' + machine + '_' + datetime.today().strftime('%Y_%m_%d') + '.png')
