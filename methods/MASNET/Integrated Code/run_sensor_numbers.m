cd ~/Documents/ls_brain/results/
files=dir('*SNR*');

for i=1:numel(files)
        
    ls_sensor_numbers(files(i).name)
    ls_sensor_numbers_nocp(files(i).name)
    
end