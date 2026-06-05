clear all
clc
f=@(x) -x(1)-2*x(2);
[xmin,fmin]=fmincon(f,[0;0],[],[],[],[],[],[],@G1)
j=0;
c=[-1;-2];
B=[1 0;-1 0;0 1;0 -1];
b=[3;2;5;2];
%y=[0;1];
A1=[];
a1=[];
ww=[];
ff=[];
 while 1
    j=j+1;
    B=[B;A1];
    b=[b;a1];
    [xsave,fsave]=linprog(c,B,b);
    w=xsave;
    w1=w(1,:);
    w2=w(2,:);
    e=fmin-fsave;
    ww(j,:)=j;
    ff(j,:)=e;
    hold on
    plot(ww,ff,'b--*')
    xlabel('iteration=');
    ylabel('fmin-f');
    f1=w1^6-2*w1-w2;
    f2=-w1+w2-2;
    if f1<=0 && f2<=0
        disp('iteration=')
        disp(j)
        disp('Absolute Error=')
        disp(abs(e))
        disp('xmin=')
        disp(w)
        disp('fmin=')
        disp(fsave)
        break
    else
        if f1>=f2
            H=grad(@cons1_1,w);
            A1=H';
            a1=-f1+A1*w;
        else
            H=grad(@cons1_2,w);
            A1=H';
            a1=-f2+A1*w;
        end
    end
 end