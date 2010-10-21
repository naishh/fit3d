
   

    

x1 = rand(1,10);
y1 = rand(1,10);

vi = convhull(x1,y1);
polyarea(x1(vi),y1(vi))

plot(x1,y1,'.')
axis equal
hold on
fill ( x1(vi), y1(vi), 'r','facealpha', 0.5 ); 
hold off

