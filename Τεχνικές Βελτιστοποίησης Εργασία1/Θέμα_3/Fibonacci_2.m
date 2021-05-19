%Ακολουθία Fibonacci
Fn = zeros(1, 40);

Fn(1) = 1;
Fn(2) = 1;

for i = 3 : length(Fn)
    Fn(i) = Fn(i - 1) + Fn(i - 2);
end

%Εύρος ανζήτησης l αρχικά 0.02
l=0.02;

%Πίνακας Συναρτήσεων f1, f2, f3
functions = {@(x) (x-2)^2 - sin(x+3), @(x) exp(-5*x) + (x+2)*cos(0.5*x)^2, @(x) x^2*sin(x+2) - (x+1)^2};

%Ζητάει input απο τον χρήστη, 1,2 ή 3 για f1,f2 και f3 αντίστοιχα
prompt = 'Which function you want to work with?\n';
num = input(prompt);

%Μηδενικοί πίνακες 1Χ100 για όλες τις τιμές που θα πάρουν τα άκρα a,b
a=zeros(1,100);
b=zeros(1,100);

%for loop για 4 διαφορετικές τιμές του l
for i = 1:4
   
    %Αρχικό διάστημα [a,b]=[2,5]
    a(1) = 2;
    b(1) = 5;
    
    %Για τον αριθμό επαναλήψεων που απαιτείται
    n = 1;
   
    %Αλγόριθμος Fibonacci
    while Fn(n) < (b(1) - a(1))/l
        
        n = n + 1;
        
    end 
    
    %Αρχικοποίηση x1k, x2k
    x1k = b(1) + (Fn(n - 1)/Fn(n))*(a(1) - b(1));
    x2k = a(1) + (Fn(n - 1)/Fn(n))*(b(1) - a(1));
        
    %Υπολογισμός των τιμών f(x1k), f(x2k)
    value1 = functions{num}(x1k);
    value2 = functions{num}(x2k);
        
    for k = 1:(n-2)

        if value1 < value2

            b(k + 1) = x2k;
            a(k + 1) = a(k);
            x2k = x1k;
            x1k = b(k + 1) + (Fn(n - k - 1)/Fn(n - k))*(a(k + 1) - b(k + 1));
            value2 = value1;
            value1 = functions{num}(x1k);

        else
            
            a(k + 1) = x1k;
            b(k +1) = b(k);
            x1k = x2k;
            x2k = a(k + 1) + (Fn(n - k - 1)/Fn(n - k))*(b(k + 1) - a(k + 1));
            value1 = value2;
            value2 = functions{num}(x2k);
                            
        end
        
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

