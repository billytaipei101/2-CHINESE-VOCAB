function [] = vocab(xc,lab1,n)
    % This function present a list of words given a grammatical/syntactical category, the 
    % main entries are:
    %    xc   -> Chinese characters, either 1 = Traditional, 2 = Simplified;
    %    lab1 -> one of the grammatical/syntactical categories from the list below;
    %    n    -> number of words to be presented.
    % Other options can be modified within the script.
    
    % INPUT example xc = 1, traditional Chinese, lab1= 1 % for opening XA_1 ADJECTIVES and n = 10, for
    % presenting the first 10 words in that document using traditional characters 'vocab(1,1,10)'
    % Chinese vocabulary
    %   01 ADJECTIVES                41  NPEOPLE PESONALPRONOUN    81  TIME
    %   02 ADJECTIVES PEOPLE         42  NPEOPLE PROFESSION        82  TIME DAY
    %   03 ADVERBS                   43  NPEOPLE TEAM              83  TIME EVENTS
    %   04 ADVERBS DEGREE            44  NPLACES CHINA             84  TIME EXPRESSIONS
    %   05 ADVERBS QUANTITY          45  NPLACES CITIES            85  TIME MONTHS
    %   06 ADVERBS TIME              46  NPLACES CITY              86  VERB
    %   07 CONJUNCTIONS              47  NPLACES CONTINENTS        87  VERB AUXILIARY
    %   08 DEMONSTRATIVES            48  NPLACES COUNTRIES         88  VERB HANDS
    %   09 FOOD CANDIES              49  NPLACES DIRECTIONS        89  VERB MENTAL
    %   10 FOOD DESSERTS             50  NPLACES EARTH             90  VERB MOUTH
    %   11 FOOD DISHES               51  NPLACES INDOOR            91  VERB MOVEMENT
    %   12 FOOD DRINKS               52  NPLACES OFFICE
    %   13 FOOD FRUITS               53  NPLACES OTHERS
    %   14 FOOD GRAINS               54  NPLACES SPACE
    %   15 FOOD INGREDIENTS          55  NPLACES TAIWAN
    %   16 FOOD MEATS                56  OBJ ABSTRACT
    %   17 FOOD VEGETABLES           57  OBJ ACADEMIC
    %   18 BODY                      58  OBJ ACCESORIES
    %   19 HEALTH MEDICINE           59  OBJ ARTS
    %   20 HEALTH PHARMACY           60  OBJ BUSSINES
    %   21 HEALTH DISEASES           61  OBJ CLOTHING
    %   22 HEALTH MENTAL ILLNESS     62  OBJ MATTER
    %   23 MEASURES                  63  OBJ DOCUMENTS
    %   24 MEASURES COUNTERS         64  OBJ ECONOMY
    %   25 MEASURES MATH AND STATS   65  OBJ ELECTRONICS
    %   26 MEASURES NUMBERS          66  OBJ FURNITURE
    %   27 NOT                       67  OBJ HOUSE
    %   28 NLIVING BIRDS             68  OBJ ISMS
    %   29 NLIVING CRUSTACEAN        69  OBJ KITCHEN
    %   30 NLIVING DINOSAUR          70  OBJ LANGUAGE
    %   31 NLIVING IMAGINARY         71  OBJ MEDIA
    %   32 NLIVING INSECTS           72  OBJ MUSIC
    %   33 NLIVING FISH              73  OBJ NATURE
    %   34 NLIVING MAMMALS           74  OBJ SPORTS
    %   35 NLIVING PLANTS            75  OBJ STIMULANT
    %   36 NLIVING REPTILES          76  OBJ TOOLS
    %   37 NPEOPLE FAMILY            77  OBJ TRANSPORT
    %   38 NPEOPLE NAMES&LASTNAMES   78  PREPOSITIONS
    %   39 NPEOPLE OTHER             79  PRONOUNS
    %   40 NPEOPLE PERSON            80  QUESTIONS
                    
    % Frequent errors|warnings:
    %  - Frequent errors include not finding the font for drawing the text;
    %    in that case run d=listfonts in MAC for list of available fonts in your system
    
    %% Step 0 Special commands W
    % test
    %lab1 = 1;
    %n = 20;
    % end test
    mode   =  3;
    %   mode : If mode = 1, the system uses either Mei Jia or Ting-Ting Voice at 185 and also
    %                       either the English \ Spanish or Japanese Voice at 185
    %          If mode = 2, the presentation time of each word is 2 sec without translations
    %          If mode = 3, the system uses either Mei Jia or Ting-Ting Voice at 185
    %                       without translations and awaits for any key to be pressed before
    %                       continuing to the next word.
    roman = 2; 
    %  roman :   If roman = 1 English
    %            If roman = 2 Spanish
    % non roman. If roman = 3 Japanese (Japanese translations might not be accurate and need to be revised in the future)
    bgco_x = [1 2 3 4 5 6 7 8 9];
    bgco   = randsample(bgco_x, 1);
    %bgco = 1;
    %  bgco  : Background / font color combinations; see the different combinations of 
    %          complementary colors below
    
    %% Step 1 Function Inputs
    
    AssertOpenGL;             % Making sure the script is running on Psychtoolbox-3:
    cd '/Users/williamcruz/Documents/MATLAB/0 Chinese multivocab'
    T     = dataset('XLSFile','a guide.xls','ReadObsNames',true);
    newT  = T(T.proxy==lab1,:);
    file  = newT.t_file(1);   % is a cell array
    sheet = newT.t_sheet(1);  % is a numeric value
    
    %% Step 2 Color Settings
    % Background / color font combinations using complementary pairs
    % Complementary Cheking using this website
    % https://rgbcolorcode.com
    if bgco == 1
        color01 = [255,153,204]; % Carnation pink  (Complementary checked)
        color02 = [153,255,204]; % Magic Mind      (Complementary checked)
    elseif bgco == 2
        color01 = [235,79 ,132]; % Medium slate blue (Complementary checked)
        color02 = [255,255,102]; % Unmellow Yellow   (Complementary checked)
    elseif bgco == 3
        color01 = [255,255,255]; % white
        color02 = [1  ,1  ,1  ]; % black
    elseif bgco == 4
        color01 = [51 ,153,255]; % Dodger blue (Complementary checked)
        color02 = [255,153,51 ]; % Deep saffron(Complementary checked)
    elseif bgco == 5
        color01 = [77 ,225,255]; % Maya Blue         (Complementary checked)
        color02 = [255,106,77 ]; % Outrageous orange (Complementary checked)
    elseif bgco == 6
        color01 = [128,255,191]; % Aquamarine      (Complementary checked)
        color02 = [255,128,191]; % Persian pink    (Complementary checked)
    elseif bgco == 7
        color01 = [43 ,0  ,255]; % Electric Ultramarine (Complementary checked)
        color02 = [212,255,0  ]; % Electric Lime        (Complementary checked)
    elseif bgco == 8
        color01 = [255,255,51 ]; % Yellow  (Complementary checked)
        color02 = [51 ,51 ,255]; % Palatinate blue (Complementary checked)
    elseif bgco == 9
        color01 = [227,38 ,54 ]; % Alzarin Crimson (Complementary checked)
        color02 = [39 ,227,211]; % Turquoise       (Complementary checked)
    end
    
    % when working with the PTB enclose the whole body of your program
    % in a try ... catch ... end construct to prevent you from getting stuck
    % in the PTB full screen mode
    try
        %% Step 3 Core Function
        [~,txt,~] = xlsread(string(file),sheet); 
        if  n > size(txt,1)
            n = size(txt,1);
        end
        
        if xc == 1      % Traditional Chinese
            chitext = char(txt(1:n,2));
        elseif xc == 2  % Simplified Chinese
            chitext = char(txt(1:n,5));
        end
        
        if roman == 1
            engli = txt(1:n,1);
        elseif roman == 2
            engli = txt(1:n,3);
        elseif roman == 3
            engli = char(txt(1:n,4));
        end
        % test for pinyin
        % pin = txt(1:n,6);
        % charpin = 30;
        % end test for pinyin
        
        charsz  = 200;
        
        Screen('Preference', 'SkipSyncTests',1);
        [w,rect] = Screen('OpenWindow', 0, color01); % Change to windows 0 default, 1 or 2
        cs       = rect(3:4)/2;
        Screen('Preference', 'TextRenderer', 2);
        Screen('Preference', 'TextAntiAliasing', 1);
        Screen('Preference', 'TextAlphaBlending', 0);
        Screen('Preference', 'SuppressAllWarnings', 0);
        Screen('Preference', 'VisualDebugLevel', 1);
        feature('DefaultCharacterSet', 'ISO-8859-1'); % Big-5 / UTF-8 / US-ASCII / ISO-8859-1
        feature('DefaultCharacterSet', 'ISO-8859-1'); % Pinyin is displayed innaproperly and disregarded     
        Screen('TextStyle',w, 0);
        HideCursor(w)
        xaxis   = cs(1)-charsz;
        yaxis   = cs(2)-charsz;

        keys = zeros(10,256);
        for i = 1:length(chitext)
            
            [~,~,tic,~] = KbCheck;
            keys(i,:) = tic;
            while keys(i,8)~=1 % E Key for scaping from the loop
                % Inserting the image of the location
                dinfo1 = dir('/Users/williamcruz/Documents/MATLAB/0 Chinese multivocab/0 FIG');
                names_cell = {dinfo1.name};
                theImage = imread(strcat('/Users/williamcruz/Documents/MATLAB/0 Chinese multivocab/0 FIG/',string(char(names_cell(1,(3+lab1))))));
                shapeset = Screen('MakeTexture', w, theImage);
                Screen('DrawTexture', w, shapeset, [], rect);
                % end of inserting the image of the location
                
                Screen('TextSize',w, charsz);
                Screen('TextFont',w,'PingFang TC'); % Favortites: Yuanti SC % Heiti SC % PingFang TC
                
                % Songti SC \ Yuanti SC \ Yuanti TC \ STSong \ Kai \ Heiti SC \ Heiti TC \
                % Improve reading speed = Yuanti SC \ PingFang TC \ LiHei Pro \ LingWai SC
                % \ LingWai TC \ LiSong Pro \ PingFang HK \ PingFang SC \ PMingLiU \ 
                % Songti TC \ STFangsong \ STHeiti \ STSong \ Xingkai SC \
                % Xingkai TC \ 
                
                %% Fonts for displaying Japanese
                % Hiragino Kaku Gothic Pro \ Hiragino Mincho Pro \ Hiragino Sans \ Meiryo
                % \ Osaka \ YuKyokasho \ Yukyokasho Yoko \
                
                dummy = double(chitext(i,:));
                dummy(dummy == 32) = [];
                if length(dummy) == 1
                    Screen('FillRect',w,color01,[xaxis-(charsz/2) yaxis xaxis+(charsz*2)+(charsz/2) yaxis+(charsz*2)])
                    Screen('DrawText', w, double(chitext(i,:)),xaxis+(charsz/2) ,yaxis , color02);
                elseif length(dummy) == 2
                    Screen('FillRect',w,color01,[xaxis-(charsz/2) yaxis xaxis+(charsz*2)+(charsz/2) yaxis+(charsz*2)])
                    Screen('DrawText', w, double(chitext(i,:)),xaxis ,yaxis , color02);
                elseif length(dummy) == 3
                    Screen('FillRect',w,color01,[xaxis-(charsz) yaxis xaxis+(charsz*2)+(charsz) yaxis+(charsz*2)])
                    Screen('DrawText', w, double(chitext(i,:)),xaxis-(charsz/2) ,yaxis , color02);
                elseif length(dummy) == 4
                    Screen('FillRect',w,color01,[xaxis-(charsz*1.5) yaxis xaxis+(charsz*2)+(charsz*1.5) yaxis+(charsz*2)])
                    Screen('DrawText', w, double(chitext(i,:)),xaxis-(charsz) ,yaxis , color02);
                end
                % test for pinyin
                %Screen('TextSize', w, charpin);
                %Screen('TextFont', w,'Hiragino Sans');
                %Screen('DrawText', w, char(pin(i,:)),xaxis+(charsz/2) ,yaxis-(charpin/2), color02);
                % end test for pinyin
                
                 charom = 60; % Defining Character size of bridge language
                 Screen('TextSize', w, charom);
                 xaxis2   = cs(1);
                 
                if roman == 1 || roman == 2
                    Screen('TextFont', w,'Euphemia UCAS');
                    dummy2 = strlength(engli(i,:));
                    xaxis2 = xaxis2 - ((charom * dummy2/4));
                    Screen('DrawText', w, char(engli(i,:)),xaxis2,yaxis+250, color02);
                elseif roman == 3
                    Screen('TextFont', w,'Hiragino Sans');
                    dummy2 = double(engli(i,:));
                    dummy2(dummy2 == 32) = [];
                    dummy3 = length(dummy2); 
                    xaxis2 = xaxis2 - ((charom * dummy3)/3);
                    Screen('DrawText', w, double(engli(i,:)),xaxis2,yaxis+250, color02);
                end
                
                Screen('Flip',w);
                if mode == 1 % Presentation mode option A
                    WaitSecs(0.2)
                    if xc == 1
                       feature('DefaultCharacterSet', 'UTF-8');
                       feature('DefaultCharacterSet', 'UTF-8');
                       str=char(chitext(i,:));
                       system(sprintf('say -v Mei -r 180 %s', str));
                       feature('DefaultCharacterSet', 'Big-5');
                       feature('DefaultCharacterSet', 'Big-5'); 
                    elseif xc == 2
                       feature('DefaultCharacterSet', 'UTF-8');
                       feature('DefaultCharacterSet', 'UTF-8');
                       str=char(chitext(i,:));
                       system(sprintf('say -v Ting-Ting -r 180 %s', str));
                       feature('DefaultCharacterSet', 'Big-5');
                       feature('DefaultCharacterSet', 'Big-5');
                    end
                    
                    if roman == 1
                        system( sprintf('say -v Samantha -r 180 %s', char(engli(i,:)))); % Options Samantha / Alex
                    elseif roman == 2
                        system( sprintf('say -v Soledad -r 180 %s', char(engli(i,:))));
                    elseif roman == 3
                        str2 = char(engli(i,:));
                        system( sprintf('say -v Kyoko -r 180 %s', str2))
                    end
                    
                elseif mode == 2 % Presentation mode option B (2 sec)
                    WaitSecs(2);
                elseif mode == 3 % Presentation of the next word after pressing space bar
                    WaitSecs(0.2)
                    if xc == 1
                        feature('DefaultCharacterSet', 'UTF-8');
                        feature('DefaultCharacterSet', 'UTF-8');
                        str=char(chitext(i,:));
                        system(sprintf('say -v Mei -r 180 %s', str));
                        feature('DefaultCharacterSet', 'Big-5');
                        feature('DefaultCharacterSet', 'Big-5');
                    elseif xc == 2
                        feature('DefaultCharacterSet', 'UTF-8');
                        feature('DefaultCharacterSet', 'UTF-8');
                        str=char(chitext(i,:));
                        system(sprintf('say -v Ting-Ting -r 180 %s', str));
                        feature('DefaultCharacterSet', 'Big-5');
                        feature('DefaultCharacterSet', 'Big-5');
                    end
                    
                    [~,~,~]=KbWait;
                    WaitSecs(0.2  );
                end
                break
            end
        end
        Screen('Flip', w);
        Screen('CloseAll');
        %% Last Step - Termination and report of errors (if any)
        %   This section is executed only in case an error happens in the
        %   experiment code implemented between try and catch...
    catch
        ShowCursor;
        Screen('CloseAll');
        ListenChar(0);
        %Screen('Preference', 'VisualDebuglevel', olddebuglevel);
        psychrethrow(psychlasterror); % output the error message
    end