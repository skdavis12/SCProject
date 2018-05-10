[Ui,x,y]=implicit(40,0.01,39);
[Ue]=explicit(40,0.001,39);
[US]=steadystate(40);

maxdif_ei=max(max(abs(Ui-Ue)));
maxdif_es=max(max(abs(Ue-US)));
maxdif_is=max(max(abs(Ui-US)));