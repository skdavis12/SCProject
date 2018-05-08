Dif(1)=max(max(abs(Ue_5-Ue_5exact)));
Dif(1)=max(max(abs(Ue_10-Ue_10exact)));
Dif(3)=max(max(abs(Ue_15-Ue_15exact)));
Dif(4)=max(max(abs(Ue_20-Ue_20exact)));
Dif(5)=max(max(abs(Ue_25-Ue_25exact)));
Dif(6)=max(max(abs(Ue_30-Ue_30exact)));
Dif(7)=max(max(abs(Ue_35-Ue_35exact)));
Dif(8)=max(max(abs(Ue_40-Ue_40exact)));
Dif(10)=max(max(abs(Ue_50-Ue_50exact)));
Dif(11)=max(max(abs(Ue_60-Ue_60exact)));
Dif(12)=max(max(abs(Ue_70-Ue_70exact)));
Dif(13)=max(max(abs(Ue_80-Ue_80exact)));
Dif(14)=max(max(abs(Ue_90-Ue_90exact)));

xlswrite('gc_e_ms.xlsx',Dif,'B2:B15');