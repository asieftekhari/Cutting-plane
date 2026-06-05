clear all
clc
f=@(x) x(1)-x(2);
[xmin,fmin]=fmincon(f,[0;0],[],[],[],[],[],[],@G2)
j=0;
c=[1;-1];
B=[1 0;-1 0;0 1;0 -1];
b=[3;2;5;2];
%y=[0;0.5];
A1=[];
a1=[];
ww=[];
ff=[];
 while 1
    j=j+1
    B=[B;A1];
    b=[b;a1];
    [xsave,fsave]=linprog(c,B,b);
    w=xsave
    w1=w(1,:);
    w2=w(2,:);
    e=fmin-fsave;
    e0=abs(xmin-xsave);
    emax_err=max(e0);
    e2_err=norm(e0,2);
    fprintf('maximum error : %e\n',emax_err)
    fprintf('norm2 error :%e\n',e2_err)
    ww(j,:)=j;
    ff(j,:)=e;
    hold on
    plot(ww,ff,'b--*')
    xlabel('iteration');
    ylabel('fmin-fiter');
    f1=w1^2-w(2);
    f2=-0.5*w1+w2-1;
    if f1<=0 && f2<=0
        disp('iter=')
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
            H=grad(@cons2_1,w);
            A1=H';
            a1=-f1+A1*w;
        else
            H=grad(@cons2_2,w);
            A1=H';
            a1=-f2+A1*w;
        end
    end
 end