function Out = Cipher(key, In)
    % AES-128,192,256 cipher
    % ���� ������ FIBS-197� ��� ���� ������� �� ����� 128� 192� �� 256 �� ������
    % ������������� �������� (In) �� 128 �� ������ �������������.
    % ������� �� ����� �� ��� ������� �� ����� ������� ����� ������ ��� ��� �� ��� �� ����� ������.

    % ����� ������� �� ������������� ��� ��� ����
    In = hex2dec(reshape(In, 2, [])');

    % ����� ������� ����� �������
    Nk = length(key) / 8;
    w = KeyExpansion(key, Nk);

    % ����� ������� ��� ������ ����
    numRows = 4;
    numCols = numel(In) / numRows;

    % ��� �� ��� ��� ������� ������ ������ ��� 4� �� ������ ��������
    if rem(numel(In), numRows) ~= 0
        In = repelem(In, ceil(numRows / numel(In)));
    end

    state = reshape(In, numRows, []);

    % ����� ������ ������
    state = AddRoundKey(state, w(:, 1:4));

    % ����� ������� �������
    for k = 2:(Nk + 6)
        state = SubBytes(state);
        state = ShiftRows(state);
        state = MixColumns(state);
        state = AddRoundKey(state, w(:, 4 * (k - 1) + 1:4 * k));
    end

    % ���� �����
    state = SubBytes(state);
    state = ShiftRows(state);
    state = AddRoundKey(state, w(:, 4 * (Nk + 6) + 1:4 * (Nk + 7)));

    % ����� ������� ��� ���� ����
    Out = state(:);

    % ����� ������� ��� �������������
    Out = lower(dec2hex(Out(1:length(In)))');
    Out = Out(:)';
end
