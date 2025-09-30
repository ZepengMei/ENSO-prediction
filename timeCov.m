function res = timeCov(time,start)
% 'days since 1800-01-01 00:00:00'

% start = [1800 1 1];


res = datevec(time + datenum(start));