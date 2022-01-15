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
bars1 = [38.490, 27.311, 21.821, 19.804, 19.155] ## pthreads
bars2 = [60.670, 31.532, 23.373, 21.958, 20.093] ## MPI
bars3 = [20.444, 10.841, 5.925, 4.534, 3.791] ## OpenMP
# bars4 = [16048,	15232,	13593,	16617,	14919]
# bars5 = [16048,	15232,	13593,	16617,	14919]
# bars6 = [16048,	15232,	13593,	16617,	14919]
# bars7 = [16048,	15232,	13593,	16617,	14919]

bars = [bars1]#, bars2, bars3, bars4, bars5, bars6, bars7]

# Set position of bar on X axis
r1 = np.arange(len(bars1))
r2 = [x + barWidth for x in r1]
r3 = [x + barWidth for x in r2]
r4 = [x + barWidth for x in r3]
 
plt.figure(figsize=(16, 7))
# Make the plot
plt.bar(r1, bars1, color='#D0E562', width=barWidth, edgecolor='white', label='Pthreads')
plt.bar(r2, bars2, color='#93C48B', width=barWidth, edgecolor='white', label='MPI')
plt.bar(r3, bars3, color='#B6D369', width=barWidth, edgecolor='white', label='OpenMP')
# plt.bar(r4, bars4, color='#93C48B', width=barWidth, edgecolor='white', label='')
# plt.bar(r4, bars5, color='#93C48B', width=barWidth, edgecolor='white', label='')
# plt.bar(r4, bars6, color='#93C48B', width=barWidth, edgecolor='white', label='')
# plt.bar(r4, bars7, color='#93C48B', width=barWidth, edgecolor='white', label='')
 
 
# Add xticks on the middle of the group bars
plt.xticks([r + barWidth / 100 for r in range(len(bars1))], [ '2-Cores', '4-Cores', '8-Cores', '16-Cores', '24-Cores'])
 
# Create legend & Show graphic
plt.legend()
plt.show()
