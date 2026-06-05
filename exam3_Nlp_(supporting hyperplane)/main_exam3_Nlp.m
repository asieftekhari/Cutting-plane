clear all
clc
format long
f=@(x) x(1)-2*x(2);
[xmin,fmin]=fmincon(f,[0;0],[],[],[],[],[],[],@G3)
j=0;
c=[1;-2];
B=[1 0;-1 0;0 1;0 -1];
b=[10;15;30;15];
y=[1;1];
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
    fprintf('maximum error : %e\2',emax_err)
    fprintf('norm2 error :%e\2',e2_err)
    ww(j,:)=j;
    ff(j,:)=e;
    hold on
    plot(ww,ff,'b--*')
    xlabel('iteration');
    ylabel('fmin-fiter');
    f1=2.^(-w1)-w2-1;
    f2=2*w1+w2-10;
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
        if w1<=y(1,:)
            t=[w1:0.01:y(1,:)];
        else
            t=[y(1,:):0.01:w1];
        end
        m=(y(2,:)-w2)/(y(1,:)-w1);
        F=m*(t-w1)+w2;
        k1=2.^(-t)-1;
        k2=-2*t+10;
        [u11,u21]=intersections(t,F,t,k1,1);
        u1=[u11;u21];
        [u12,u22]=intersections(t,F,t,k2,1);
        u2=[u12;u22];
        if 1~=isempty(u1)
            u=u1;
            H=grad(@cons3_1,u);
            A1=H';
            a1=A1*u;
        else
            u=u2;
            H=grad(@cons3_2,u);
            A1=H';
            a1=A1*u;
        end
    end
 end