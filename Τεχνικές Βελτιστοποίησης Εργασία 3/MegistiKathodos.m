%Ορίζω την f για χρήση απο τον κώδικα
func = @(x1,x2) 0.5 * (x1^2) + 0.5 * (x2^2);

%Ορίζω συναρτήσεις ως προς x1, x2 των df/dx1, df/dx2 και |gradf|
gradfx = @(x1,x2) x1;
gradfy = @(x1,x2) x2;
n = @(x1,x2) (abs(x1)^2 + abs(x2)^2)^(1/2);

%Σταθερή τιμη ε
eps = 0.01;

%Πίνακας για τις τιμές γκ
gvalues = [0.1 1 2 10];

%Στο figure 1 παρουσιάζει την f σε 3 διαστάσεις
figure
fsurf(func , [-8 8 -8 8])
title('3D Διάγραμμα')
xlabel('x1')
ylabel('x2')
zlabel('z')

%Πίνακες για τον έλεγχο των τιμών που παίρνουν τα x1 και x2
x1values = zeros(4,30);
x2values = zeros(4,30);

j = 1;


for i = 1:4

    %Για τα βήματα σύγλισης
    k = 0;
    
    %Σημείο εκκίνησης
    x1k = 5;
    x2k = 5;
    
    %Αρχικές τιμές x1,x2
    x1values(i,1) = x1k;
    x2values(i,1) = x2k;
    
    %Στο figure 2 παρουσιάζει την f σε 2 διαστάσεις
    figure
    fcontour(func)
    grid
    hold on
    
    %Τοποθετώ την αρχική τιμή x1_0,x2_0 στο διάγραμμα
    plot(x1k,x2k,'x')
    text(x1k,x2k, ['(', num2str(x1k), ',', num2str(x2k), ')'])
    
    %Υπολογισμός της κατεύθυνσης για x1 και x2 και της νόρμας στο x1_0,x2_0
    sx1 = -gradfx(x1k,x2k);
    sx2 = -gradfy(x1k,x2k);
    n_x = n(x1k,x2k);
    
    while n_x > eps
        
        %Υπολογισμός x1k+1 και x2k+1
        x1k = x1k + gvalues(i)*sx1;
        x2k = x2k + gvalues(i)*sx2;
        
        %Βάζουμε τις τιμές των x1,x2 στους αντιστοιχους πίνακες
        x1values(i,j+1) = x1k;
        x2values(i,j+1) = x2k;
        
        %Τα τοποθετώ στο διάγραμμα
        hold on
        plot(x1k,x2k,'x')
        
        %Έλεγχος εαν στο επόμενο βήμα η f ελχιστόποιείται, αν όχι
        %διακόπτεται ο αλγόριθμος γιατί έχουμε απόκλιση και δεν θα τείνει
        %στο άπειρο
        if func(x1values(i,j),x2values(i,j)) < func(x1values(i,j+1),x2values(i,j+1))
            
            title(['Steapest Descent, γκ = ', num2str(gvalues(i)), ' Αρχικό σημείο (5,5)', newline, 'Ο Αλγόριθμος Αποκλίνει'])
            break
            
        else
            
            %Μεταβολή της κατεύθυνσης και της νόρμας
            sx1 = -gradfx(x1k,x2k);
            sx2 = -gradfy(x1k,x2k);
            n_x = n(x1k,x2k);
            
        end
        
        j = j + 1;
        k = k + 1;
        
        if k == 1
            title(['Steapest Descent, γκ = ', num2str(gvalues(i)), ', Αρχικό σημείο (5,5)', newline, 'Ο Αλγόριθμος Συγκλίνει σε ', num2str(k), ' βήμα'])
        else
            title(['Steapest Descent, γκ = ', num2str(gvalues(i)), ', Αρχικό σημείο (5,5)', newline, 'Ο Αλγόριθμος Συγκλίνει σε ', num2str(k), ' βήματα'])
        end
        
    end
    
end



