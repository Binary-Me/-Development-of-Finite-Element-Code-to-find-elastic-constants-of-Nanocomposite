dx=0.298025;
K_mod=K;
e=[E1,E2,E3,E4];
a=ones([1,size(E1,2)]);
v=[a,2*a,3*a,4*a];
[e,idX]=sort(e);
v=v(idX);
le=size(e,2);
count=0;
for i=9:le
    if(v(i)==1 || v(i)==2)
        true_node=2*e(i);
    else
        true_node=2*e(i)-1;
    end
    modified_node=true_node-count;
    K_mod(modified_node,:)=[];
    count=count+1;
end
K_mod=K_mod((9:end),:);
f_mod=zeros(2*n,1);
l1=size(E1,2);
for i=1:l1
    node=E1(i);
    f_mod(2*node)=0.01;
end
l2=size(E2,2);
for i=1:l2
    node=E2(i);
    f_mod(2*node)=0;
end
l3=size(E3,2);
for i=1:l3
    node=E3(i);
    f_mod(2*node-1)=-dx;
end
l4=size(E4,2);
for i=1:l4
    node=E4(i);
    f_mod(2*node-1)=dx;
end
f_u=zeros([size(K_mod,1),1]);
for i=1:l3
    true_node=2*E3(i)-1;
    f_u=f_u+(f_mod(true_node,1)*K_mod(:,true_node));
end
for i=1:l1
    true_node=2*E1(i);
    f_u=f_u+(f_mod(true_node,1)*K_mod(:,true_node));
end
f_u=-1*f_u;
count=0;
le=size(e,2);
for i=9:le
    if(v(i)==1 || v(i)==2)
        true_node=2*e(i);
    else
        true_node=2*e(i)-1;
    end
    modified_node=true_node-count;
    K_mod(:,modified_node)=[];
    count=count+1;
end
K_mod=K_mod(:,(9:end));
u_sol=inv(K_mod)*f_u;
for i=9:le
    if(v(i)==1 || v(i)==2)
        ind=2*e(i);
        p1=u_sol(1:ind-1,1);
        p2=u_sol(ind:end,1);
        if(v(i)==1)
            u_sol=[p1;0.01;p2];
        elseif(v(i)==2)
            u_sol=[p1;0;p2];
        else
        continue;
        end
    else
        ind=2*e(i)-1;
        p1=u_sol(1:ind-1,1);
        p2=u_sol(ind:end,1);
        if(v(i)==3)
            u_sol=[p1;-dx;p2];
        elseif(v(i)==4)
            u_sol=[p1;dx;p2];
        else
            continue;
        end
    end
end
u_sol=[-dx;0;-dx;0.01;dx;0.01;dx;0;u_sol];
