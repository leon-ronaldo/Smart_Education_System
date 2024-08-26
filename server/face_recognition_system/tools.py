from PIL import Image, ImageEnhance, ImageFilter
import cv2
import numpy as np

def enhanceImage(imagePath, alpha = 1.2, beta = 30, factor = 1.5):
    # reading the image as an object 
    image = cv2.imread(imagePath)
    
    # sharpening
    kernel = np.array([[-1, -1, -1],
                       [-1, 9, -1],
                       [-1, -1, -1]])
    image = cv2.filter2D(image, -1, kernel)
    
    cv2.imwrite(f"sharpened {imagePath}", image)
    
enhanceImage('group1.jpeg')