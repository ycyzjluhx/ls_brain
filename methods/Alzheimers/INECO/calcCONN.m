Q=B;
W=A;
z1=Q(1,:)==1; %& sig(1:end-1)>10 & sig(1:end-1)<20;
b1=Q(:,z1);
z0=Q(1,:)==0; %& sig(1:end-1)>10 & sig(1:end-1)<20;
b0=Q(:,z0);

tmp=[];
CON=[];
thr=0:0.01:1;
res=[];

for th=1:numel(thr)
    
    c=(b1(7,:)>=thr(th));
    d=(b1(8,:)<thr(th));
    e=[c d];
    res(th)=(sum(e==0)*(-2) + sum(e==1)*1)/numel(e);

end
Cpara2=max(res);
%%
tmp=[];
CON=[];
thr=0:0.01:1;
res=[];

for th=1:numel(thr)
    
    c=(b1(6,:)>=thr(th));
    d=(b0(6,:)<thr(th));
    e=[c d];
    res(th)=(sum(e==0)*(-2) + sum(e==1)*1)/numel(e);

%      tmp{count}=[ones(1,c+d) -2*ones(1,d)];
end
Cpara=max(res);
%%

% tdpli=[ sum(Q(10,z0)==1) * (-2) + sum(Q(10,z1)==0) * (-2) + ...
%     sum(Q(10,z1)==1) * (1) + sum(Q(10,z0)==0) * (1) ]/(sum(z1)+sum(z0));
% 
% Chaufe_p=tdpli;
% %%
% 
% tdpli=[ sum(Q(11,z0)==1) * (-2) + sum(Q(11,z1)==0) * (-2) + ...
%     sum(Q(11,z1)==1) * (1) + sum(Q(11,z0)==0) * (1) ]/(sum(z1)+sum(z0));
% 
% Chaufe=tdpli;;
%%
tmp=[];
CON=[];
thr=0:0.01:1;
res=[];

for th=1:numel(thr)
    
    c=(b1(10,:)>=thr(th));
    d=(b1(12,:)<thr(th));
    e=[c d];
    res(th)=(sum(e==0)*(-2) + sum(e==1)*1)/numel(e);

%      tmp{count}=[ones(1,c+d) -2*ones(1,d)];
end
Cmvar_p=max(res);
%%
tmp=[];
CON=[];
thr=0:0.01:1;
res=[];

for th=1:numel(thr)
    
    c=(b1(11,:)>=thr(th));
    d=(b0(11,:)<thr(th));
    e=[c d];
    res(th)=(sum(e==0)*(-2) + sum(e==1)*1)/numel(e);

%      tmp{count}=[ones(1,c+d) -2*ones(1,d)];
end
Cmvar=max(res);