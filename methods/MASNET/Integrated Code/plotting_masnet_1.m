% load Probs_CORRSHD_TS_0_TE_0_Num_Sensors_96_SepTar_50_50_Pt_-43dBW_sigma_9dB.mat
% pfa=0.01:0.01:0.1;
% idx=5;
% figure
% hold on
% plot(pfa,psep_d(idx,:))
% plot(pfa,pdiv_d(idx,:),'r')
% plot(pfa,pbest_d(idx,:),'g')
% xlabel('Probability false alarm')
% ylabel('Probability of detection')
% title('Separated - Urban - Pt:-43dBW - SxF:5')
cd C:\Users\Loukianos\Documents\MATLAB\ls_brain\results\masnet\probs\

load Pr_ofdm_final_Time_1_TS_0_TE_0_Num_Sensors_100_Pt_-43dBW_sigma_9dB
idx=1;
ff=1;
sens=(1:100);
figure
hold on
% errorbar(sens,pall_av(:,idx),pall_std(:,idx),'b')
% errorbar(sens,pbsens_av(:,idx),pbsens_std(:,idx),'r')
% errorbar(sens,pmean_av(:,idx),pmean_std(:,idx),'m')
% errorbar(sens,psum_av(:,idx),psum_std(:,idx),'g')

plot(sens,pbsens_av(:,idx),'r','Linewidth',2)
plot(sens,pbsens_av_old(:,idx),'g','Linewidth',2)


figure,
load Probs_CORRSHD_TS_1_TE_0_Num_Sensors_96_SepTar_500_500_Pt_-23dBW_sigma_9dB.mat
errorbar(sens,pall_av(:,idx),pall_std(:,idx),'b')
errorbar(sens,pbsens_av(:,idx),pbsens_std(:,idx),'r')
errorbar(sens,pmean_av(:,idx),pmean_std(:,idx),'m')
errorbar(sens,psum_av(:,idx),psum_std(:,idx),'g')
xlim([1 96])
set(gca,'Xtick',0:4:97)
set(gca,'XtickLabel',(0:4:97)*ff)
xlabel('Number of Sensors'), ylabel('Probability of detection')
title('Fc:1 - Pt:-33dbW - pfa:0.01')
legend({'Sep:agnostic' 'Sep:fusion' 'Sep:best1' 'Sep:optimal' 'Mix:agnostic' 'Mix:fusion' 'Mix:best1' 'Mix:optimal'})
legend boxoff

load Probs_CORRSHD_TS_0_TE_0_Num_Sensors_96_SepTar_50_50_Pt_-33dBW_sigma_9dB.mat
figure
hold on
for i=1:96
    plot(pfa,pdiv_d(i,:))
end
xlim([0.01 0.1])
xlabel('Probability of false alarm')
ylabel('Probability of detection')
title('fusion - ROC - Pt:-43dbW - Separated - Urban')
legend({'1 sensor' '2 sensors' '...'},'Location','southeast')
legend boxoff


load Probs_CORRSHD_TS_1_TE_0_Num_Sensors_96_SepTar_500_500_Pt_-33dBW_sigma_9dB.mat
figure
hold on
for i=1:96
    plot(pfa,pdiv_d(i,:))
end
xlim([0.01 0.1])
xlabel('Probability of false alarm')
ylabel('Probability of detection')
title('ROC - Pt:-33dbW - Mixed - Urban')
legend({'1 sensor' '2 sensors' '...'},'Location','southeast')
legend boxoff

