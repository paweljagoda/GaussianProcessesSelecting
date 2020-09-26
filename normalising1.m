% Normalising of the light curve

filename = '10748390_02_rapmod.tbl';

a = load(filename);

mean_flux = mean(a);

b(:,2) = a(:,3) ./ mean_flux(3);

b(:,1) = a(:,2);

dlmwrite('C:\Users\Pawel\Desktop\10748390_02_norm1.dat', b,'delimiter', '\t', 'precision', '%.6f')