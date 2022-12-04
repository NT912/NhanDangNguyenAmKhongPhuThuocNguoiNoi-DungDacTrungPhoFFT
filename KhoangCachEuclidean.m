% Tinh khoang cach giua 2 tin hieu 
% Ket qua tra ve gia tri khoang cach giua 2 tin hieu
function [KhoangCach] = KhoangCachEuclidean(Total, vantay)
KhoangCach=0; 
    for i=1:length(Total)
        KhoangCach = KhoangCach+(Total(i)-vantay(i))^2;
    end
    KhoangCach=sqrt(KhoangCach);
end
