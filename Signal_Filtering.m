clc;
clear;
close all;

% 1. Generate the original signal
Fs = 1000;                 % Sampling frequency (Hz)
t = 0:1/Fs:1-1/Fs;        % Time vector

f = 10;                    % Signal frequency (Hz)
clean_signal = sin(2*pi*f*t);

% 2. Add random noise
noise = 0.7 * randn(size(t));
noisy_signal = clean_signal + noise;

% 3. Design a moving-average low-pass filter
N = 15;                    % Filter window length
h = ones(1,N)/N;

filtered_signal = conv(noisy_signal, h, 'same');

% 4. Calculate SNR before and after filtering
noise_before = noisy_signal - clean_signal;
noise_after = filtered_signal - clean_signal;

SNR_before = 10*log10( ...
    sum(clean_signal.^2)/sum(noise_before.^2));

SNR_after = 10*log10( ...
    sum(clean_signal.^2)/sum(noise_after.^2));

% 5. Display the results
fprintf('SNR before filtering = %.2f dB\n', SNR_before);
fprintf('SNR after filtering  = %.2f dB\n', SNR_after);
fprintf('SNR improvement      = %.2f dB\n', ...
    SNR_after - SNR_before);

% 6. Plot the signals
figure;

subplot(3,1,1);
plot(t, clean_signal);
title('Original Clean Signal');
xlabel('Time (seconds)');
ylabel('Amplitude');
grid on;

subplot(3,1,2);
plot(t, noisy_signal);
title('Signal with Noise');
xlabel('Time (seconds)');
ylabel('Amplitude');
grid on;

subplot(3,1,3);
plot(t, filtered_signal);
title('Filtered Signal');
xlabel('Time (seconds)');
ylabel('Amplitude');
grid on;

