% Ham cat khoang lang
% Ket qua la 2 dau tdau va tcuoi danh dau bat dau va ket thuc tieng noi
function [y] = CatKhoangLang(x,Fs,NguongXacDinh) 
    DiemDau = 0; 
    DiemCuoi = length(x);
   
    for i = 1 : length(x)
       if abs(x(i))  > NguongXacDinh
           DiemDau = i;
           break;
       end
    end

    for i = length(x) :-1: 1
       if abs(x(i))  > NguongXacDinh
           DiemCuoi = i;
           break;
       end
    end
    y = x(DiemDau:DiemCuoi);
end
% NguongXacDinh = 0.01;
% Chon 0.01 la nguong xac dinh vi trong nhieu lan thu thu cong bang nhieu 
% con so nhu la 0.1; 0.2; 0.3; 0.01; 0.02; 0.03 thi thu nhan duoc khi
% nguong la 0.01 thi tinh on dinh se cao nhat khi cat khaong lang.

