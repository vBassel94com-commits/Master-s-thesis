% ����� ������ ��������� �� ��� ���
fileID = fopen('encoded_text.txt', 'r');
targetPassword = fscanf(fileID, '%s');
fclose(fileID);

% ��� ��������� ��������
maxAttempts = 1000000;

% ��� ���� ����� ��������
found = false;
attempts = 0;

while ~found && attempts < maxAttempts
    % ����� ���� ���� ������� ���� ��� ������ �� ������ ���������
    generatedPassword = char(randi([97, 122], 1, numel(targetPassword)));
    
    % ����� ��� ���������
    attempts = attempts + 1;
    
    % ������ �� ������ ���� ������ ���������
    if isequal(generatedPassword, targetPassword)
        found = true;
    end
end

if found
    disp(['�� ������ ��� ���� ������ ��� ', num2str(attempts), ' ������.']);
    disp(['���� ������ ��: ', generatedPassword]);
else
    disp('�� ��� ���� ������. ��� ��������� ��� 1000 ��� ������ ��� ������ ���������.');
end