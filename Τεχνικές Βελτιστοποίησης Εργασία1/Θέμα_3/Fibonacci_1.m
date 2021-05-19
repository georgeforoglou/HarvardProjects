%Ακολουθία Fibonacci
Fn = zeros(1, 40);
Fn(1) = 1;
Fn(2) = 1;
for i = 3 : length(Fn)
    Fn(i) = Fn(i - 1) + Fn(i - 2);
end

%Πίνακας Συναρτήσεων f1, f2, f3
functions = {@(x) (x-2)^2 - sin(x+3), @(x) exp(-5*x) + (x+2)*cos(0.5*x)^2, @(x) x^2*sin(x+2) - (x+1)^2};

%Ορισμός μηδενικού πίνακα 1Χ10 για 10 διαφορετικές τιμές του l
l = zeros(1,10);

%Ορισμός μηδενικού πίνακα 3Χ10 για κάθε κλήση της αντικειμενικής συνάρτησης
count = zeros(3,10);


 for i = 1:3  
    for j = 1:10
        %Για τον αριθμό επαναλήψεων που απαιτείται
        n = 1;
        
        %Άκρα διαστήματος [α,β]
        a = 2;
        b = 5;
        
        %Μεταβολή του l σε κάθε επανάληψη
        l(j) = 0.001*(2 + 1/0.5^(j));

        %Αλγόριθμος Fibonacci
        while Fn(n) < (b - a)/l(j)
            n = n + 1;
        end 
        
        %Αρχικοποίηση x1k, x2k
        x1k = b + (Fn(n - 1)/Fn(n))*(a - b);
        x2k = a + (Fn(n - 1)/Fn(n))*(b - a);
        
        %Υπολογισμός των f(x1k), f(x2k)
        value1 = functions{i}(x1k);
        value2 = functions{i}(x2k);
        
        %Έγιναν ήδη 2 κλήσεις της αντικειμενικής συνάρτησης για τον
        %υπολογισμό των value1 και value2
        count(i,j) = 2;
        
        for k = 1:(n-2)

            %Γίνονται 2 κλήσεις της αντικειμενικής συνάρτησης
            count(i,j) = count(i,j) + 1;

            if value1 < value2

                b = x2k;
                x2k = x1k;
                x1k = b + (Fn(n - k - 1)/Fn(n - k))*(a - b);                   
                value2 = value1;
                value1 = functions{i}(x1k);

            else
             
                a= x1k;
                x1k = x2k;
                x2k = a + (Fn(n - k - 1)/Fn(n - k))*(b - a);
                value1 = value2;
                value2 = functions{i}(x2k);
             
            end
         
        end
        
    end
 end
        


%Tα διαγράμματα για f1, f2 και f3
plot(l, count(1,:))
hold on
plot(l, count(2,:))
hold on
plot(l, count(3,:))

xlabel('l')
ylabel('counts')
title('f1, f2, f3')


