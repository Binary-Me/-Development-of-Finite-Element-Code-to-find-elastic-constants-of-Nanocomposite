Ef=[1.13e+12;1.13e+12;0.186;358e+9];
Em=[3.4e+9;3.4e+9;0.34;0.75e+9];
z=1;
n=size(p,2);
N=size(t,2);
K=zeros(n*2);
for i=1:N
    conn=t(:,i);
    coords=zeros([6,2]);
    for j=1:6
        coords(j,:)=p(:,conn(j,1))';
    end
    check=check_f_or_m(Nf,Nm,conn);
    if(check=='f')
        Ke=calculateElementStiffness(coords,Ef,z);
    elseif(check=='m')
        Ke=calculateElementStiffness(coords,Em,z);
    else
        continue;
    end
    for l=1:6
        for k=1:6
            nodei=conn(l);
            nodej=conn(k);
            K([2*nodei-1,2*nodei],[2*nodej-1,2*nodej])=Ke([2*l-1,2*l],[2*k-1,2*k]);
        end
    end
end



