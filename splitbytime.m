function [ output ] = splitbytime(fun,input,fs,s )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

n=fs*s;
output = arrayfun(@(i) fun(input(i:i+n-1)),1:n:length(input)-n+1)';
end

