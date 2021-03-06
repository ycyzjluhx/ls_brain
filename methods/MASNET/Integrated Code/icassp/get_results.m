function [ res ] = get_results( pbsens_av , acc_av , N , K , G , T , S, D, fpr_idx , prd, msh)

pr_hit_seq = D*K/N;
pr_hit_gr  = D*G*K/N;
pr_hit_rnd = D*K;

res.acc_seq=squeeze(acc_av(S,fpr_idx,:));
res.acc_gr=squeeze(acc_av(S/G,fpr_idx,:));
res.acc_rnd=squeeze(acc_av(S/N,fpr_idx,:));
for i=1:16
    tmp_acc_rnd_good(i,:)=prd(i+4)*squeeze(acc_av(i+3,fpr_idx,:));
end
res.acc_rnd_good=sum(tmp_acc_rnd_good,1)';
res.acc_seq(isnan(res.acc_seq))=[];
res.acc_gr(isnan(res.acc_gr))=[];
res.acc_rnd(isnan(res.acc_rnd))=[];
res.acc_rnd_good(isnan(res.acc_rnd_good))=[];
pd_seq=pbsens_av(S,fpr_idx);
pd_gr=pbsens_av(S/G,fpr_idx);
pd_rnd=pbsens_av(S/N,fpr_idx);
for i=1:16
    pd_rnd_good(i)=pbsens_av(i+3,fpr_idx);
end

for t=1:T
    
    if t==1        
        nd_seq(t) = pr_hit_seq * pd_seq;         
        nd_gr(t) = pr_hit_gr * pbsens_av(S/G,fpr_idx);        
        nd_rnd(t) = pr_hit_rnd * pbsens_av(S/N,fpr_idx); 
        nd_rnd_good(t) = (D*K*msh/N) * sum( prd(5:20) .* pd_rnd_good );
        cum_dis_seq(t) = mean(acc_av(S,fpr_idx,:));
        cum_dis_gr(t) = mean(acc_av(S/G,fpr_idx,:));
        cum_dis_rnd(t) = mean(acc_av(S/N,fpr_idx,:));
    else
        nd_seq(t) = nd_seq(t-1) + pr_hit_seq * pbsens_av(S,fpr_idx);
        nd_gr(t) = nd_gr(t-1) + pr_hit_gr * pbsens_av(S/G,fpr_idx);
        nd_rnd(t) = nd_rnd(t-1) + pr_hit_rnd * pbsens_av(S/N,fpr_idx); 
        nd_rnd_good(t) = nd_rnd_good(t-1) + (D*K*msh/N) * sum( prd(5:20) .* pd_rnd_good );
        cum_dis_seq(t) = cum_dis_seq(t-1) + mean(acc_av(S,fpr_idx,:));
        cum_dis_gr(t) = cum_dis_gr(t-1) + mean(acc_av(S/G,fpr_idx,:));
        cum_dis_rnd(t) = cum_dis_rnd(t-1) + mean(acc_av(S/N,fpr_idx,:));
    end 
    snd_seq(t) = t * pr_hit_seq * (1 - pr_hit_seq) * pd_seq^2;
    snd_gr(t) = t * pr_hit_gr * (1 - pr_hit_gr) * pd_gr^2;
    snd_rnd(t) = t * pr_hit_rnd * (1 - pr_hit_rnd) * pd_rnd^2;
end     

t=1:T;
%% seq
res.nd_seq=nd_seq;
res.std_seq=sqrt(t.^2*pr_hit_seq*pd_seq^2.*(1-pr_hit_seq));
res.nd_gr=nd_gr;
res.std_gr=sqrt(t.^2.*pr_hit_seq*G^2*pd_gr^2.*(1-pr_hit_seq));
res.nd_rnd=nd_rnd;
res.std_rnd=sqrt(t.^2.*pr_hit_rnd*pd_rnd^2.*(1-pr_hit_seq));
res.nd_rnd_good=nd_rnd_good;
res.cum_dis_seq=cum_dis_seq;
res.cum_dis_gr=cum_dis_gr;
res.cum_dis_rnd=cum_dis_rnd;


tmp=find(round(nd_seq)>=K);
if isempty(tmp);tmp=Inf;end;
res.ttd_seq=tmp(1);

tmp=find(round(nd_gr)>=K);
if isempty(tmp);tmp=Inf;end;
res.ttd_gr=tmp(1);

tmp=find(round(nd_rnd)>=K);
if isempty(tmp);tmp=Inf;end;
res.ttd_rnd=tmp(1);

tmp=find(round(nd_rnd_good)>=K);
if isempty(tmp);tmp=Inf;end;
res.ttd_rnd_good=tmp(1);