figure
hold on
idxs=10;
idxpfa=1;
load Probs_CORRSHD_TS_0_TE_0_Num_Sensors_96_SepTar_50_50_Pt_-23dBW_sigma_9dB.mat
ps1=pdiv_d(idxs,idxpfa);
load Probs_CORRSHD_TS_0_TE_0_Num_Sensors_96_SepTar_50_50_Pt_-33dBW_sigma_9dB.mat
ps2=pdiv_d(idxs,idxpfa);
load Probs_CORRSHD_TS_0_TE_0_Num_Sensors_96_SepTar_50_50_Pt_-43dBW_sigma_9dB.mat
ps3=pdiv_d(idxs,idxpfa);
load Probs_CORRSHD_TS_0_TE_0_Num_Sensors_96_SepTar_50_50_Pt_-53dBW_sigma_9dB.mat
ps4=pdiv_d(idxs,idxpfa);
load Probs_CORRSHD_TS_1_TE_0_Num_Sensors_96_SepTar_500_500_Pt_-23dBW_sigma_9dB.mat
pm1=pdiv_d(idxs,idxpfa);
load Probs_CORRSHD_TS_1_TE_0_Num_Sensors_96_SepTar_500_500_Pt_-33dBW_sigma_9dB.mat
pm2=pdiv_d(idxs,idxpfa);
load Probs_CORRSHD_TS_1_TE_0_Num_Sensors_96_SepTar_500_500_Pt_-43dBW_sigma_9dB.mat
pm3=pdiv_d(idxs,idxpfa);
load Probs_CORRSHD_TS_1_TE_0_Num_Sensors_96_SepTar_500_500_Pt_-53dBW_sigma_9dB.mat
pm4=pdiv_d(idxs,idxpfa);
bar([ps1 ps2 ps3 ps4;pm1 pm2 pm3 pm4]')
set(gca,'Xtick',1:4)
set(gca,'XtickLabel',{'-23' '-33' '-43' '-53'})
xlabel('Transmitted power (dBw)')
ylabel('Probability of detection')
title('fusion - Sensors:10 - pfa:0.01')
legend({'separated' 'mixed'})
legend boxoff

figure
hold on
idxs=50;
idxpfa=1;
load Probs_CORRSHD_TS_0_TE_0_Num_Sensors_96_SepTar_50_50_Pt_-23dBW_sigma_9dB.mat
ps1=pdiv_d(idxs,idxpfa);
load Probs_CORRSHD_TS_0_TE_0_Num_Sensors_96_SepTar_50_50_Pt_-33dBW_sigma_9dB.mat
ps2=pdiv_d(idxs,idxpfa);
load Probs_CORRSHD_TS_0_TE_0_Num_Sensors_96_SepTar_50_50_Pt_-43dBW_sigma_9dB.mat
ps3=pdiv_d(idxs,idxpfa);
load Probs_CORRSHD_TS_0_TE_0_Num_Sensors_96_SepTar_50_50_Pt_-53dBW_sigma_9dB.mat
ps4=pdiv_d(idxs,idxpfa);
load Probs_CORRSHD_TS_1_TE_0_Num_Sensors_96_SepTar_500_500_Pt_-23dBW_sigma_9dB.mat
pm1=pdiv_d(idxs,idxpfa);
load Probs_CORRSHD_TS_1_TE_0_Num_Sensors_96_SepTar_500_500_Pt_-33dBW_sigma_9dB.mat
pm2=pdiv_d(idxs,idxpfa);
load Probs_CORRSHD_TS_1_TE_0_Num_Sensors_96_SepTar_500_500_Pt_-43dBW_sigma_9dB.mat
pm3=pdiv_d(idxs,idxpfa);
load Probs_CORRSHD_TS_1_TE_0_Num_Sensors_96_SepTar_500_500_Pt_-53dBW_sigma_9dB.mat
pm4=pdiv_d(idxs,idxpfa);
bar([ps1 ps2 ps3 ps4;pm1 pm2 pm3 pm4]')
set(gca,'Xtick',1:4)
set(gca,'XtickLabel',{'-23' '-33' '-43' '-53'})
xlabel('Transmitted power (dBw)')
ylabel('Probability of detection')
title('Sensors:50 - pfa:0.01')
legend({'separated' 'mixed'})
legend boxoff























