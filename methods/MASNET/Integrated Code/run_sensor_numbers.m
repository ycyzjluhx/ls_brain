cd ~/Documents/ls_brain/results/
files=dir('*SNR*');

for i=1:numel(files)
        
    ls_sensor_numbers(files(1).name)
    ls_sensor_numbers_nocp(files(1).name)
    
end