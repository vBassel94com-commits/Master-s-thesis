addpath DES_Functions
addpath MATLAB
% ������� - ��� �� ���� 56 ��
key56_hex = 'aabb09182736ccdd'; % ���� ������ ������ �������
key56_binary = hexToBinaryVector(key56_hex);

% ���� ���� ��� ������ - ��� �� ���� 64 ��
inputText = '1101010100100100111101101011000010000100100100011100001100110100';

% ����� ����
encryptedText = MyDES(inputText, 'ENC', key56_binary);
disp(['���� ������: ' encryptedText]);

% �� ����� ����
decryptedText = MyDES(encryptedText, 'DEC', key56_binary);
disp(['���� �������: ' decryptedText]);
