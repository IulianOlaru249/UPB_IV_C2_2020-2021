#!/usr/bin/python3

import matplotlib.pyplot as plt


def main():
	real_time    = [[ 22,          110,     111,     156,     158,     232,     357,     428,     519,     506],    
					[12,      90,      94,     101,     115,     144,     152,     153,     170,     164],
					[5,     17,     20,     40,     27,     51,     69,     94,    199,    203]]
	archive_size = [[ 6488665, 2848209, 2724469, 2609121, 2522249, 2428104, 2385236, 2376868, 2372126, 2372105],
					[4264316, 2582921, 2535089, 2505860, 2529535, 2516390, 2512654, 2512067, 2511624, 2511497],
					[1440054, 331089, 310084, 285593, 255405, 240715, 231578, 229028, 227360, 227226]]

	for i in range(3):
		# TODO: for each compression level in {0, 1, ..., 9}:
		#			fill real_time [ms]
		#			fill archive_size [bytes]
		level        = list(range(10))

		archive_size_slice = [it / 1024 for it in archive_size[i]]

		# plot data
		fix, axs = plt.subplots(2)

		real_time_slice = list(real_time[i])
		# archive_size_slice = list(archive_size[i])


		axs[0].plot(level, real_time_slice,    'bo-')
		axs[1].plot(level, archive_size_slice, 'ro-')

		axs[0].set_xticks(level)
		axs[1].set_xticks(level)

		axs[0].grid(True, which='both')
		axs[1].grid(True, which='both')

		axs[0].set_xlabel('Compression level')
		axs[1].set_xlabel('Compression level')

		axs[0].set_ylabel('Time [ms]')
		axs[1].set_ylabel('Archive size [byte]')

		plt.title("Figure" + str(i))
		plt.show()


if __name__ == '__main__':
	main()