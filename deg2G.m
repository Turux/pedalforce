function [ G, A ] = deg2G( deg )
%DEG2G Summary of this function goes here
%   Detailed explanation goes here

edges = 0:1:360;

A = discretize(deg,edges);
G = discretize(deg,edges,edges(2:end));

end

