clear; close all; clc;

wdir='.\';

fileloc0=[wdir,'example_2020-05-01_IN.RAGD..BHZ'];
fileloc_ext = '.mat';
fileloc = [fileloc0 fileloc_ext];
if exist(fileloc,'file')
    disp(['File exists ', fileloc]);
    load(fileloc);
    stats_0
    sampling_rate = getfield(stats_0,'sampling_rate');
    delta = getfield(stats_0,'delta');
    starttime = getfield(stats_0,'starttime');
    endtime = getfield(stats_0,'endtime');
    t1 = datetime(starttime,'InputFormat',"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
    t2 = datetime(endtime,'InputFormat',"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
    datetime_array = t1:seconds(delta):t2;
    
    %% plot time series
    fig = figure('Renderer', 'painters', 'Position', [100 100 1000 400], 'color','w');
    plot(t1:seconds(delta):t2, data_0, 'k-')
    title([getfield(stats_0,'network'),'-', getfield(stats_0,'station'), '-', getfield(stats_0,'channel')])
    axis tight;
    print(fig,['docs/',fileloc0, '_ts.jpg'],'-djpeg')
    
    fig2 = figure();
    data_0_double = double(data_0);
    spectrogram(data_0_double,kaiser(128,18),120,128,sampling_rate,'yaxis')
    print(fig2,['docs/',fileloc0, '_spectrogram.jpg'],'-djpeg')
end
