model = createpde;
vf=0.05;
r=sqrt(double(vf)/(2*pi));
R1 = [3,4,-0.5,0.5,0.5,-0.5,-0.5,-0.5,0.5,0.5]';
C0 = [1,0,0,r]';
C1 = [1,-0.5,-0.5,r]';
C2 = [1,0.5,-0.5,r]';
C3 = [1,0.5,0.5,r]';
C4 = [1,-0.5,0.5,r]';
C0 = [C0;zeros(length(R1) - length(C0),1)];
C1 = [C1;zeros(length(R1) - length(C1),1)];
C2 = [C2;zeros(length(R1) - length(C2),1)];
C3 = [C3;zeros(length(R1) - length(C3),1)];
C4 = [C4;zeros(length(R1) - length(C4),1)];
gd = [R1,C0,C1,C2,C3,C4];
sf = 'R1+C0+C1+C2+C3+C4';
ns = char('R1','C0','C1','C2','C3','C4');
ns = ns';
gd = decsg(gd,sf,ns);
geometryFromEdges(model,gd);
pdegplot(model,"FaceLabels","on","EdgeLabels","on");
mesh1=generateMesh(model,"GeometricOrder","quadratic");
[p,e,t] = meshToPet(mesh1);
E1=findNodes(mesh1,"region","Edge",[4,5,6]);
E2=findNodes(mesh1,"region","Edge",[8,7,9]);
E3=findNodes(mesh1,"region","Edge",[1,2,3]);
E4=findNodes(mesh1,"region","Edge",[10,11,12]);
Nf = findNodes(mesh1,"region","Face",[4,5,7,8,10]);
Nm=findNodes(mesh1,"region","Face",1);
figure
pdemesh(model)
hold on
plot(mesh1.Nodes(1,Nf),mesh1.Nodes(2,Nf),"ok","MarkerFaceColor","g");
figure
pdemesh(model)
hold on
plot(mesh1.Nodes(1,Nm),mesh1.Nodes(2,Nm),"ok","MarkerFaceColor","r");
figure
pdemesh(model)
hold on
plot(mesh1.Nodes(1,E1),mesh1.Nodes(2,E1),"ok","MarkerFaceColor","m")
plot(mesh1.Nodes(1,E2),mesh1.Nodes(2,E2),"ok","MarkerFaceColor","m")
figure
pdemesh(model)
hold on
plot(mesh1.Nodes(1,E3),mesh1.Nodes(2,E3),"ok","MarkerFaceColor","y")
plot(mesh1.Nodes(1,E4),mesh1.Nodes(2,E4),"ok","MarkerFaceColor","y")