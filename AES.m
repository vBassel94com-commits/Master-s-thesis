% ������� ����� ������ ��� �� ������ ������
key128 = '2b7e151628aed2a6abf7158809cf4f3c';
inputText = '3243f6a8885a308d313198a2e0370734';

% ����� ���� �������� ������� ����� ������
outputTextOriginal = Cipher(key128, inputText);
disp(['���� ������: ' outputTextOriginal]);


% ����� ���� ������ �������� ��� ������ ��
outputBinary = hexToBinaryVector(outputTextOriginal);
keyBinary = hexToBinaryVector(key128);

% ���� XOR ��� ���� ������ ��������
shanonXOR = bitxor(outputBinary, keyBinary);

% ���� ����� ����� �������� ���� ������ �������
shanonValue = sum(shanonXOR) / numel(shanonXOR);

% ��� ����� ����� �����
disp(['Shannon Value: ' num2str(shanonValue * 100) '%']);
