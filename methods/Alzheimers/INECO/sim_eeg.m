
ch=128;
freqs=15;
ep=5;
tr=50;
clear j xf xch xep PC0 PC7 FC0 FC7
Y=0;
nsource=5;
Options=.001;
for si=1:nsource
    xf(:,si)=randn(freqs,1)+j*randn(freqs,1);
    xch(:,si)=randn(ch,1)+j*randn(ch,1);
    xep(:,si)=randn(ep,1)+j*randn(ep,1);
    xtr(:,si)=exp(-j*rand(tr,1));
%      xtr(:,si)=rand(tr,1);
    if si<6
        for ti=1:128
            for tj=1:128
%                 G{si}(ti,tj)=1/(abs(xch(ti,si))-abs(xch(tj,si)));
                G{si}(ti,tj)=1/norm(angle(xch(ti,si))-angle(xch(tj,si)))^2;
%                  G{si}(ti,tj)=1/norm(abs(xch(ti,si))-abs(xch(tj,si)));
                
            end
        end
        % %         G{si}=sign(angle(xch(:,si))*angle(xch(:,si))');
%         G{si}(isnan(G{si})==1)=1;
        
        G{si}(eye(128)==1)=0;
%         G{si}=(weight_conversion(G{si},'normalize'));
        
    end
    temp=tprod(xf(:,si),[1 -2],xch(:,si),[2 -2]);
    temp=tprod(temp,[1 2 -3],xep(:,si),[3 -3]);
    S=tprod(temp,[1 2 3 -4],xtr(:,si),[4 -4]);
    Y=Y+S;
end
Y=Y+0*randn(freqs,ch,ep,tr);
ncomps=5;

[Fp,Ye,Ip,Exp,e,Rpen]=parafac_reg(Y,ncomps,G,Alpha(a),Options,[0 7 0 0]);
% figure,plot(abs(Fp{3})./(ones(5,1)*abs(std(Fp{3},0,1))))
% figure,plot(abs(xep)./(ones(5,1)*abs(std(xep,0,1))))

% figure,plot(abs(Fp{2})./(ones(128,1)*abs(std(Fp{2},0,1))))
% figure,plot(abs(xch)./(ones(128,1)*abs(std(xch,0,1))))

for jj=1:ncomps
    for ii=1:nsource
        
        x=angle(Fp{2}(:,jj));
        y=angle(xch(:,ii));
        temp=corrcoef(x,y);
        FC7(jj,ii)=temp(1,2);
        
    end
end
for jj=1:ncomps
    for ii=1:nsource
        
        x=abs(Fp{2}(:,jj));
        y=abs(xch(:,ii));
        temp=corrcoef(x,y);
        PC7(jj,ii)=temp(1,2);
        
    end
end

[Fp,Ye,Ip,Exp,e,Rpen]=parafac_reg(Y,ncomps,G,Alpha(a),Options,[0 0 0 0]);
for jj=1:ncomps
    for ii=1:nsource
        
        x=angle(Fp{2}(:,jj));
        y=angle(xch(:,ii));
        temp=corrcoef(x,y);
        FC0(jj,ii)=temp(1,2);
        
    end
end
for jj=1:ncomps
    for ii=1:nsource
        
        x=abs(Fp{2}(:,jj));
        y=abs(xch(:,ii));
        temp=corrcoef(x,y);
        PC0(jj,ii)=temp(1,2);
        
    end
end
format short
FC0,FC7
PC0,PC7
resgood(end+1,:)=[mean(max(abs(PC0))) mean(diag(abs(PC7))) mean(max(abs(FC0))) mean(diag(abs(FC7)))]