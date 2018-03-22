function [ AreaError ] = areaerror( A, Asd, B, Bsd )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
AreaError = sqrt(((Asd)./A).^2+(Bsd./B).^2);
AreaError = sum(AreaError.^2);
AreaError = sqrt(AreaError);

end

