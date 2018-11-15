mainMenu :-
    repeat,
    clearConsole,
	write('================================='), nl,
	write('=        ..:: ZURERO ::..       ='), nl,
	write('================================='), nl,
	write('=                               ='), nl,
	write('=   1. Start Game               ='), nl,
	write('=   2. Tutorial                 ='), nl,
	write('=   3. Credits                  ='), nl,
	write('=   4. Exit                     ='), nl,
	write('=                               ='), nl,
	write('================================='), nl,
	write('Choose an option:'), nl,
    readChar(Input),
        (
            Input = '1' -> gameModeMenu, mainMenu;
            Input = '2' -> mainMenu;
            Input = '3' -> mainMenu;
            Input = '4';
    
            nl,
            write('Error: invalid input.'), nl,
            pressEnterToContinue, nl,
            mainMenu
        ).


gameModeMenu :-
        repeat,
        clearConsole,
        write('================================='), nl,
        write('=        ..:: ZURERO ::..       ='), nl,
        write('================================='), nl,
        write('=                               ='), nl,
        write('=   1. Human vs Human           ='), nl,
        write('=   2. Human vs Computer        ='), nl,
        write('=   3. Computer vs Computer     ='), nl,
        write('=   4. Return to Main Menu      ='), nl,
        write('=                               ='), nl,
        write('================================='), nl,
        write('Choose an option:'), nl,
        readChar(Input),
            (
                Input = '1' -> startGame(pvp);
                Input = '2' -> startGame(pvb);
                Input = '3' -> startGame(bvb);
                Input = '4';
        
                nl,
                write('Error: invalid input.'), nl,
                pressEnterToContinue, nl,
                mainMenu
            ).