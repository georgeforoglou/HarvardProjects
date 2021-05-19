%Η συνάρτηση f(x,y)
func = @(x,y) x.^3 * exp(-x.^2 - y.^4);

%Στο figure 1 παρουσιάζει την f σε 3 διαστάσεις
fsurf(func)
title('3D plot')
xlabel('x')
ylabel('y')
zlabel('z')

%Στο figure 2 παρουσιάζει την f σε 2 διαστάσεις
figure
fcontour(func, [-2.5 2.5 -1.5 1.5])
grid
title('2D plot')
xlabel('x')
ylabel('y')