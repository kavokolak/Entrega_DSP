bsFilt = designfilt('bandstopiir','FilterOrder',20, ...
         'HalfPowerFrequency1',900,'HalfPowerFrequency2',1100, ...
         'SampleRate',1500);
fvtool(bsFilt)
dataIn = audio10;
dataOut = filter(bsFilt,dataIn);