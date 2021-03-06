function dfdxij = net_corr_grad(X,idx,tidx,mtype,varargin)

opts = struct ( 'modules',[],'structure', [] ,'constraint', [] , 'learn' , []) ;
[ opts  ] = parseOpts( opts , varargin );
opts2var

W=WfromX(X);
n=size(W,1);

T=size(X,2);
if isempty(tidx);tidx=1:T;end;

ngrad=network_gradient_wu(W,mtype);


for i=1:n
    for j=1:n
        if i==idx & i~=j
            cgrad{i,j}=corr_grad(X(idx,:),X(j,:));
            
        else
            cgrad{i,j}=[];
        end
        
    end
    
end

for t=tidx
    
    dfdxij(t) = trace( ngrad.' * dwdxij(cgrad,t,n));
    
end

end

function dwdxij = dwdxij(cgrad,tidx,n)

dW=zeros(n);
for i=1:n
    for j=1:n
        if ~isempty(cgrad{i,j})
            dW(i,j)=cgrad{i,j}(tidx);
        else
            dW(i,j)=0;
        end
    end
end
dwdxij=dW+dW.';

end