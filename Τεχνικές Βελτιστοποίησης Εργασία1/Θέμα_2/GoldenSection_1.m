%Πίνακας Συναρτήσεων f1, f2, f3
functions = {@(x) (x-2)^2 - sin(x+3), @(x) exp(-5*x) + (x+2)*cos(0.5*x)^2, @(x) x^2*sin(x+2) - (x+1)^2};

%Ορισμός μηδενικού πίνακα 1Χ10 για τις δίαφορες τιμές του l
l = zeros(1,10);

%Ορισμός μηδενικού πίνακα 3Χ10 για κάθε κλήση της συνάρτησης
count = zeros(3,10);

for i = 1:3
    for j = 1:10
        
        %[a,b]=[2,5] αρχικά
        a = 2;
        b = 5;

        %Σταθερά αναλογίας γ
        gama = 0.618;
        
        %Μεταβολή του l
        l(j) = 0.001*(2 + 1/0.5^(j));
        
        %x11 και x21
        x1 = a + (1 - gama)*(b - a);
        x2 = a + gama*(b - a);
        
        %Αλγόριρμος της Μεθόδου του Χρυσού Τομέα
        while (b - a) >= l(j)
            
            %Γίνονται 2 κλήσεις σε κάθε επανάληψη
            count(i,j) = count(i,j) + 2;
            
            if functions{i}(x1) > functions{i}(x2)

                a = x1;
                x1 = x2;
                x2 = a + gama*(b - a);

            else

                b = x2;
                x2 = x1;
                x1 = a + (1 - gama)*(b - a);

            end
        end
    end
end

%Τα διαγράμματα
plot(l, count(1,:))
hold on
plot(l, count(2,:))
hold on
plot(l, count(3,:))

xlabel('l')
ylabel('counts')
title('f1, f2, f3')