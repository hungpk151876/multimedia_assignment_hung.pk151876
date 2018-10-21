% Pham Khanh Hung - 20151876 - Dien tu 10 - K60
% Multimedia Assignment

fs = 44100;                                 % Sampling frequency (Hz)

% Recording
r = audiorecorder(44100,16,1);              % Ghi am voi fs = 44100,16-bit,1-channel 
disp('Start speaking.')                     
recordblocking(r, 17);                      % Cho phep ghi am vao bien r voi thoi gian 17s 
disp('End of Recording.');                  
myRecording = getaudiodata(r);
filename = 'orig_input.wav';                % Tao ten file ghi am
audiowrite(filename, myRecording, fs);      % Luu vao file ghi am

% Khoi tao cac tin hieu hinh sin - Cac not Nhac
M = 0.15;
t = 0 : 1/fs : 0.3;                         % Time axis (seconds)
% Do  C
 C = M * sin(2 * pi * 261.63 * t);
 C2 = M * sin(2 * pi * 523.25 * t);
% Re  D
 D = M * sin (2 * pi * 293.66 * t);
 D2 = M * sin(2 * pi * 587.33 * t );
% Mi  E
 E = M * sin(2 * pi * 329.63 * t);
 E2 = M * sin(2 * pi * 659.25 * t);
% Fa  F
 F = M * sin(2 * pi * 349.23 * t);
 F2 = M * sin(2 * pi * 698.46 * t);
% Sol  G
 G = M * sin(2 * pi * 392.00 * t);
 G2 = M * sin(2 * pi * 783.99 * t)
% La  A
 A = M * sin(2 * pi * 440.00 * t);
 A2 = M * sin(2 * pi * 880.00 * t);
% Si  B
 B = M * sin(2 * pi * 493.88 * t);
 B2 = M * sin (2 * pi * 987.77 * t)
% Delay
 O = 0 * sin(2 * pi * t);
% Jingle Bells Song
song = [ G E2 D2 C2 G O G G E2 D2 C2 A O A A F2 E2 D2 B O G2 G2 F2 E2 D2 E2 O G E2 D2 C2 G O G G E2 D2 C2 A O A A F2 E2 D2 G2 O G2 G2 G2 O G2 A2 G2 F2 D2 C2];
[y,fs] = audioread('orig_input.wav');
melody = y + (song(1:length(y)))';       % Tron tin hieu ghi am va song de tao ra melody
soundsc(melody,fs);
filename = 'melody.wav';
audiowrite(filename, melody, fs); 

% Fast Fourier Transform
N = fs;       % Number of FFT points
transform = fft(melody,N)/N;
magTransform = abs(transform);
faxis = linspace(-fs/2,fs/2,N);
figure(1);
plot(faxis,fftshift(magTransform));
title('Frequency Spectrum');
xlabel('Frequency(Hz)')

% Spectrogram
win = 128       % Window length in samples
% Number of samples between overlapping windows:
hop = win/2
nfft = win      % Width of each frequency bin
figure(2);
spectrogram(melody,win,hop,nfft,fs,'yaxis')
% Change the tick labels of the graph from scientific notation to floating point:
yt = get(gca,'YTick');
set(gca,'YTickLabel', sprintf('%.0f|',yt))
title('Spectrogram');