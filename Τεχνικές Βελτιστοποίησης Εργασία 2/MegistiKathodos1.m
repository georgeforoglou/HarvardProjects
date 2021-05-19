%Αρχικά χρησιμοποιώ την syms για να ορίσω την f και να υπολογίσω την κλίση
%gradf αλλα και την νορμα της κλίσης norm(gradf)
%syms x y
%func = x^3 * exp(-x^2 - y^4);
%gradf = gradient(func);
%n = norm(gradf);

%Ορίζω την f για χρήση απο τον κώδικα
func = @(x,y) x.^3 * exp(-x.^2 - y.^4);

%Απο το workspace πήρα τις τιμές των df/dx, df/dy και |gradf| και ορίζω
%συναρτήσεις των (x,y) αυτών
gradfx = @(x,y) 3*x^2*exp(- x^2 - y^4) - 2*x^4*exp(- x^2 - y^4);
gradfy = @(x,y) -4*x^3*y^3*exp(- x^2 - y^4);
n = @(x,y) (abs(3*x^2*exp(- x^2 - y^4) - 2*x^4*exp(- x^2 - y^4))^2 + 16*exp(- 2*real(x^2) - 2*real(y^4))*abs(x)^6*abs(y)^6)^(1/2);

%Πίνακας για τις τιμές x0, y0
xyvalues = [0 -1 1];

%Σταθερή τιμη ε
eps = 0.01;

%Σταθερή τιμη γκ
gama = 2;

for i = 1:3
    
    %(x0,y0)
    xk = xyvalues(i);
    yk = xyvalues(i);
    
    %Γραφική παράσταση της f σε 2 διαστάσεις
    figure
	fcontour(func, [-2.5 2.5 -1.5 1.5])
	grid
	hold on
    title(['Steapest Descent, γκ=0.2, Αρχικό σημείο ', '(', num2str(xk), ',', num2str(yk), ')'])
    xlabel('x')
    ylabel('y')
    
    %Τοποθετώ την αρχική τιμή x0,y0 στο διάγραμμα
    plot(xk,yk,'x')
    text(xk,yk, ['(', num2str(xk), ',', num2str(yk), ')'])
    
    %Υπολογισμός της κατεύθυνσης για x και y και της νόρμας στο x0,y0
    sx = -gradfx(xk,yk);
    sy = -gradfy(xk,yk);
    n_xy = n(xk,yk);
    
    while n_xy > eps
        
        %Υπολογισμός xk+1 και yk+1
        xk = xk + gama*sx;
        yk = yk + gama*sy;
        
        %Τα τοποθετώ στο διάγραμμα
        hold on
        plot(xk,yk,'x')
             
        %Μεταβολή της κατεύθυνσης και της νόρμας
        sx = -gradfx(xk,yk);
        sy = -gradfy(xk,yk);
        n_xy = n(xk,yk);
        
    end
    
end