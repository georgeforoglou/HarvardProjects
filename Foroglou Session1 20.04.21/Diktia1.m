load EchoRequest.csv
load ACK.csv
load ACK_retrans.csv
%G1
figure
bar(EchoRequest)
xlabel('Number of packages')
ylabel('Response Time (ms)')
title(['22/04/21-19:27 E2283'])
%G2
figure
bar(ACK)
xlabel('Number of packages')
ylabel('Response Time of successful sending (ms)')
title(['20/04/21-13:36 Q3168 R8440'])
%G3
y = ACK_retrans;
figure
histogram(y)
xlabel('Number of repetitions')
ylabel('Number of packages')
title(['20/04/21-13:36 Q3168 R8440'])
