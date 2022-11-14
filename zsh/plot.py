import matplotlib.pyplot as plt
import numpy as np
import csv

with open("./battery.log") as f:
    data = np.array([[float(i[0]), float(i[2])] for i in csv.reader(f, delimiter=" ")])


print(data)

ax: plt.Axes
fig: plt.Figure
fig, ax = plt.subplots(figsize=(8, 6))  # type: ignore

ax.plot(data[:, 0], data[:, 1] / 8790)
ax.grid()

plt.show()
