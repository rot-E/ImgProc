// dct_8x8block_mean
//
clear;
xdel(winsid());


function im_fdct_8x8block_mean = fdct_8x8block_mean(im)
    [height, width] = size(im);
    b_x_max = fix(height / 8);
    b_y_max = fix(width / 8);

    // DCT 8x8 block
    for b_x = 1:b_x_max
        for b_y = 1:b_y_max
            block = 0.125 * imdct(im(1+8*(b_x-1) : 8*b_x, 1+8*(b_y-1) : 8*b_y)) + 128;
            block(1, 1) = block(1, 1) - 128;

            im_fdct_8x8block(1+8*(b_x-1) : 8*b_x, 1+8*(b_y-1) : 8*b_y) = block;
        end
    end

    // 出力im_fdct_8x8blockの各ブロックの直流成分を取り出し、8×8行列を直流成分で埋める
    for b_x = 1:b_x_max
        for b_y = 1:b_y_max
            im_fdct_8x8block_mean(1+8*(b_x-1) : 8*b_x, 1+8*(b_y-1) : 8*b_y) = im_fdct_8x8block(1+8*(b_x-1), 1+8*(b_y-1));
        end
    end
endfunction


// Image load
im_in_rgb  = imread("glasses.png");
[height, width, channel] = size(im_in_rgb);


// Processing
im_gray = rgb2gray(im_in_rgb)(1 : 8*fix(height/8), 1 : 8*fix(width/8));
im_fdct_8x8block_mean = fdct_8x8block_mean(im_gray);


// Display images
f1 = gcf();
drawlater();

subplot(121);
imshow(im_gray);
title("Grayscale");

subplot(122);
imshow(uint8(im_fdct_8x8block_mean));
title("DCT 8x8 block mean");

drawnow();
