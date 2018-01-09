function [ revs ] = deg2revs( deg )

% @Brief:   A function that converts a 1D array from degrees to revolutions
% @Param:   deg  -> 1D array of angles expressed in degrees
% @Return:  revs -> 1D array that counts how many revolutions have been
%                   completed. Starts from 1 for future grouping.
%                   A revolution

d = diff(deg);
revs = ones(length(deg),1);
for i = 1:(length(deg)-1)
    if(d(i) < -90)
        revs(i+1) = revs(i)+1;
    else
        revs(i+1) = revs(i);
    end
end