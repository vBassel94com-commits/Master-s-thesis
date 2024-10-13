addpath DES_Functions
addpath MATLAB
% «·„› «Õ - ÌÃ» √‰ ÌﬂÊ‰ 56 » 
key56_hex = 'aabb09182736ccdd'; % „À«· ⁄‘Ê«∆Ì ·√€—«÷ «· Ê÷ÌÕ
key56_binary = hexToBinaryVector(key56_hex);

% «·‰’ «·–Ì Ì „  ‘›Ì—Â - ÌÃ» √‰ ÌﬂÊ‰ 64 » 
inputText = '1101010100100100111101101011000010000100100100011100001100110100';

%  ‘›Ì— «·‰’
encryptedText = MyDES(inputText, 'ENC', key56_binary);
disp(['«·‰’ «·„‘›—: ' encryptedText]);

% ›ﬂ  ‘›Ì— «·‰’
decryptedText = MyDES(encryptedText, 'DEC', key56_binary);
disp(['«·‰’ «·„›ﬂÊﬂ: ' decryptedText]);
