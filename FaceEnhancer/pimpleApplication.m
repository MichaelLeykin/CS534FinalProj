function [processed_img,centers,radii] = pimpleApplication(orig_img)
    
    % Convert a grayscale image to a binary image
    fh1 = figure;
    img = imread(orig_img);
    subplot(1, 2, 1);

    % Convert the image into a binary image by applying a threshold
    threshold = 0.5;
    bw_img = im2bw(img, threshold);
    subplot(1, 2, 2);
    imshow(bw_img);
    
    % Convert the binary  image into eroded image where k = ???
    processed_img = bwmorph(bw_img, 'erode', 5);
    subplot(1, 2, 2);
    imshow(processed_img); title('After Erosion');
    imwrite(processed_img, 'eroded_pimples.png');

    % Finds dark circles within specified pixel range, with customized
    % sensitizity.
    [centers,radii] = imfindcircles(processed_img,[2 12],'ObjectPolarity','dark', 'Sensitivity',.7)
    imshow(processed_img)
    h = viscircles(centers,radii);
end