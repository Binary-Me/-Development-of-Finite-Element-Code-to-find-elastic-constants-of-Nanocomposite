function c_e=check_element(conn,E1,E2)
    c_e=0;
    for j=1:6
        check=check_edge(conn(j),E1,E2);
        c_e=c_e+check;
    end
end
    