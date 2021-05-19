%Ορίζω την f για χρήση απο τον κώδικα
func = @(x1,x2) 0.5 * (x1^2) + 0.5 * (x2^2);

%Ορίζω συναρτήσεις ως προς x1, x2 των df/dx1, df/dx2 και |gradf|
gradfx = @(x1,x2) x1;
gradfy = @(x1,x2) x2;
n = @(x1,x2) (abs(x1)^2 + abs(x2)^2)^(1/2);

%Σταθερή τιμη ε
eps = 0.01;

%γκ
gamma = 0.1;

%Στο figure 1 παρουσιάζει την f σε 3 διαστάσεις
figure
fsurf(func, [-20 10 -12 15])
title('3D Διάγραμμα, -20 <= x1 <= 10, -12 <= x2 <= 15')
xlabel('x1')
ylabel('x2')
zlabel('z')

%Σημείο εκκίνησης
x1k = 8;
x2k = 3;

%Βήμα κατεύθυνσης, sk
sk = 15;

%Στο figure 2 παρουσιάζει την f σε 2 διαστάσεις
figure
fcontour(func, [-20 10 -12 15])
grid
hold on
xlabel('x1')
ylabel('x2')

%Τοποθετώ την αρχική τιμή x1_0,x2_0 στο διάγραμμα
plot(x1k,x2k,'x')
text(x1k,x2k, ['(', num2str(x1k), ',', num2str(x2k), ')'])

%Υπολογισμός της κατεύθυνσης για x1 και x2 και της νόρμας στο x1_0,x2_0
sx1 = -sk * gradfx(x1k,x2k);
sx2 = -sk * gradfy(x1k,x2k);
n_x = n(x1k,x2k);

k = 0;
j = 1;

%Πίνακες για τον έλεγχο των τιμών των x1 και x2
x1values = zeros(1,30);
x2values = zeros(1,30);

%Αρχικά x1,x2
x1values(1) = x1k;
x2values(1) = x2k;

while n_x > eps
        
        %Έλεγχος αν το καινούριο σημείο είναι εντός των ορίων, αν δεν είναι
        %υπολογίζεται η προβολή
        if (x1k + gamma*sx1 < -20) && (x2k + gamma*sx2 < -12)
            
            x1kbar = -20;
            x2kbar = -12;
            
            %Υπολογισμός x1k+1 και x2k+1
            x1k = x1k + gamma*(x1kbar - x1k);
            x2k = x2k + gamma*(x2kbar - x2k);
            
        elseif (x1k + gamma*sx1 < -20) && (x2k + gamma*sx2 > 15)
            
            x1kbar = -20;
            x2kbar = 15;
            
            %Υπολογισμός x1k+1 και x2k+1
            x1k = x1k + gamma*(x1kbar - x1k);
            x2k = x2k + gamma*(x2kbar - x2k);
            
        elseif (x1k + gamma*sx1 > 10) && (x2k + gamma*sx2 < -12)
            
            x1kbar = 10;
            x2kbar = -12;
            
            %Υπολογισμός x1k+1 και x2k+1
            x1k = x1k + gamma*(x1kbar - x1k);
            x2k = x2k + gamma*(x2kbar - x2k);
            
        elseif (x1k + gamma*sx1 > 10) && (x2k + gamma*sx2 > 15)
            
            x1kbar = 10;
            x2kbar = 15;
            
            %Υπολογισμός x1k+1 και x2k+1
            x1k = x1k + gamma*(x1kbar - x1k);
            x2k = x2k + gamma*(x2kbar - x2k);
        
        %Αν είμαστε εντός ορίων ο αλγόριθμος γίνεται Μέγιστη Κάθοδος με
        %βήμα αναζήτησης γκ*sκ
        else
            
            %Υπολογισμός x1k+1 και x2k+1
            x1k = x1k + gamma*sx1;
            x2k = x2k + gamma*sx2;

            %Μεταβολή της κατεύθυνσης
            sx1 = -sk * gradfx(x1k,x2k);
            sx2 = -sk * gradfy(x1k,x2k);  
            
        end
        
        %Μεταβολή της νόρμας
        n_x = n(x1k,x2k);
        
        %Τα τοποθετώ στο διάγραμμα
        hold on
        plot(x1k,x2k,'x')
        
        %Βάζουμε τις τιμές των x1,x2 στους αντιστοιχους πίνακες
        x1values(j+1) = x1k;
        x2values(j+1) = x2k;
        
        j = j + 1;
        
        k = k + 1;
        title(['Steapest Descent, γκ = 0.1, Αρχικό σημείο (8,3)', newline, 'Ο Αλγόριθμος Συγκλίνει σε ', num2str(k), ' βήματα'])
        
end