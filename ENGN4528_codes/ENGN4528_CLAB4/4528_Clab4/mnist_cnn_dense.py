'''Trains a simple convnet on the MNIST dataset.

Gets to 99.25% test accuracy after 12 epochs
(there is still a lot of margin for parameter tuning).
16 seconds per epoch on a GRID K520 GPU.
'''

from __future__ import print_function
import keras
from keras.datasets import mnist
from keras.models import Sequential
from keras.layers import Dense, Dropout, Flatten
from keras.layers import Conv2D, MaxPooling2D
from keras import backend as K
from keras.callbacks import EarlyStopping, ModelCheckpoint
from keras.models import load_model
from keras.optimizers import Adadelta, SGD, Adagrad, Adam



import numpy as np

#const
num_classes = 10
epochs = 100
train_patience = 6
model_name = 'cnn_dense.h5'
save_data = 'adadelta.npz'
kernel_size = 3
pool_size = 2

filter_num = 64
batch_size = 150
lr = 0.1
hidden_layer1 = 128
hidden_layer2 = 64
Dropout_rate = 0.3

class LossHistory(keras.callbacks.Callback):
    def on_train_begin(self, logs={}):
        self.losses = {'batch':[], 'epoch':[]}
        self.accuracy = {'batch':[], 'epoch':[]}
        self.val_loss = {'batch':[], 'epoch':[]}
        self.val_acc = {'batch':[], 'epoch':[]}

    def on_batch_end(self, batch, logs={}):
        self.losses['batch'].append(logs.get('loss'))
        self.accuracy['batch'].append(logs.get('acc'))
        self.val_loss['batch'].append(logs.get('val_loss'))
        self.val_acc['batch'].append(logs.get('val_acc'))

    def on_epoch_end(self, batch, logs={}):
        self.losses['epoch'].append(logs.get('loss'))
        self.accuracy['epoch'].append(logs.get('acc'))
        self.val_loss['epoch'].append(logs.get('val_loss'))
        self.val_acc['epoch'].append(logs.get('val_acc'))

    def loss_save(self, file_name):
    	train_acc = np.array(self.accuracy['epoch'])
    	val_acc = np.array(self.val_acc['epoch'])
    	train_loss = np.array(self.losses['epoch'])
    	val_loss = np.array(self.val_loss['epoch'])
    	np.savez(file_name,train_acc = train_acc, train_loss = train_loss, val_acc = val_acc, val_loss = val_loss)




# input image dimensions
img_rows, img_cols = 28, 28

# the data, shuffled and split between train and test sets
data_file = np.load('mnist.npz')
x_train, y_train, x_test, y_test = data_file['x_train'],data_file['y_train'],data_file['x_test'],data_file['y_test']


if K.image_data_format() == 'channels_first':
    x_train = x_train.reshape(x_train.shape[0], 1, img_rows, img_cols)
    x_test = x_test.reshape(x_test.shape[0], 1, img_rows, img_cols)
    input_shape = (1, img_rows, img_cols)
else:
    x_train = x_train.reshape(x_train.shape[0], img_rows, img_cols, 1)
    x_test = x_test.reshape(x_test.shape[0], img_rows, img_cols, 1)
    input_shape = (img_rows, img_cols, 1)

x_train = x_train.astype('float32')
x_test = x_test.astype('float32')
x_train /= 255
x_test /= 255
print('x_train shape:', x_train.shape)
print(x_train.shape[0], 'train samples')
print(x_test.shape[0], 'test samples')

# convert class vectors to binary class matrices
y_train = keras.utils.to_categorical(y_train, num_classes)
y_test = keras.utils.to_categorical(y_test, num_classes)

###start codes
model = Sequential()
model.add(Conv2D(filter_num, kernel_size=(kernel_size, kernel_size),
                 activation='relu',
                 input_shape=input_shape))
model.add(MaxPooling2D(pool_size=(pool_size, pool_size)))
model.add(Flatten())
model.add(Dense(hidden_layer1,activation = 'relu'))
model.add(Dropout(Dropout_rate))
model.add(Dense(hidden_layer2, activation='relu'))
model.add(Dropout(Dropout_rate))
model.add(Dense(num_classes, activation='softmax'))

model.compile(loss=keras.losses.categorical_crossentropy,
              optimizer=Adadelta(lr = lr),
              metrics=['accuracy'])

plot_model(model, to_file='model.png')

#ann_viz(model, view = True, filename = "network.gv",title = "MyNeural Network")

'''
history = LossHistory()
callbacks = [
  EarlyStopping(monitor='val_loss', patience=train_patience, verbose=0),
  ModelCheckpoint(model_name, monitor='val_loss', save_best_only=True, verbose=0),
  history,
]

model.fit(x_train, y_train,
          batch_size=batch_size,
          epochs=epochs,
          verbose=1,
          validation_split = 0.2,
          callbacks = callbacks)

model = load_model(model_name)

score = model.evaluate(x_test, y_test, verbose=0)
print('Test loss:', score[0])
print('Test accuracy:', score[1])

history.loss_save(save_data)
'''

