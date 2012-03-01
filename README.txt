==HOWTO==
1. Move the images you would like to manipulate to the same directory as project4.m
2. Run the project4.m in MATLAB
3. At the prompt, enter the filename of your image, OR press return to skip
4. If you have your own matrix to input, enter it at the following prompt, OR press return to skip.
5. If you entered an image filename and skipped the previous step, you may elect to use your image as the matrix to be operated on. To do so, enter y and then press return.
6. The program will save 3 images (1 per k value) in the directory and display them in separate figure windows with information on the k, sigma_1, and sigma_k values outlined in red at the top of the figure.

==QUESTION==
In order for an image to be recognizable after some A(k), sigma of k+1 need be smaller than sigma of 1. Even on an image of reasonable quality (recognition), sigma of k+1 is much greater than 255.

When this program was tested on the images in the examples folder, the threshold of recognizing the form of the image's object was about k=9, and the point of specific recognition of the object (like a face) was about k=13. Thus I can conclude that the rank, roughly speaking, of the human face is 13.