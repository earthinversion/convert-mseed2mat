clear; close all; clc;

wdir='.\';

fileloc0=[wdir,'example_2020-05-01_IN.RAGD..BHZ'];
fileloc_ext = '.mat';
fileloc = [fileloc0 fileloc_ext];
if exist(fileloc,'file')
    disp(['File exists ', fileloc]);
    load(fileloc);
    
%     length(fieldnames(data))
%     data.data_0;
%     stats.stats_0;
    all_stats = fieldnames(stats);
    all_data = fieldnames(data);
    
        
%     for id=1:length(fieldnames(data))
    for id=1
        stats_0 = stats.(all_stats{id});
        data_0 = data.(all_data{id});

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
        print(fig,['docs/',fileloc0, '_ts', num2str(id),'.jpg'],'-djpeg')

        fig2 = figure('Renderer', 'painters', 'Position', [100 100 1000 400], 'color','w');
        data_0_double = double(data_0);
        
%         spectrogram(data_0_double,128,120,128,sampling_rate,'yaxis')
        spectrogram(data_0_double,kaiser(128,18),120,128,sampling_rate,'yaxis')

%         yticks([0 sampling_rate/4 sampling_rate/2])
%         yticklabels({'0','0.5','1'})
%         ylabel('Normalized Frequency');
        
        title([getfield(stats_0,'network'),'-', getfield(stats_0,'station'), '-', getfield(stats_0,'channel')])
        print(fig2,['docs/',fileloc0, '_spectrogram', num2str(id),'.jpg'],'-djpeg')
%         close all;
    end
end
