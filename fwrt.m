function [ fwhm, rt ] = fwrt( Y )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

if (length(Y) > 30)

    [~,i] = min(Y);
    shift = -i+1;
    NewY = circshift(Y,shift);
    [~,~,w,~] = findpeaks(NewY,'WidthReference','halfheight','SortStr','descend');
    fwhm = max(w);
    if (isscalar(fwhm) == 0)
        fwhm = 0;
    end
    rt = risetime(NewY,500);
    if (isscalar(rt) == 0)
        rt = 0;
    end
    
else
    
    fwhm = 0;
    rt = 0;
end
    

end

