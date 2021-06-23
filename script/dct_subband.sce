// dct_subband
//
clear;
xdel(winsid());


// DCT 8x8 block
function im_fdct_8x8block = fdct_8x8block(im)
    [height, width] = size(im);
    b_x_max = fix(height / 8);
    b_y_max = fix(width / 8);

    for b_x = 1:b_x_max
        for b_y = 1:b_y_max
            block = 0.125 * imdct(im(1+8*(b_x-1) : 8*b_x, 1+8*(b_y-1) : 8*b_y)) + 128;
            block(1, 1) = block(1, 1) - 128;

            im_fdct_8x8block(1+8*(b_x-1) : 8*b_x, 1+8*(b_y-1) : 8*b_y) = block;
        end
    end
endfunction


// DCT subband
function im_fdct_subband = dct2subband(im_fdct_8x8block)
    [height, width] = size(im_fdct_8x8block);
    b_x_max = fix(height / 8);
    b_y_max = fix(width / 8);

    for b_x = 1:b_x_max
        for b_y = 1:b_y_max
            for i = 1:8
                for j = 1:8
                    im_fdct_subband(b_x_max*(i-1)+b_x, b_y_max*(j-1)+b_y) = im_fdct_8x8block(8*(b_x-1)+i, 8*(b_y-1)+j);
                end
            end
        end
    end
endfunction


// Image load
im_in_rgb  = imread("seisaku5-8bpp.png");
[height, width, channel] = size(im_in_rgb);


// Processing
im_gray = rgb2gray(im_in_rgb)(1 : 8*fix(height/8), 1 : 8*fix(width/8));
im_fdct_8x8block = fdct_8x8block(im_gray);
im_fdct_subband = dct2subband(im_fdct_8x8block);


// Display images
f1 = gcf();
drawlater();

subplot(121);
imshow(im_gray);
title("Grayscale");

subplot(122);
imshow(uint8(im_fdct_subband));
title("DCT subband");

drawnow();
