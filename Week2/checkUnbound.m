function check=checkUnbound(c,a,n)

check=true;

for i=1:n
    if ([c(i);a(:,i)]>=0)
        disp('UNBOUNDED')
        check=false;
    end
end

end