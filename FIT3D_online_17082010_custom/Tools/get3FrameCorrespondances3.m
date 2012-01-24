% Given 3 camera poses and the number of feature matches, it computes a
% random 3D structure and the image projections on 3 frames.


function [R3D,P,Q,R,Pw,Qw,Rw] = get3FrameCorrespondances3(Pcam1,Pcam2,n1,f,imgsize, mean)

    % Point Distances
    pointDist = 10;
    distanceVariance = 3;
    width = imgsize(1);
    height = imgsize(2);
    
    K = [f,0,width/2;0,f,height/2;0,0,1];
    
    % Define absolute camera motions
    Pcam1ABS = Pcam1;
    Pcam2ABS = [Pcam2(:,1:3)*Pcam1(:,1:3),Pcam2(:,1:3)*Pcam1(:,4)+Pcam2(:,4)];
        
    % Find n1*3 homogeneous points in image 1
    P = [ceil([(rand(n1*3,1)+mean(1))*(width-1),(rand(n1*3,1)+mean(2))*(height-1)]),ones(n1*3,1)]'; %3xn
    
    % Add bias in the mean of the points
    
    % Put them in homogeneous world coordinates
    Pw = (inv(K)*(P*f));    %3xn
        
    % Tracey rays to find homogeneous points in space
    t = [(rand(n1*3,1)+1)*distanceVariance+pointDist]';
    R3D = [[Pw(1,:).*t;Pw(2,:).*t;Pw(3,:).*t];ones(1,n1*3)]; % 4xn
   
    
    
    % Project points in image plane 2
    Qw = Pcam1ABS*R3D;
    
    % Project points in image plane 3
    Rw = Pcam2ABS*R3D;
    
    % Put in image coordinates
    rPw = K*(Pw(1:3,:));
    rP = P./repmat(P(3,:),3,1);
    
    Q = K*(Qw);
    Q = Q./repmat(Q(3,:),3,1);
    
    R = K*(Rw);
    R = R./repmat(R(3,:),3,1);
    
    

    