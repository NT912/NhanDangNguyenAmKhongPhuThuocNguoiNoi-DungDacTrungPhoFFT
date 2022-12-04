function [VectorDacTrung] = TimVectorDacTrung()
% Ham tim vector dac trung
% Ket qua la 1 ma tran 5 * DoDaiVectorDacTrung_fft chua 5 vector dac trung cua 5 nguyen am
 
NguyenAm = {'a','e','i','o','u'};
TenFolder = {'01MDA','02FVA','03MAB','04MHB','05MVB','06FTB','07FTC','08MLD','09MPD','10MSD','11MVD','12FTD','14FHH','15MMH','16FTH','17MTH','18MNK','19MXK','20MVK','21MTL','22MHL'};
 
DoDaiVectorDacTrung_fft = 2048;                        % N_FFT                    
VectorDacTrung=zeros(5,DoDaiVectorDacTrung_fft/2);   
DoDaiKhung = 0.03;                                                    
DoDichKhung = 0.01;                                                                                            
figure;
hold on
 for k = 1 : 5
     for i= 1 : length(TenFolder)
         path = char(strcat('/NguyenAmHuanLuyen/',cell2mat(TenFolder(i)),'/',cell2mat(NguyenAm(k)),'.wav'));
         [x,fs] = audioread(path);                                      
         x = x / max(abs(x));  % chuan hoa tin hieu ve day -1 1
         [x] = CatKhoangLang(x,fs,0.01);                            
         [x] = LayDoanOnDinh(x);                                      
         SoLuongKhung = floor((size(x,1) - DoDaiKhung*fs)/(DoDichKhung*fs)) + 1;  % tinh so luong khung
         Total = 0;                                                               % vector tong cac vector fft
         for j=1:SoLuongKhung                                         
             [frame] = Chiakhung(x, fs, DoDaiKhung, DoDichKhung, j);                           
             [result] = FFT(frame, DoDaiVectorDacTrung_fft);                                                 
             Total = Total + result;                                           
         end
         Total = Total/SoLuongKhung;  % vector fft tb (1 nguyen am/ 1 nguoi noi)
         Total = Total(1:length(Total)/2);  % lay 1 nua vector (vi la vector doi xung)                 
         for m =1:length(Total) 
             VectorDacTrung(k,m)=VectorDacTrung(k,m)+Total(m);   % tong cac vector fft cua nhieu nguoi noi
         end
        
     end
     for m =1:length(Total)
         VectorDacTrung(k,m)=VectorDacTrung(k,m)/21;      % vector fft trung binh cua 1 nguyen am 
     end
        
     p = VectorDacTrung(k,:); 
     plot(p);
 end
 legend('/a/', '/e/', '/u/', '/i/', '/o/');          
end