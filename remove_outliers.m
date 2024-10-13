function filteredData = remove_outliers(data)
    % ����� ������� ��� ������ ���������� �� ������ �����
    z_scores = zscore(data);
    filteredData = data(abs(z_scores) < 3);
end