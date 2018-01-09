function [ rads ] = rad2rads( rad, fs )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

diff = angdiff(rad);
rads = diff*fs;
rads = [0, rads']';

end

