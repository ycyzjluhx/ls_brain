band=13:20;
Cpli=[];Cx=[];O=[];
for i=1:numel(FT)
    out=tensor_connectivity3(FT{1,i}{4},FT{1,i}{2},FT{1,i}{3},band);
%     out=tensor_connectivity2(FT{1,i}{4},FT{1,i}{2},band);
%     out=mean(out,3);
    out=mean(out(:,:,band),3);
    O(i)=mean(mean(out));
    Cx(:,:,i)=topoconn_av2(FT,out,i,1,freq,band,0,0);  
%     Cpli(:,:,i)=ls_pli(Ys{i},band,0);
end

Cb=[1:10];
Cs=[11:20];
Pb=[21:30];
Ps=[31:40];
cc='auto'; 
cc=[0 30];
ll=[10 30 50];
kk={'front' 'central' 'back'};

figure,
subplot(2,2,1),imagesc(squeeze(mean(Cx(:,:,Cb),3))),title('C-b'),caxis(cc),set(gca,'Xtick',ll),set(gca,'Xticklabels',kk),set(gca,'Ytick',ll),set(gca,'Yticklabels',kk),
subplot(2,2,2),imagesc(squeeze(mean(Cx(:,:,Cs),3))),title('C-s'),caxis(cc),set(gca,'Xtick',ll),set(gca,'Xticklabels',kk),set(gca,'Ytick',ll),set(gca,'Yticklabels',kk),
subplot(2,2,3),imagesc(squeeze(mean(Cx(:,:,Pb),3))),title('P-b'),caxis(cc),set(gca,'Xtick',ll),set(gca,'Xticklabels',kk),set(gca,'Ytick',ll),set(gca,'Yticklabels',kk),
subplot(2,2,4),imagesc(squeeze(mean(Cx(:,:,Ps),3))),title('P-s'),caxis(cc),set(gca,'Xtick',ll),set(gca,'Xticklabels',kk),set(gca,'Ytick',ll),set(gca,'Yticklabels',kk),
% 
% figure,
% subplot(2,2,1),imagesc(squeeze(mean(Cpli(:,:,Cb),3))),title('C-b'),caxis(cc),set(gca,'Xtick',ll),set(gca,'Xticklabels',kk),set(gca,'Ytick',ll),set(gca,'Yticklabels',kk),
% subplot(2,2,2),imagesc(squeeze(mean(Cpli(:,:,Cs),3))),title('C-s'),caxis(cc),set(gca,'Xtick',ll),set(gca,'Xticklabels',kk),set(gca,'Ytick',ll),set(gca,'Yticklabels',kk),
% subplot(2,2,3),imagesc(squeeze(mean(Cpli(:,:,Pb),3))),title('P-b'),caxis(cc),set(gca,'Xtick',ll),set(gca,'Xticklabels',kk),set(gca,'Ytick',ll),set(gca,'Yticklabels',kk),
% subplot(2,2,4),imagesc(squeeze(mean(Cpli(:,:,Ps),3))),title('P-s'),caxis(cc),set(gca,'Xtick',ll),set(gca,'Xticklabels',kk),set(gca,'Ytick',ll),set(gca,'Yticklabels',kk),
% % 
% for i=1:size(Cx,1)
%     for j=1:size(Cx,2)
%         [hB(i,j) pB(i,j)]=ttest2(Cx(i,j,Cb),Cx(i,j,Pb),'tail','right','alpha',0.05);
%     end
% end
% figure,imagesc(hB),set(gca,'Xtick',ll),set(gca,'Xticklabels',kk),set(gca,'Ytick',ll),set(gca,'Yticklabels',kk),
