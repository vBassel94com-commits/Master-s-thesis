%  ⁄—Ì› «·ÃœÊ· «·–Ì Ì—»ÿ »Ì‰ «·Õ—Ê› Ê—„Ê“ „Ê—”
morseCode = containers.Map({'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', ...
    'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', ...
    '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', ' '}, ...
    {'.-', '-...', '-.-.', '-..', '.', '..-.', '--.', '....', '..', '.---', ...
    '-.-', '.-..', '--', '-.', '---', '.--.', '--.-', '.-.', '...', '-', '..-', '...-', ...
    '.--', '-..-', '-.--', '--..', '-----', '.----', '..---', '...--', '....-', '.....', ...
    '-....', '--...', '---..', '----.', ' '});

% ﬁ—«¡… «·‰’ «·„‘›— „‰ «·„·›
try
    fileID = fopen('encoded_text.txt', 'r', 'n', 'UTF-8');
    encodedText = fread(fileID, Inf, '*char')';
    fclose(fileID);
catch
    error('›‘· ›Ì ﬁ—«¡… «·„·› «·„‘›—.');
end

%  ﬁ”Ì„ «·‰’ ≈·Ï ”ÿÊ—
morseLines = strsplit(encodedText, '\n');

% ›ﬂ  ‘›Ì— «·‰’ «·„‘›—
decodedText = '';
for i = 1:length(morseLines)
    morse = strsplit(morseLines{i}, ' ');
    for j = 1:length(morse)
        if isKey(morseCode, morse{j})
            decodedText = [decodedText morseCode(morse{j})];
        end
    end
    decodedText = [decodedText ' ']; % ≈÷«›… ›—«€ »Ì‰ «·ﬂ·„« .
end

% ﬂ «»… «·‰’ «·„›ﬂÊﬂ ≈·Ï „·›
try
    fileID = fopen('decoded_text.txt', 'w', 'n', 'UTF-8');
    fwrite(fileID, decodedText, 'char');
    fclose(fileID);
    disp(' „ «·ﬂ «»… ≈·Ï «·„·› decoded_text.txt');
catch
    error('›‘· ›Ì ﬂ «»… «·„·›.');
end
