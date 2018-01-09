function [ rpm ] = deg2rpm( deg,fs )
%RADS2RPM Summary of this function goes here
%   Detailed explanation goes here

rad = deg2rad(deg);
rdiff = angdiff(rad);
rdiff = [0, rdiff']';
diff = rad2deg(rdiff);
degperminute = (diff*fs)*60;
rpm = degperminute/360;

end

