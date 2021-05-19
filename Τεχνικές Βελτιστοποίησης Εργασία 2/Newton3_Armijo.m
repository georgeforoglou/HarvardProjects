%Αρχικά χρησιμοποιώ την syms για να ορίσω την f και να υπολογίσω την κλίση
%gradf, την νορμα της κλίσης norm(gradf), την λαπλασιανή της f, τον
%αντσίστροφο της λαπλασιανής
%syms x y
%func = x^3 * exp(-x^2 - y^4);
%gradf = jacobian(func);
%L = jacobian(gradf);
%invertedL = inv(L);
%gradf2 = [gradf(1,1) ; gradf(1,2)];
%direction = invertedL * gradf2;
%n = norm(gradf);

%Ορίζω την f για χρήση απο τον κώδικα
func = @(x,y) x.^3 * exp(-x.^2 - y.^4);

%Απο το workspace πήρα τις τιμές των df/dx, df/dy, d2f/dx2, d2f/dy2 και
%|gradf| και έτσι ua υπολογίστo;yn οι τιμές των κατευθύνσεων για x και y
gradfx = @(x,y) 3*x^2*exp(- x^2 - y^4) - 2*x^4*exp(- x^2 - y^4);
gradfy = @(x,y) -4*x^3*y^3*exp(- x^2 - y^4);
dx = @(x,y) (2*x^3*y^3*(- 2*y*x^2 + 3*y))/(6*x^6 + 4*x^4*y^4 - 21*x^4 + 6*x^2*y^4 + 9*x^2) - (exp(x^2 + y^4)*(3*x^2*exp(- x^2 - y^4) - 2*x^4*exp(- x^2 - y^4))*(4*y^4 - 3))/(2*(6*x^5 + 4*x^3*y^4 - 21*x^3 + 6*x*y^4 + 9*x));
dy = @(x,y) (x^3*y^3*(2*x^4 - 7*x^2 + 3))/(6*x^7*y^2 + 4*x^5*y^6 - 21*x^5*y^2 + 6*x^3*y^6 + 9*x^3*y^2) - (exp(x^2 + y^4)*(3*x^2*exp(- x^2 - y^4) - 2*x^4*exp(- x^2 - y^4))*(- 2*y*x^2 + 3*y))/(2*(6*x^6 + 4*x^4*y^4 - 21*x^4 + 6*x^2*y^4 + 9*x^2));
n = @(x,y) (abs(3*x^2*exp(- x^2 - y^4) - 2*x^4*exp(- x^2 - y^4))^2 + 16*exp(- 2*real(x^2) - 2*real(y^4))*abs(x)^6*abs(y)^6)^(1/2);

%Πίνακας για τις τιμές x0, y0
xyvalues = [0 -1 1];

%Σταθερή τιμη ε
eps = 0.01;

%α = 0.001, β = 0.25, s = 2
alpha = 0.01;
beta = 0.25;
s = 2;

for i = 1:3
    
    %(x0,y0)
    xk = xyvalues(i);
    yk = xyvalues(i);
    
    %Γραφική παράσταση της f σε 2 διαστάσεις
    figure
    fcontour(func, [-2.5 2.5 -1.5 1.5])
    grid
    hold on
    title(['Μέθοδος Newton, Armijo, Αρχικό σημείο ', '(', num2str(xk), ',', num2str(yk), ')'])
    xlabel('x')
    ylabel('y')
    
    %Τοποθετώ την αρχική τιμή x0,y0 στο διάγραμμα
    hold on 
    plot(xk,yk,'x')
    text(xk,yk, ['(', num2str(xk), ',', num2str(yk), ')'])
    
    %Κατεύθυνση x και y και νόρμα στο xk,yk
    sx = -dx(xk,yk);
    sy = -dy(xk,yk);
    n_xy = n(xk,yk);
        
    while n_xy > eps
        
        %Αλγόριθμος Armijo
        while 1 > 0
			x_new = xk + s*sx;
			y_new = yk + s*sy;
			if (func(x_new,y_new) <= func(xk,yk) + s * beta * alpha * (sx * gradfx(xk,yk) + sy * gradfy(xk,yk)))
				gama_armijo = s;
				break;
			else
				s = s * beta;
            end              
        end
                
        %Υπολογισμός xk+1 και yk+1
        xk = xk + gama_armijo*sx;
        yk = yk + gama_armijo*sy;
        
        %Τα τοποθετώ στο διάγραμμα
        hold on 
        plot(xk,yk,'x')
        
        %Μεταβολή της κατεύθυνσης και της νόρμας
        sx = -dx(xk,yk);
        sy = -dy(xk,yk);
        n_xy = n(xk,yk);
        
    end
    
end

