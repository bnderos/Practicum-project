from tensorflow.keras.layers import Conv2D, Flatten, Dense, MaxPool2D
from tensorflow.keras.models import Sequential
from tensorflow.keras.preprocessing.image import ImageDataGenerator
import numpy as np


def load_train(path):
    train_datagen = ImageDataGenerator(validation_split=0.25, 
                                       rescale=1/255.)
    train_datagen_flow = train_datagen.flow_from_directory(
        path,
        target_size=(150, 150),
        batch_size=16,
        class_mode='sparse',
        subset='training',
        seed=12345)
    
    return train_datagen_flow

def create_model(input_shape):
    model = Sequential()
    model.add(Conv2D(filters=6, kernel_size=(5, 5), padding='same', activation='relu', input_shape=(150, 150, 3)))
    model.add(MaxPool2D(pool_size=(2, 2)))
    model.add(Conv2D(filters=16, kernel_size=(5, 5), padding='same', activation='relu'))
    model.add(MaxPool2D(pool_size=(2, 2)))
    model.add(Flatten())
    model.add(Dense(units=128, activation='relu'))
    model.add(Dense(units=64, activation='relu'))
    model.add(Dense(units=12, activation='softmax'))
    model.compile(optimizer='adam', loss='sparse_categorical_crossentropy', metrics=['acc'])
    
    return model

def train_model(model, train_data, test_data, batch_size=None, 				epochs=6, steps_per_epoch=None, 						validation_steps=None):

    model.fit(train_data,
              validation_data=test_data,
              batch_size=batch_size, epochs=epochs,
              steps_per_epoch=steps_per_epoch,
              validation_steps=validation_steps,
              verbose=2, shuffle=True)

    return model

#train = load_train("/datasets/fruits_small/")
#model = create_model(input_shape= (150 * 150, 3))
#train_model(model, train, train)