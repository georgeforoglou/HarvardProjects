%Πίνακας Συναρτήσεων f1, f2, f3
functions = {@(x) (x-2)^2 - sin(x+3), @(x) exp(-5*x) + (x+2)*cos(0.5*x)^2, @(x) x^2*sin(x+2) - (x+1)^2};

%Σταθερά ε
eps = 0.001;

%Ορισμός μηδενικού πίνακα 1Χ10 για τις δίαφορες τιμές του l
l = zeros(1,10);

%Ορισμός μηδενικού πίνακα 3Χ10 για κάθε κλήση της συνάρτησης
count = zeros(3,10);

for i = 1:3
    for j = 1:10
        
        %Άκρα διαστήματος [α,β]
        a=2;
        b=5;
        
        %Μεταβολή του l σε κάθε επανάληψη
        l(j) = eps*(2 + 1/0.5^(j));
        
        %Αλγόριθμος της Μεθόδου της Διχοτόμου
        while (b-a) >= l(j)
            x1_k = (a+b)/2 - eps;
			x2_k = (a+b)/2 + eps;
            
            %Γίνονται 2 κλήσεις της αντικειμενικής συνάρτησης σε κάθε
            %επανάληψη
			count(i,j) = count(i,j) + 2;
            
			if functions{i}(x1_k) < functions{i}(x2_k)
                b = x2_k;
			else
				a = x1_k;
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