function check=check_f_or_m(Nf,Nm,conn)
    l=size(conn,1)-1;
    nf=size(Nf,2);
    nm=size(Nm,2);
    fs=0;
    ms=0;
    for i=1:l
        for j=1:nf
            if(conn(i)==Nf(j))
                fs=fs+1;
            end
        end
        for k=1:nm
            if(conn(i)==Nm(k))
                ms=ms+1;
            end
        end
    end
    if(fs==6)
        check='f';
    elseif(ms==6)
        check='m';
    else
        check='e';
    end
end




    



    
