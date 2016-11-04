if isunix==0
    data_folder='D:\Extracted\Alzheimer\INECO_fieldtrip\';
    save_folder='D:\Extracted\Alzheimer\INECO_fieldtrip\';
else
%     data_folder='/home/engbiome/INECO/INECO_fieldtrip/';
    data_folder='/home/lspyrou/Documents/results/INECO/';
    save_folder='/home/lspyrou/Documents/results/INECO/';
end
%% Connectivity Analysiss
PSI=[];PSI_full=[];conn_full=[];Conn_full=[];freqc=[];freq=[];Freq=[];
DirCon = dir([ data_folder '*.mat']);
cd(save_folder)
tmp=struct2cell(DirCon);
tmp=tmp(1,1:end);
names=sort_nat(tmp);
idx=strcmp('subjects.mat',names);
names(idx)=[];
gc_idx=[];
% Sets frequency bands (steps must match frequency resolution, see cfg.pad)
%freqBands = [[0.5 3]; [3.5 8]; [8.5 12]; [12.5 32]; [32.5 40]];
%numberOfBands = size(freqBands,1);
%PSI = NaN(16,16,100,5,50);
% ntrials_window=2;
freqs=1:1:30;
periods=5;
g1={'PATIENTS' 'CONTROLS'};%[1 0]
g2={'SHAPE' 'BINDING'};
g3={'ENCOD' 'TEST'};
count=1;
for q = 1:length(names)
    clear data   
%     g_idx(q,:)=group_idx(data,g1,g2,g3);
    if g_idx(q,3)==1 %|| g_idx(q,2)==1 % group exclusion criteria
        continue;
    end
    gc_idx(count,:)=g_idx(q,:);
    load( fullfile(data_folder,names{q}) )
    ntrials=numel(data.trial);
    
    cfg             = [];
    cfg.method      = 'mtmfft';                                      % Type of analysis
    %     cfg.foi         = freqBands(i,1):0.2:freqBands(i,2);           % Frequency band to analyse
    cfg.foi         = freqs;                                       % Frequency band to analyse
    cfg.tapsmofrq   = 1;                                            % Or can test other values
    cfg.taper       = 'hanning';
    %     cfg.t_ftimwin   = 5;
    %     cfg.toi         = 2.5;
    cfg.output      = 'pow';
    %cfg.pad         = 5;                                                % Pads for 0.5Hz resolution
    freq{count}         = ft_freqanalysis(cfg, data);
    Freq{count}         = (freq{count}.powspctrm);
    
    cfg.output      = 'fourier';
    freqc{count}        = ft_freqanalysis(cfg, data);
    
    % Applies connectivity measure
    cfg             = [];
%     cfg.method      = 'wpli_debiased';
    %    cfg.complex     = 'complex';
    cfg.method      = 'coh';
    cfg.complex     = 'imag';
    parameter       = 'cohspctrm';
    
    %          cfg.bandwidth   = 1;
    %     for idx_trials=1:ntrials-ntrials_window
    %         cfg.trials      = idx_trials:idx_trials+ntrials_window-1;
    %         conn{count}            = ft_connectivityanalysis(cfg, freqc{count});
    %         PSI{count}(:,:,:,idx_trials) = abs(conn{count}.wpli_debiasedspctrm);
    %         for idx_freq = 1:numel(freq{count}.freq)
    %             tmp               = (PSI{count}(:,:,idx_freq,idx_trials));
    %             idx_toremove      = find(tril(ones(size(tmp))));
    %             tmp(idx_toremove) = [];
    %             Conn{count}(:,idx_freq,idx_trials)  = tmp;
    %         end
    %     end
    for period=1:periods
        cfg.trials      = 'all';
        conn_full{count}            = ft_connectivityanalysis(cfg, freqc{count});
        
    end
    
    
    count=count+1;
    
end