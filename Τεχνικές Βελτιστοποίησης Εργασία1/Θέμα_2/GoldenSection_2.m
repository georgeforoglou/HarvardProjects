%Πίνακας Συναρτήσεων f1, f2, f3
functions = {@(x) (x-2)^2 - sin(x+3), @(x) exp(-5*x) + (x+2)*cos(0.5*x)^2, @(x) x^2*sin(x+2) - (x+1)^2};

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

%Σταθερά αναλογίας γ
gama = 0.618;

%Για την απαρίθμιση των επαναλήψεων
k = 1;

%for loop για 4 διαφορετικές τιμές του l
for i = 1:4
    
    %x11 και x22
    x1_k = a(k) + (1 - gama)*(b(k) - a(k));
    x2_k = a(k) + gama*(b(k) - a(k));
    
    %Αλγόριρμος Χρυσού Τομέα
    while (b(k) - a(k)) >= l

        if functions{num}(x1_k) > functions{num}(x2_k)

            a(k + 1) = x1_k;
            b(k + 1) = b(k);
            x1_k = x2_k;
            x2_k = a(k + 1) + gama*(b(k + 1) - a(k + 1));

        else

            b(k + 1) = x2_k;
            a(k + 1) = a(k);
            x2_k = x1_k;
            x1_k = a(k + 1) + (1 - gama)*(b(k + 1) - a(k + 1));
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
