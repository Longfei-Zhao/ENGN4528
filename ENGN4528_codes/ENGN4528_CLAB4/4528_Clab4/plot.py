'''Trains a simple convnet on the MNIST dataset.

Gets to 99.25% test accuracy after 12 epochs
(there is still a lot of margin for parameter tuning).
16 seconds per epoch on a GRID K520 GPU.
'''

from __future__ import print_function
import numpy as np
import matplotlib.pyplot as plt

data = np.load('adagrad.npz')

plt.figure()
# acc
iters = range(len(data['train_loss']))
plt.plot(iters, data['train_acc'], 'r', label='train acc')
# loss
plt.plot(iters, data['train_loss'], 'g', label='train loss')
    # val_acc
plt.plot(iters, data['val_acc'], 'b', label='val acc')
# val_loss
plt.plot(iters, data['val_loss'], 'k', label='val loss')
plt.grid(True)
plt.xlabel('epoch')
plt.ylabel('acc-loss')
plt.legend(loc="upper right")
plt.show()


