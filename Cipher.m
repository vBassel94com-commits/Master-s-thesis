function Out = Cipher(key, In)
    % AES-128,192,256 cipher
    % íŞæã ÈÊäİíĞ FIBS-197¡ ÍíË íßæä ÇáãİÊÇÍ åæ ÅÏÎÇá 128¡ 192¡ Ãæ 256 ÈÊ ÈÊäÓíŞ
    % ÇáåßÓÇÏíÓíãÇá¡ æÇáÑÓÇáÉ (In) åí 128 ÈÊ ÈÊäÓíŞ ÇáåßÓÇÏíÓíãÇá.
    % ÇáÊØÈíŞ áÇ íÊÍŞŞ ãä Øæá ÇáãİÊÇÍ Ãæ ÅÏÎÇá ÇáÑÓÇáÉ æáßäå ÓíõÙåÑ ÎØÃ ÅĞÇ áã Êßä ãä ÇáØæá ÇáÕÍíÍ.

    % ÊÍæíá ÇáÑÓÇáÉ ãä ÇáåßÓÇÏíÓíãÇá Åáì ÚÏÏ ÕÍíÍ
    In = hex2dec(reshape(In, 2, [])');

    % ÊæÓíÚ ÇáãİÊÇÍ æİŞğÇ ááãÚíÇÑ
    Nk = length(key) / 8;
    w = KeyExpansion(key, Nk);

    % ÊÔßíá ÇáÑÓÇáÉ Åáì ãÕİæİÉ ÍÇáÉ
    numRows = 4;
    numCols = numel(In) / numRows;

    % ÅĞÇ áã íßä ÚÏÏ ÇáÚäÇÕÑ ŞÇÈáÇğ ááŞÓãÉ Úáì 4¡ Şã ÈÊßÑÇÑ ÇáÈíÇäÇÊ
    if rem(numel(In), numRows) ~= 0
        In = repelem(In, ceil(numRows / numel(In)));
    end

    state = reshape(In, numRows, []);

    % ÅÌÑÇÁ ÇáÌæáÉ ÇáÃæáì
    state = AddRoundKey(state, w(:, 1:4));

    % ÅÌÑÇÁ ÇáÌæáÇÊ ÇáÊÇáíÉ
    for k = 2:(Nk + 6)
        state = SubBytes(state);
        state = ShiftRows(state);
        state = MixColumns(state);
        state = AddRoundKey(state, w(:, 4 * (k - 1) + 1:4 * k));
    end

    % ÌæáÉ ÃÎíÑÉ
    state = SubBytes(state);
    state = ShiftRows(state);
    state = AddRoundKey(state, w(:, 4 * (Nk + 6) + 1:4 * (Nk + 7)));

    % ÊÛííÑ ÇáÅÎÑÇÌ Åáì ãÊÌå ÚãæÏ
    Out = state(:);

    % ÊÍæíá ÇáÅÎÑÇÌ Åáì ÇáåßÓÇÏíÓíãÇá
    Out = lower(dec2hex(Out(1:length(In)))');
    Out = Out(:)';
end
