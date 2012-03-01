function SVDCompression()
imgIn = input('\nEnter full image filename, including filetype, or press return to skip:\n', 's');
[filename, filetype] = strtok(imgIn,'.');
if isempty(filename)
    fprintf('Ok, no image file, moving on...\n');
else
    filetype(1) = [];
    img2Mat = imread(filename, filetype);
end

matIn = input('\nEnter your matrix to convert to an image, or press return to skip:\n', 's');
if isempty(matIn) && ~isempty(filename)
    recycle = input('Would you like to use the image you entered above? (y/n)\n', 's');
    if recycle == 'y'
        matIn = img2Mat;
    else
        error('Ok, no matrix file, ending program...');
    end
elseif isempty(matIn)
    error('Ok, no matrix file, ending program...')
end

matIn(matIn < 0) = 0; %handles negative vals
matIn(matIn > 255) = 255; %handles colors over 8 bits

[A2, S2, K2, ~] = svdNfo(matIn, 2);
[A5, S5, K5, ~] = svdNfo(matIn, 5);
[A10, S10, K10, ~] = svdNfo(matIn, 10);

filename2 = [filename, '_k2.', filetype];
filename5 = [filename, '_k5.', filetype];
filename10 = [filename, '_k10.', filetype];

imwrite(uint8(A2), filename2, filetype);
imwrite(uint8(A5), filename5, filetype);
imwrite(uint8(A10), filename10, filetype);

figure;
imshow(filename2);
text(20, 20,['k = 2, \sigma_1 = ' num2str(S2) ', \sigma_k = ' num2str(K2)]...
    ,'EdgeColor','red','BackgroundColor','white');

figure;
imshow(filename5);
text(20, 20,['k = 5, \sigma_1 = ' num2str(S5) ', \sigma_k = ' num2str(K5)]...
    ,'EdgeColor','red','BackgroundColor','white');

figure;
imshow(filename10);
text(20, 20,['k = 10, \sigma_1 = ' num2str(S10) ', \sigma_k = ' num2str(K10)]...
    ,'EdgeColor','red','BackgroundColor','white');
end

%Returns rank k approximation, sigma_1, sigma_k, and sigma_(k+1)
function [Ak, sig1, sigk, sigk1] = svdNfo(A, k)

[U, S, V] = svds(double(rgb2gray(A)), k);

Ak = U*S*V'; %rank k approximation
sigs = diag(S);
sig1 = sigs(1); %sigma_1
sigk = sigs(k); %sigma_k

Ak1 = svds(double(rgb2gray(A)), k+1);
sigk1 = Ak1(end); %sigma_(k+1)
end
