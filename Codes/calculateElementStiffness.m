% Element stiffness matrix calculation function
function Ke = calculateElementStiffness(coords, E, t)
    % Gauss quadrature points and weights
    gp = [1/6, 1/6, 2/3; 1/6, 2/3, 1/6];
    w = [1/6 1/6 1/6]; 
    
    % D Matrix - Constitutive Relations
    D=D_matrix(E);
    
    % Element stiffness matrix
    Ke = zeros(12);
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
        % Element stiffness matrix contribution
        Ke = Ke + B' * D * B * detJ * t * w(i);
    end
end