%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% get the euler angles out of a rotation matirx %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function rot_out = ecR(R)
    xangle = atan2(R(2,3),R(3,3));
    yangle = asin(-R(1,3)); 
    zangle = atan2(R(1,2),R(1,1));       
    rot_out = [rad2deg(xangle), rad2deg(yangle), rad2deg(zangle)];    
end
    
