from skimage.io import imread
import os
import csv
import random

test_images_ratio = 0.25

class image :

    def __init__(self, img_nparray, id, label=None):
        self.array = img_nparray
        self.id = id
        self.label = label

    def add_label(self, label):
        self.label = label

def LoadData(fname):
    """ Loads data """
    img_training = [imread('train/' + image_path) for image_path in os.listdir('train')]
    training_images = []
    for i in range(1, len(img_training) + 1):
        training_images.append(image(img_training[i - 1], i))

    with open('train.csv', newline='') as csvfile:
        spamreader = csv.reader(csvfile, delimiter=',', quotechar='|')
        labs = {}
        for row in spamreader:
            try:
                int(row[1])
            except:
                continue
            labs[row[0]] = int(row[1])

    for obj in training_images:
        obj.add_label(labs[str(obj.id)])

    random.shuffle(training_images)

    training_images, test_images = training_images[0: int(len(training_images) * (1 - test_images_ratio))], \
                                   training_images[int(len(training_images) * (1 - test_images_ratio)):]
    print('done loading')
    return training_images, test_images

#TODO: pad
#TODO: check if need contrast adjustments

if __name__ == '__main__':
    a = LoadData('train.tar.gz')
    print('done')
