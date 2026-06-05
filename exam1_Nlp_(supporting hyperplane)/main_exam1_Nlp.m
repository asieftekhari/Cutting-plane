clear all
clc
f=@(x) -x(1)-2*x(2);
[xmin,fmin]=fmincon(f,[0;0],[],[],[],[],[],[],@G1)
j=0;
c=[-1;-2];
B=[1 0;-1 0;0 1;0 -1];
b=[3;2;5;2];
y=[0;1];
A1=[];
a1=[];
ww=[];
ff=[];
 while 1
    j=j+1
    B=[B;A1];
    b=[b;a1];
    [xsave,fsave]=linprog(c,B,b)
    w=xsave;
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
        if w1<=y(1,:)
            t=w1:0.001:y(1,:);
        else
            t=y(1,:):0.001:w1;
        end
        m=(y(2,:)-w2)/(y(1,:)-w1);
        F=m*(t-w1)+w2;
        k1=t.^6-2*t;
        k2=t+2;
        [u11,u21]=intersections(t,F,t,k1,1);
        u1=[u11;u21];
        [u12,u22]=intersections(t,F,t,k2,1);
        u2=[u12;u22];
        if 1~=isempty(u1)
            u=u1;
            H=grad(@cons1_1,u);
            A1=H';
            a1=A1*u;
        elseif 1~=isempty(u2)
            u=u2;
            H=grad(@cons1_2,u);
            A1=H';
            a1=A1*u;
        elseif 1==isempty(u1)  && 1==isempty(u2)
                B(end,:)=[];
                b(end)=[];
                [xsave,fsave]=linprog(c,B,b);
                e1=fmin-fsave;
                disp('iter=')
                disp(j-1)
                disp('Absolute Error=')
                disp(abs(e1))
                disp('xmin=')
                disp(xsave)
                disp('fmin=')
                disp(fsave)
                disp('error')
                break
        end
    end
 end