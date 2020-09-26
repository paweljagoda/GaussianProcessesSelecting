
filename = '10748390_02_norm1.dat';
data = load(filename);

dist = zeros(length(data)-1,1); %separations between the points.

length_days = floor(max(data(:,1)) - min(data(:,1)));
index = zeros(length_days,1);

result = input ('Observations length (h) and day range (separated by / e.g. 10,2): ', 's');
%result = '1.5,1';

C = strsplit(result,'/');
obst = str2num(C{1});
day = str2num(C{2});

if size(day) == [0 0]; 
     day = 1;
end    

obst = obst * 60;

for i = 1:(length(data)-1);
    dist(i,1) = double(data(i+1,1) - data(i,1));  
end

index(1,1) = 1; % [ ADDED ]
k = 2;
sum = 0;


for i = 1:length(dist);
    sum = sum + dist(i,1);
    %mamma(i) = sum;
    if (sum >= 0.96 && sum <1.041 ); % fix numbers, please do not change them -we are leaving un uncertainty of +- 1h per day)
        index(k) = i;
        k = k+1;
        sum = 0;
    end
    if (dist(i) > 3.8 * mean(dist) && sum >1.041);
        index(k) = i -1;
        if dist(i,1) < 1.041
            sum = dist(i,1);
        end
        if dist (i,1) > 1.041;
            sum = 0 ;
        end
        k = k+1;
    end
end

% 


%dlmwrite('/Users/camilla/Desktop/mamma.m', mamma','delimiter', '\t', 'precision', '%.6f')

multiplier = 1440;
sum = 0;
dist_mins = dist .* multiplier;

sum = 0;
k = 1;

new_arr = [];
j = 1;
for k = 1:day:length(index)-1
    [k, index(k)+1, index(k+1)];
    sum = 0;
    for i = index(k)+1: index(k+1)
        sum = sum + dist_mins(i);
        if (sum >= obst & sum < (obst + 30) );
            for w = index(k)+1:i
                new_arr(j,1) = data(w,1);
                new_arr(j,2) = data(w,2);
                j = j + 1;
            end
            break
        end
    end
    
end    
      
plot(data(:,1), data(:,2), 'o'); hold on;
plot(new_arr(:,1), new_arr(:,2), 'go');
% 



%new_array

dlmwrite('C:\Users\Pawel\Desktop\Summer Project\10748390\10748390_02_select_107.dat', new_arr,'delimiter', '\t', 'precision', '%.6f')
