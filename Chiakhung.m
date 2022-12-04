% Ham chia khung
% Ket qua la 1 khung tin hieu co so thu tu la so thu tu khung
function [frame] = Chiakhung(x,fs,DoDaiKhung,DoDichKhung,SoThuTuKhung)
    MauKhung = DoDaiKhung*fs; 
    frame = x(round((SoThuTuKhung-1)*DoDichKhung*fs+1):round((SoThuTuKhung-1)*DoDichKhung*fs+MauKhung));
end
