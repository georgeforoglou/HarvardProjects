%Αρχικά χρησιμοποιώ την syms για να ορίσω την f και να υπολογίσω την κλίση
%gradf και την λαπλασιανή της f
syms x y
func = x^3 * exp(-x^2 - y^4);
gradf = jacobian(func);
L = jacobian(gradf);

%Ορίζω την f για χρήση απο τον κώδικα και το μέτρο συναρτήση του x και y
func = @(x,y) x.^3 * exp(-x.^2 - y.^4);
n = @(x,y) (abs(3*x^2*exp(- x^2 - y^4) - 2*x^4*exp(- x^2 - y^4))^2 + 16*exp(- 2*real(x^2) - 2*real(y^4))*abs(x)^6*abs(y)^6)^(1/2);

%Πίνακας για τις τιμές x0, y0
xyvalues = [0 -1 1];

%Σταθερή τιμη ε
eps = 0.01;

%Σταθερό γκ=0.2
gama = 0.2;

%Μοναδιαίος Πίνακας
I = eye(2);

%Αρχικό μκ
mk = 0.1;

for i = 1:3
    
    %(x0,y0)
    xk = xyvalues(i);
    yk = xyvalues(i);
    
    %Γραφική παράσταση της f σε 2 διαστάσεις 
    figure
    fcontour(func, [-2.5 2.5 -1.5 1.5])
    grid
    title(['Μέθοδος Levenberg-Marquardt, γκ=0.2, Αρχικό σημείο ', '(', num2str(xk), ',', num2str(yk), ')'])  
    xlabel('x')
    ylabel('y')
    
    %Τοποθετώ την αρχική τιμή x0,y0 στο διάγραμμα
    hold on 
    plot(xk,yk,'x')
    text(xk,yk, ['(', num2str(xk), ',', num2str(yk), ')'])
    
    %Πίνακας για τον υπολογισμό του μκ, και την κατεύθυνση
    A = L + mk * I;
    A_xy = double(subs(A, {x,y}, {xk,yk}));
    gradf_xy = double(subs(gradf, {x,y}, {xk,yk}));
    dk = (gradf_xy/A_xy);    
    
    %Κατεύθθυνση x,y και νόρμα στο xk,yk
    sx = -dk(1,1);
    sy = -dk(1,2);
    n_xy = n(xk,yk);
    
    while n_xy > eps
        
        %Υπολογισμός μκ έτσι ώστε να είναι θετικά ορισμένος ο Α
        while 1 > 0
            if all(eig(A_xy) > 0)
                break;
            else
                mk = mk + 0.1;
                A = L + mk * I;
                A_xy = double(subs(A, {x,y}, {xk,yk}));
            end 
        end 
        
        %Υπολογισμός xk+1 και yk+1
        xk = xk + gama*sx;
        yk = yk + gama*sy;
        
        %Τα τοποθετώ στο διάγραμμα
        hold on 
        plot(xk,yk,'x')
        
        %Υπολογισμός της καινούριας κατεύθυνσης
        gradf_xy = double(subs(gradf, {x,y}, {xk,yk}));
        dk = (gradf_xy/A_xy);   
        sx = -dk(1,1);
        sy = -dk(1,2);
        n_xy = n(xk,yk);
    end
    
end
