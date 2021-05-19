%Πίνακας Συναρτήσεων f1, f2, f3
functions = {@(x) (x-2)^2 - sin(x+3), @(x) exp(-5*x) + (x+2)*cos(0.5*x)^2, @(x) x^2*sin(x+2) - (x+1)^2};

%Εύρος ανζήτησης l
l=0.01;

%Ορισμός μηδενικού πίνακα 1Χ10 για τις δίαφορες τιμές της σταθεράς ε
eps = zeros(1,10);

%Οριζμός μηδενικού πίνακα 3Χ10 για κάθε κλήση της συνάρτησης
count = zeros(3,10);

for i = 1:3
	for j = 1:10
        
        %Άκρα του διαστήματος [a,b]
        a=2;
        b=5;
        
        %Μεταβολή του ε σε κάθε επανάληψη
		eps(j) = l*(0.5 - 0.5^(j));
        
        %Αλγόριθμος της Μεθόοδυ της Διχοτόμου
		while (b-a) >= l
			x1_k = (a+b)/2 - eps(j);
			x2_k = (a+b)/2 + eps(j);
            
            %Γίνονται 2 κλήσεις τη f σε κάθε επανάληψη
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
plot(eps, count(1,:))
hold on
plot(eps, count(2,:))
hold on
plot(eps, count(3,:))

xlabel('epsilon')
ylabel('counts')
title('f1, f2, f3')