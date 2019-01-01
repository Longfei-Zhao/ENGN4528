from __future__ import print_function
import keras
from keras.datasets import mnist
from keras.models import Sequential
from keras.layers import Dense, Dropout, Flatten, Lambda
from keras.layers import Conv2D, MaxPooling2D
from keras import backend as K
from keras.callbacks import EarlyStopping, ModelCheckpoint
from keras.models import load_model
from keras.optimizers import Adadelta, SGD, Adagrad, Adam


import numpy as np

#const
num_classes = 10
epochs = 10
train_patience = 6
model_name = 'dense.h5'


batch_size = 150
lr = 0.1
hidden_layer1 = 512
hidden_layer2 = 256
Dropout_rate = 0.3

def change_type(vects):
  #vv = K.square(sqrt(vects))
  return K.square(K.sqrt(vects))


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

print('x_train shape:', x_train.shape)
print(x_train.shape[0], 'train samples')
print(x_test.shape[0], 'test samples')

# convert class vectors to binary class matrices
y_train = keras.utils.to_categorical(y_train, num_classes)
y_test = keras.utils.to_categorical(y_test, num_classes)

###start codes
model = Sequential()
model.add(Flatten(input_shape=input_shape))
model.add(Lambda(change_type))
model.add(Dense(hidden_layer1,activation = 'relu'))
model.add(Dropout(Dropout_rate))
model.add(Dense(hidden_layer2, activation='relu'))
model.add(Dropout(Dropout_rate))
model.add(Dense(num_classes, activation='softmax'))

model.compile(loss=keras.losses.categorical_crossentropy,
              optimizer=Adagrad(lr = 0.001),
              metrics=['accuracy'])



callbacks = [
  EarlyStopping(monitor='val_loss', patience=train_patience, verbose=0),
  ModelCheckpoint(model_name, monitor='val_loss', save_best_only=True, verbose=0),
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

