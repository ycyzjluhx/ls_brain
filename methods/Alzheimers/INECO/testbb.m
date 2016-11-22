for i=1:25
    
    load(['~/Documents/bb/data/testsnr/EEG/dataset_' num2str(i) '/data']),
    load(['~/Documents/bb/data/testsnr/truth/dataset_' num2str(i) '/truth']),
    truth
    INT(i)=truth.interaction;
    SNR(i)=truth.snr;
    data=[];
    if ~exist('sa')
        load('~/Documents/bb/data/sa')
    end
    fs=100;
    len=180;
    bandpass=[8 13];
    data=[];
    data.fsample    = fs;
    data.label=sa.EEG_clab_electrodes;
    % [sources_int, sources_nonint, P_ar] = generate_sources_ar(fs, len, bandpass);
    % EEG_field_pat(:,2) = sa.cortex75K.EEG_V_fem_normal(:,randi(74382));
    % EEG_field_pat(:,2) = sa.cortex75K.EEG_V_fem_normal(:,randi(74382));
    % EEG_data=EEG_field_pat*sources_int;
    
    % EEG_data=truth.EEG_field_pat*randn(2,18000);
    EEG=reshape(EEG_data,108,100,[]);
    for k=1:size(EEG,3)
        data.trial{1,k} = EEG(:,:,k);
        data.time{1,k}  = (0:(size(EEG,2)-1))/fs;
    end
    cfg             = [];
    
    cfg.reref       = 'no';
    cfg.refchannel  = 'all'; % average reference
    cfg.lpfilter    = 'no';
    cfg.lpfreq      = 40;
    cfg.preproc.demean='no';
    cfg.preproc.detrend='no';
    data            = ft_preprocessing(cfg,data);
    
    cfg             = [];
    cfg.method      = 'mtmfft';
    freqs=2:2:20;
    cfg.foi         = freqs;
    cfg.tapsmofrq   = 1;
    cfg.taper       = 'hanning';
    cfg.output      = 'fourier';
    freqc      = ft_freqanalysis(cfg, data);
    
    Y=permute(freqc.fourierspctrm,[1 2 3]);
    nsource=2;
    ncomps=2;
    xch=[truth.EEG_field_pat truth.EEG_noise_pat];
    Y=permute(Y,[2 1 3]);
    Options=[];
    Options(1)=10^-2;
    Options(3)=2;
    Options(5)=1;
    [a h c p m]=parafac2(Y,502,[4 4],Options);
    out=tensor_connectivity2(p,h);
    OUT{i}=out;
    
end