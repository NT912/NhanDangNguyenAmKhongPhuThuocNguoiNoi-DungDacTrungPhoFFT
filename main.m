close; clear; clc;

NguyenAm = {'a','e','i','o','u'};
TenFolder={'23MTL','24FTL','25MLM','27MCM','28MVN','29MHN','30FTN','32MTP','33MHP','34MQP','35MMQ','36MAQ','37MDS','38MDS','39MTS','40MHS','41MVS','42FQT','43MNT','44MTT','45MDV'};

% goi ham va truyen thong so vao cho cac bien
MaTranNhamLan=zeros(5,5);                    
[VectorDacTrung] = TimVectorDacTrung(); 
SoPhanTuVector_fft = 2048;         % N_FFT         
DoDaiKhung = 0.03;                               
DoDichKhung = 0.01;                            

% duyet lan luot tung nguyen am cua tung folder kiem thu
for i = 1 : length(TenFolder)
    disp(strcat('File : ',TenFolder(i)))
    for j = 1 : length(NguyenAm)
        path = char(strcat('/NguyenAmKiemThu/',TenFolder(i),'/',NguyenAm(j),'.wav'));
        [x, fs] = audioread(path);                  
        x = x / max(abs(x));        % chuan hoa tin hieu ve day -1 : 1
        [x] = CatKhoangLang(x,fs,0.01);           
        [x] = LayDoanOnDinh(x);                    
        SoLuongKhung = floor((size(x,1) - DoDaiKhung*fs)/(DoDichKhung*fs)) + 1;% tinh so luong khung
        Total = 0;                  % vector tong cac vector fft
        for m=1:SoLuongKhung                               
            [frame] = Chiakhung(x, fs, DoDaiKhung, DoDichKhung, m);         
            [result] = FFT(frame, SoPhanTuVector_fft);                                    
            Total = Total + result';           % tong cac vector fft
        end 
        Total = Total/SoLuongKhung;            % vector fft trung binh (1 nguyen am/1 nguoi noi)
        Total = Total(1:length(Total)/2);      % lay 1 nua vector (vi la vector doi xung)
        
        array = zeros(1,5);      % mang chua khoang cach giua VDT vua tinh voi VDT cua file huan luyen
        for m =1:5                                             
            vantay = VectorDacTrung(m,:);           % trich 1 vector dac trung cua 1 nguyen am 
            array(m) = KhoangCachEuclidean(Total,vantay);           
        end
        [value,index] = min(array);          % nguyen am co khoang cach be nhat se la ket qua can tim
        
        % so sanh ket qua dat duoc voi ket qua chuan
        if(index==j) 
            disp(strcat('Nguyen am :', NguyenAm(j),' - Ket qua thu duoc : ',NguyenAm(j)));
            MaTranNhamLan(j,j)=MaTranNhamLan(j,j) +1; 
        else 
            disp(strcat('Nguyen am : ', NguyenAm(j), ' - Ket qua thu duoc : ',NguyenAm(index),'  -> Sai ' ));
            MaTranNhamLan(j,index)=MaTranNhamLan(j,index)+1; 
        end
    end
    disp('-------------------------------------------------- ');
end

disp('Ma tran nham lan :');
disp('          a      e      i     o     u  ');
disp('  ');
for l=1:5
    line = strcat(cell2mat(NguyenAm(l)),' ');
    for p=1:5
        line = strcat(line,{'     '}, num2str(MaTranNhamLan(l,p)));
    end
    disp(line);
end
disp('---------------------------------------------- ');

DoChinhXacA=MaTranNhamLan(1,1)/21*100; 
disp(strcat('Do chinh xac nguyen am /a/ :',num2str(DoChinhXacA),'%'));
DoChinhXacE=MaTranNhamLan(2,2)/21*100;
disp(strcat('Do chinh xac nguyen am /e/ :',num2str(DoChinhXacE),'%'));
DoChinhXacI=MaTranNhamLan(3,3)/21*100;
disp(strcat('Do chinh xac nguyen am /i/ :',num2str(DoChinhXacI),'%'));
DoChinhXacO=MaTranNhamLan(4,4)/21*100;
disp(strcat('Do chinh xac nguyen am /o/ :',num2str(DoChinhXacO),'%'));
DoChinhXacU=MaTranNhamLan(5,5)/21*100;
disp(strcat('Do chinh xac nguyen am /u/ :',num2str(DoChinhXacU),'%'));

Tong=0;
for k=1:5
    Tong=Tong+MaTranNhamLan(k,k);
end
Tong=(Tong/(21*5))*100;
disp(strcat('Do chinh xac tong          :',num2str(Tong),'%'));




