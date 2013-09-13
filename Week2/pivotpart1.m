%% init

clc
clear
close all

%% read file

file=fopen('part5.dict','r');

m=fscanf(file,'%d',1);
n=fscanf(file,'%d',1);

B=fscanf(file,'%d',m);
N=fscanf(file,'%d',n);

b=fscanf(file,'%f',m);

a=[];
for i=1:m
    atemp=fscanf(file,'%f',n);
    a=[a;atemp'];
end

z0=fscanf(file,'%f',1);

c=fscanf(file,'%f',n);

%% processing

% check unbounded

checker=false;

for i=1:n
    if ([c(i);a(:,i)]>=0)
        disp('UNBOUNDED')
        checker=true;
    end
end

if (checker==false)
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
    
    ltemp=b./(-1*a(:,i));
    min=1;
    for j=1:m
        if (ltemp(min)<=0) 
            min=min+1;
        else break
        end
    end
    counter=min;
    for j=counter:m
        if (ltemp(j)>0 && ltemp(j)<ltemp(min))
            min=j;
        end
    end
    
    minindx=min;
    for j=1:m
        if (ltemp(j)==ltemp(min))
            if (B(j)<B(minindx))
                minindx=j;
            end
        end
    end
    
    leaving=minindx;
            
    enteringvariable=sprintf('entering: %d\n', N(i));
    disp(enteringvariable);
    leavingvariable=sprintf('leaving: %d\n', B(leaving));
    disp(leavingvariable);
            
    z=z0+ltemp(leaving)*c(i);
    objective=sprintf('objective: %f', z);
    disp(objective);        
end