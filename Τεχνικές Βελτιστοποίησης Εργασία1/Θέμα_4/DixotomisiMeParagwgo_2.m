%Ορίζουμε τις f1,f2,f3 με την εντολή syms για να μπορούμε να
%χρησιμοποιήσουμε την εντολή diff(function,'x') για τον υπολογισμό των
%παραγώγων τους
syms x
f1 = (x-2)^2 - sin(x+3);
f2 = exp(-5*x) + (x+2)*cos(0.5*x)^2;
f3 = x^2*sin(x+2) - (x+1)^2;

%Πίνακας Συναρτήσεων f1, f2, f3
functions = [f1 f2 f3];

%Ζητάει input απο τον χρήστη, 1,2 ή 3 για f1,f2 και f3 αντίστοιχα
prompt = 'Which function you want to work with?\n';
num = input(prompt);

%Εύρος ανζήτησης l αρχικά 0.02
l=0.02;

%Μηδενικοί πίνακες 1Χ1000 για όλες τις τιμές που θα πάρουν τα άκρα a,b
a=zeros(1,1000);
b=zeros(1,1000);

%Αρχικό διάστημα [a,b]=[2,5]
a(1) = 2;
b(1) = 5;

%Για την απαρίθμιση των επαναλήψεων
k = 1;

%for loop για 4 διαφορετικές τιμές του l
for i = 1:4
    
    %Αλγόριθμος Διχοτόμισης με χρήση Παραγώγου
    n = 1;
    k = 1;
    
    while 0.5^n > l/3
        
        n = n + 1;
        
    end
        
    while k ~= n
            
        x_k = (a(k) + b(k))/2;
        
        %Υπολογισμός παραγώγου της συνάρτησης...
        Df(x) = diff(functions(num), 'x');
        
        %... στο σημείο xk
        Df_xk = Df(x_k);
            
        if Df_xk > 0
            b(k + 1) = x_k;
            a(k + 1) = a(k);
        elseif Df_xk < 0
            a(k + 1) = x_k;
            b(k + 1) = b(k);
        end
        
        k = k + 1;
        
    end
    
    %Ένα διάγραμμα για κάθε περίπτωση του l
    subplot(2,2,i);
    plot(a(1,1:k))
    hold on 
    plot(b(1,1:k))
    
    title(['l = ' num2str(l)]);
    ylabel('a(k), b(k)');
    xlabel('k')
    
    %Μεταβολή του l
    l = l/2;
end