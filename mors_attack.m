% ����� ������ ���� ���� ��� ������ ����� ����
morseCode = containers.Map({'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', ...
    'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', ...
    '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', ' '}, ...
    {'.-', '-...', '-.-.', '-..', '.', '..-.', '--.', '....', '..', '.---', ...
    '-.-', '.-..', '--', '-.', '---', '.--.', '--.-', '.-.', '...', '-', '..-', '...-', ...
    '.--', '-..-', '-.--', '--..', '-----', '.----', '..---', '...--', '....-', '.....', ...
    '-....', '--...', '---..', '----.', ' '});

% ����� ���� ������ �� �����
try
    fileID = fopen('encoded_text.txt', 'r', 'n', 'UTF-8');
    encodedText = fread(fileID, Inf, '*char')';
    fclose(fileID);
catch
    error('��� �� ����� ����� ������.');
end

% ����� ���� ��� ����
morseLines = strsplit(encodedText, '\n');

% �� ����� ���� ������
decodedText = '';
for i = 1:length(morseLines)
    morse = strsplit(morseLines{i}, ' ');
    for j = 1:length(morse)
        if isKey(morseCode, morse{j})
            decodedText = [decodedText morseCode(morse{j})];
        end
    end
    decodedText = [decodedText ' ']; % ����� ���� ��� �������.
end

% ����� ���� ������� ��� ���
try
    fileID = fopen('decoded_text.txt', 'w', 'n', 'UTF-8');
    fwrite(fileID, decodedText, 'char');
    fclose(fileID);
    disp('�� ������� ��� ����� decoded_text.txt');
catch
    error('��� �� ����� �����.');
end
