function check=check_edge(n,E1,E2)
    l1=size(E1,2);
    check=0;
    for i=1:l1
        if(n==E1(i))
            check=1;
            break;
        elseif(n==E2(i))
            check=1;
            break;
        else
            continue;
        end
    end
end