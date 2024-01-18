avg_strain=0;
avg_stress=0;
stress_edge3=0;
for m=1:N
    conn=t(:,m);
    coords=zeros([6,2]);
    for j=1:6
        coords(j,:)=p(:,conn(j,1))';
    end
    check=check_f_or_m(Nf,Nm,conn);
    if(check=='f')
        D=D_matrix(Ef);        

    elseif(check=='m')
        D=D_matrix(Em);
    else
        continue;
    end
    ue=[];
    for j=1:6
        node=conn(j);
        ind=2*node-1;
        ue=[ue;u_sol(ind);u_sol(ind+1)];
    end
    gp = [1/6, 1/6, 2/3; 1/6, 2/3, 1/6];
    w = [1/6 1/6 1/6];
    strain_e=zeros([3,1]);
    for i = 1:size(gp, 2)
        X1 = gp(1, i);
        X2 = gp(2, i);
        
        % Shape functions and derivatives
        N1 = (1-X1-X2)*(1-2*X1-2*X2);
        N2 = X1*(2*X1-1);
        N3 = X2*(2*X2-1);
        N4 = 4*X1*(1-X1-X2);
        N5 = 4*X1*X2;
        N6 = 4*X2*(1-X1-X2);
        
        dN1_dX1 = 4*X1+4*X2-3;
        dN1_dX2 = 4*X1+4*X2-3;
        dN2_dX1 = 4*X1-1;
        dN2_dX2 = 0;
        dN3_dX1 = 0;
        dN3_dX2 = 4*X2-1;
        dN4_dX1 = 4-8*X1-4*X2;
        dN4_dX2 = -4*X1;
        dN5_dX1 = 4*X2;
        dN5_dX2 = 4*X1;
        dN6_dX1 = -4*X2;
        dN6_dX2 = 4-4*X1-8*X2;
        
        % Jacobian matrix
        J = [dN1_dX1, dN2_dX1, dN3_dX1, dN4_dX1, dN5_dX1, dN6_dX1; dN1_dX2, dN2_dX2, dN3_dX2, dN4_dX2, dN5_dX2, dN6_dX2] * coords;
        
        % Determinant of the Jacobian matrix
        detJ = abs(det(J));
        
        % Inverse of the Jacobian matrix
        invJ = inv(J);

        % B matrix (strain-displacement matrix)
        P=[dN1_dX1, 0, dN2_dX1, 0, dN3_dX1, 0, dN4_dX1, 0, dN5_dX1, 0, dN6_dX1, 0; dN1_dX2, 0, dN2_dX2, 0, dN3_dX2, 0, dN4_dX2, 0, dN5_dX2, 0, dN6_dX2, 0; 0, dN1_dX1, 0, dN2_dX1, 0, dN3_dX1, 0, dN4_dX1, 0, dN5_dX1, 0, dN6_dX1; 0 , dN1_dX2, 0, dN2_dX2, 0, dN3_dX2, 0, dN4_dX2, 0, dN5_dX2, 0, dN6_dX2];
        G=[invJ(1,1), invJ(1,2), 0 , 0 ; 0 , 0 , invJ(2,1), invJ(2,2); invJ(2,1), invJ(2,2), invJ(1,1), invJ(1,2)];
        B = G*P;
        strain_e=strain_e+(B*ue*detJ * z * w(i));               
    end
    Ae=abs(polyarea(coords(:,1),coords(:,2)));
    avg_strain=avg_strain+(strain_e*Ae*z);
    stress_e=D*strain_e;
    avg_stress=avg_stress+(stress_e*Ae*z);
    if(check_element(conn,E3,E4)~=0)
        stress_edge3=stress_edge3+stress_e;
    end
end
disp("Young's Modulus")
avg_stress=abs(avg_stress);
avg_strain=abs(avg_strain);
disp(avg_stress(1)/avg_strain(1));