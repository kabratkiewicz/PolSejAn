function Ren = Ren_Opt(sigma, x, gamma_K, N_FFT)
fs = 1;
t = 0:1/fs:length(x.signal)/fs-1/fs;  % os czasu od 0
f = 1:N_FFT;
E_STFT = Gab_STFT(x, N_FFT, sigma, gamma_K, 0);
Ren = Renyi_Entropy(abs(E_STFT), t, f, 3 );
end