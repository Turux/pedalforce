function [a1,a2,a3,a4,a5] = angletabletime(maintable_short)
%ANGLETABLETIME Summary of this function goes here
%   Detailed explanation goes here
l=height(maintable_short);
gap=round(height(maintable_short)/5);
G=1:gap:l;

a1=buildangletable(maintable_short(G(1):G(2),:));
a2=buildangletable(maintable_short(G(2):G(3),:));
a3=buildangletable(maintable_short(G(3):G(4),:));
a4=buildangletable(maintable_short(G(4):G(5),:));
a5=buildangletable(maintable_short(G(5):G(6),:));
    

end

