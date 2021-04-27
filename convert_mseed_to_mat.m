clear all
close all
clc

%% input variables
STtime=clock;
prepend = 'example_';
network = {'IN'};
stcodevec = {'RAGD'};  %{'B914';'B956'};

ELtime=etime(clock,STtime);
disp(['Finished run in ',num2str(ELtime), ' secs']);