// yuv_randxor
//
clear;
xdel(winsid());


function mat = randmat(x, y)
    mat = 255 * rand(x, y);

    for i = 1 : x
        for j = 1 : y
            mat(i, j) = fix(mat(i, j));
        end
    end
endfunction

function im_randxor = randxor(im)
    [height, width] = size(im);

    im_randxor = uint8(bitxor(im, randmat(height, width)));
endfunction


// Image load
im_in_rgb  = imread("balloons.png");


// Processes
im_in_yuv = rgb2ycbcr(im_in_rgb);
im_in_u = im_in_yuv(:, :, 1);   // Cb: B-Y
im_in_v = im_in_yuv(:, :, 2);   // Cr: R-Y
im_in_y = im_in_yuv(:, :, 3);

im_out_y = cat(3, im_in_u, im_in_v, randxor(im_in_y));
im_out_uv = cat(3, randxor(im_in_u), randxor(im_in_v), im_in_y);


// Display images
f1 = gcf(); // 0th graphic window for image preview
drawlater();

subplot(2, 2, 1);
imshow(im_in_rgb);
title("Original");

subplot(2, 2, 3);
imshow(ycbcr2rgb(im_out_y));
title("Processed Y");

subplot(2, 2, 4);
imshow(ycbcr2rgb(im_out_uv));
title("Processed U & V");

drawnow();
