import matplotlib.pyplot as plt
import numpy as np
import csv

plt.style.use("dark_background")

with open("./battery.log") as f:
    data = np.array([[float(i[0]), float(i[2])] for i in csv.reader(f, delimiter=" ")])


print(data)

ax: plt.Axes
fig: plt.Figure
fig, ax = plt.subplots(figsize=(16, 12))  # type: ignore

ax.plot(data[:, 0], data[:, 1] / 8790, ".-", markersize=5, linewidth=0.5)
ax.grid(linewidth=0.2)

plt.show()
