model = createpde;
vf=0.05;
r=sqrt(double(vf)/pi);
R1 = [3,4,-0.5,0.5,0.5,-0.5,-0.5,-0.5,0.5,0.5]';
C1 = [1,0,0,r]';
C1 = [C1;zeros(length(R1) - length(C1),1)];
gd = [R1,C1];
sf = 'R1+C1';
ns = char('R1','C1');
ns = ns';
gd = decsg(gd,sf,ns);
geometryFromEdges(model,gd);
figure
pdegplot(model,"FaceLabels","on","EdgeLabels","on");
mesh1=generateMesh(model,"GeometricOrder","quadratic");
[p,e,t] = meshToPet(mesh1);
E1=findNodes(mesh1,"region","Edge",2);
E2=findNodes(mesh1,"region","Edge",4);
E3=findNodes(mesh1,"region","Edge",1);
E4=findNodes(mesh1,"region","Edge",3);
Nf = findNodes(mesh1,"region","Face",2);
Nm =findNodes(mesh1,"region","Face",1);
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
plot(mesh1.Nodes(1,E4),mesh1.Nodes(2,E4),"ok","MarkerFaceColor","y")
plot(mesh1.Nodes(1,E3),mesh1.Nodes(2,E3),"ok","MarkerFaceColor","y")