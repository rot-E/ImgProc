// rgb_channel
//
clear;
xdel(winsid());


function im_chan = channel(im)
    [height, width] = size(im);
    tsep_h = fix(height / 3);

    // R channel
    for h = tsep_h * 0 + 1 : tsep_h * 1
        im(h, :, (2 : 3)) = 0;
    end

    // G channel
    for h = tsep_h * 1 + 1 : tsep_h * 2
        im(h, :, 1) = 0;
        im(h, :, 3) = 0;
    end

    // B channel
    for h = tsep_h * 2 + 1 : height
        im(h, :, (1 : 2)) = 0;
    end

    im_chan = im;
endfunction


// Image load
im_in_rgb  = imread("balloons.png");


// Processes
im_out_rgb = channel(im_in_rgb);


// Display images
f1 = gcf(); // 0th graphic window for image preview
drawlater();

subplot(1, 2, 1);
imshow(im_in_rgb);
title("Original");

subplot(1, 2, 2);
imshow(im_out_rgb);
title("Processed");

drawnow();
