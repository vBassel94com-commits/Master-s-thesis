% ÇáãİÊÇÍ æÇáäÕ ÇáãÏÎá ßãÇ İí ÇáãËÇá ÇáÓÇÈŞ
key128 = '2b7e151628aed2a6abf7158809cf4f3c';
inputText = '3243f6a8885a308d313198a2e0370734';

% ÊÔİíÑ ÇáäÕ ÈÇÓÊÎÏÇã ÇáãİÊÇÍ æÇáäÕ ÇáãÏÎá
outputTextOriginal = Cipher(key128, inputText);
disp(['ÇáäÕ ÇáãÔİÑ: ' outputTextOriginal]);


% ÊÍæíá ÇáäÕ ÇáãÔİÑ æÇáãİÊÇÍ Åáì ãÊÌåÇÊ ÈÊ
outputBinary = hexToBinaryVector(outputTextOriginal);
keyBinary = hexToBinaryVector(key128);

% ÍÓÇÈ XOR Èíä ÇáäÕ ÇáãÔİÑ æÇáãİÊÇÍ
shanonXOR = bitxor(outputBinary, keyBinary);

% ÍÓÇÈ ãÚÇãá ÔÇäæä ÈÇÓÊÎÏÇã ãÚÏá ÇáÈÊÇÊ ÇáæÇÍÏÉ
shanonValue = sum(shanonXOR) / numel(shanonXOR);

% ÚÑÖ äÊíÌÉ ãÚÇãá ÔÇäæä
disp(['Shannon Value: ' num2str(shanonValue * 100) '%']);
