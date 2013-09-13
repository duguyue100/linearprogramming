%% init

clc
clear
close all

%% read data

file=fopen('part5.dict','r');

m=fscanf(file,'%d',1);
n=fscanf(file,'%d',1);

B=fscanf(file,'%d',m);
N=fscanf(file,'%d',n);

b=fscanf(file,'%f',m);

a=zeros(m,n);
for i=1:m
    atemp=fscanf(file,'%f',n);
    a(i,:)=atemp';
end

z0=fscanf(file,'%f',1);

c=fscanf(file,'%f',n);

%% processing

countPivot=0;

% check unbound and reach the goal

while (checkGoal(c,n)==false)
    if (checkUnbound(c,a,n))
    countPivot=countPivot+1;
    
    % select entering variable
    min=1;
    for j=1:n
        if (c(min)<=0) 
            min=min+1;    
        else break
        end
    end
    counter=min;
    for j=counter:n
        if (c(j)>0 && N(j)<N(min))
            min=j;
        end
    end
    i=min;
    % select entering variable
    
    % select leaving variable
    ltemp=b./(-1*a(:,i));
    minx=1;
    for j=1:m
        if (ltemp(minx)<0 || (ltemp(minx)==0 && a(j,i)>0)) 
            minx=minx+1;
        else break
        end
    end
    counter=minx;
    for j=counter:m
        if (ltemp(j)>=0 && a(j,i)<0 && ltemp(j)<ltemp(minx))
            minx=j;
        end
    end
    
    minindx=minx;
    for j=1:m
        if (ltemp(j)==ltemp(minx))
            if (B(j)<B(minindx))
                minindx=j;
            end
        end
    end
    
    leaving=minindx;
    % select leaving variable
    
    enteringIndex=N(i);
    leavingIndex=B(leaving);
    
    % update objective value
    z0=z0+ltemp(leaving)*c(i);
    
    % update objective function (don't forget about index)
    
    coeff=-1*a(leaving,i);
    sub=a(leaving,:);
    sub(i)=-1;
    sub=sub/coeff;
    
    subobjective=sub*c(i);
    c(i)=0;
    c=c+subobjective';
    
    % update constraints (don't forget about index)
    
    for j=1:m
        if (j~=leaving)
            b(j)=b(j)+ltemp(leaving)*a(j,i);
            subrow=sub*a(j,i);
            a(j,i)=0;
            a(j,:)=a(j,:)+subrow;
        end
    end
    
    b(leaving)=ltemp(leaving);
    a(leaving,:)=sub;
    
%     disp('entering index');
%     disp(enteringIndex);
%     disp('leaving index');
%     disp(leavingIndex);
    
    N(i)=leavingIndex;
    B(leaving)=enteringIndex;
    end
end
disp('objective');
disp(z0);
disp('number of pivot');
disp(countPivot);












