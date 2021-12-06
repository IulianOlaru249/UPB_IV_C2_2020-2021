import numpy as np
import matplotlib.pyplot as plt
 
def sum(arr):
	sum = 0
	for el in range(len(arr)):
		sum = sum + arr[el]
	return sum
 
# set width of bars
barWidth = 0.20
 
# set heights of bars
# bars1 = [0.688, 0.661,	0.775,	0.902,	1.169]
# bars2 = [0.679,	0.736,	0.696,	1.131,	0.994]
# bars3 = [0.685,	0.681,	0.691,	0.985,	1.151]
# bars4 = [0.688,	0.678,	0.692,	1.138,	0.953]
bars1 = [2500,	2500,	2500,	2500,	2500]
bars2 = [12372,	10147,	12111,	12417,	12313]
bars3 = [4780,	5000,	5000,	4921,	5000]
bars4 = [16048,	15232,	13593,	16617,	14919]
bars = [bars1, bars2, bars3, bars4]

# Set position of bar on X axis
r1 = np.arange(len(bars1))
r2 = [x + barWidth for x in r1]
r3 = [x + barWidth for x in r2]
r4 = [x + barWidth for x in r3]
 
plt.figure(figsize=(16, 7))
# Make the plot
plt.bar(r1, bars1, color='#B2945B', width=barWidth, edgecolor='white', label='250 clients; 10 requests each')
plt.bar(r2, bars2, color='#D0E562', width=barWidth, edgecolor='white', label='250 clients; 50 requests each')
plt.bar(r3, bars3, color='#B6D369', width=barWidth, edgecolor='white', label='500 clients; 10 requests each')
plt.bar(r4, bars4, color='#93C48B', width=barWidth, edgecolor='white', label='500 clients; 50 requests each')
 
# Add xticks on the middle of the group bars
plt.xticks([r + barWidth / 100 for r in range(len(bars1))], ['Random', 'Round Robnin', 'Weighted Round Robnin', 'Least Connections', 'Source IP Hash'])
 
# Create legend & Show graphic
plt.legend()
plt.show()
