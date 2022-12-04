% Ham tinh vector dac trung fft, ket qua la 1 vector co do dai n_fft 
function [vectorFFT] = FFT(x,SoPhanTuVector_fft)
    vectorFFT = abs(fft(x, SoPhanTuVector_fft));
end
