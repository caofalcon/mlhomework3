import numpy as np
from skimage.io import imread
import os
import csv

class image :

    def __init__(self, img_nparray, id, label=None):
        self.array = img_nparray
        self.id = id
        self.label = label

    def add_label(self, label):
        self.label = label

def LoadData(fname):
    """ Loads data """
    img_training = [imread('train\\' + image_path) for image_path in os.listdir('train')]
    images_training_obj = []
    for i in range(1, len(img_training) + 1):
        images_training_obj.append(image(img_training[i - 1], i))

    print(np.genfromtxt('train.csv'))


    return images_training_obj


if __name__ == '__main__':
    a = LoadData('train.tar.gz')
    print('done')