function filteredData = remove_outliers(data)
    % íãßäß ÇÓÊÎÏÇã äİÓ ÇáÏÇáÉ ÇáãõÓÊÎÏãÉ İí ÇáÎíÇÑ ÇáÃæá
    z_scores = zscore(data);
    filteredData = data(abs(z_scores) < 3);
end