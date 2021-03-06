portA=9091; 
ipA='192.168.1.105'; 
portB=9091;
ipB='192.168.1.103';
portC=9091;
ipC='192.168.1.108';

BBB = xlsread('zk101.xls');
X2 = BBB(3:602,4:6)';
J2 = ones(3,2);
x2 = J2'*X2;
% x2=[1 1 1;2 2 2];
s=whos('x2');
[m,n] = size(x2);
% dbstop if error
%%做客户端，收服务器的数据
tcpipClient12 = tcpip(ipA,portA,'NetworkRole','Client');
set(tcpipClient12,'InputBufferSize',s.bytes);
% set(tcpipClient12,'Timeout',100);
fopen(tcpipClient12);
sprintf('Line12 was connected!')
for i=1:m
    answer = fread(tcpipClient12,n,'double');
    x1(:,i)=answer';
end
fclose(tcpipClient12);
sprintf('成功作为客户端！')


%%做服务器，给客户端发数据
tcpipServer21 = tcpip(ipA,portA,'NetworkRole','Server');
set(tcpipServer21,'OutputBufferSize',s.bytes);
fopen(tcpipServer21);
for i=1:m
    question = x2(i,:);
    fwrite(tcpipServer21,question(:),'double');
end
fclose(tcpipServer21);
%%%%%
tcpipServer23 = tcpip(ipC,portC,'NetworkRole','Server');
set(tcpipServer21,'OutputBufferSize',s.bytes);
fopen(tcpipServer23);
for i=1:m
    question = x2(i,:);
    fwrite(tcpipServer23,question(:),'double');
end
fclose(tcpipServer23);
sprintf('成功作为服务器！')