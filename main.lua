function randomObjectFromTable(t)
    
    return t[math.random(1, #t)]
 end 

function ifWin(board)
    win_condition_array = 
    {{"1\n", "2\n", "3\n"}, {"4\n", "5\n", "6\n"}, {"7\n", "8\n", "9\n"}, {"1\n", "4\n", "7\n"}, 
    {"2\n", "5\n", "8\n"}, {"3\n", "6\n", "9\n"}, {"1\n", "5\n", "9\n"}, {"3\n", "5\n", "7\n"}}

    for i=1,8 do

        nOfBoxesInRow = 0

        for n=1,3 do
            Box = board[win_condition_array[i][n]]

            if Box == "X" then
                nOfBoxesInRow = nOfBoxesInRow + 1
            else 
                if Box == "O" then
                    nOfBoxesInRow = nOfBoxesInRow - 1
                end
            end
                
            
        end

        if nOfBoxesInRow == 3 then
            return 1
        end

        if nOfBoxesInRow == -3 then
            return -1
        end

    end
    
    return 0

end

function mustMove(board)
    win_condition_array = 
    {{"1\n", "2\n", "3\n"}, {"4\n", "5\n", "6\n"}, {"7\n", "8\n", "9\n"}, {"1\n", "4\n", "7\n"}, 
    {"2\n", "5\n", "8\n"}, {"3\n", "6\n", "9\n"}, {"1\n", "5\n", "9\n"}, {"3\n", "5\n", "7\n"}}

    for i=1,8 do

        nOfBoxesInRow = 0

        for n=1,3 do
            Box = board[win_condition_array[i][n]]

            if Box == "X" then
                nOfBoxesInRow = nOfBoxesInRow + 1
            else 
                if Box == "O" then
                    nOfBoxesInRow = nOfBoxesInRow - 1
                end
            end
                
            
        end

        if nOfBoxesInRow == 2 then
            goto figureOutMove
        end

        if nOfBoxesInRow == -2 then
            goto figureOutMove
        end

        goto endLoop

        ::figureOutMove::
        
        for n=1,3 do
            Box = board[win_condition_array[i][n]]

            if Box == " " then
                return win_condition_array[i][n]
            end
                
            
        end

        ::endLoop::

    end
    
    return "0\n"
end

function getComputerMove(board)
    move = mustMove(board)

    moves = {"1\n", "2\n", "3\n", "4\n", "5\n", "6\n", "7\n", "8\n", "9\n"}

    if move == "0\n" then
         
        math.randomseed(224) --used for an exakt move after 1. 5-1 2. 9
        move = randomObjectFromTable(moves)
        while board[move] ~= " " do
            move = randomObjectFromTable(moves)
        end
    end

    return move
end

function drawBoard(Board)
    print("*************")
    print("*   *   *   *")
    print("* " .. Board["1\n"] .. " * " .. Board["2\n"] .. " * " .. Board["3\n"] .. " *")
    print("*   *   *   *")
    print("*************")
    print("*   *   *   *")
    print("* " .. Board["4\n"] .. " * " .. Board["5\n"] .. " * " .. Board["6\n"] .. " *")
    print("*   *   *   *")
    print("*************")
    print("*   *   *   *")
    print("* " .. Board["7\n"] .. " * " .. Board["8\n"] .. " * " .. Board["9\n"] .. " *")
    print("*   *   *   *")
    print("*************")
end

function main()
    print("press ctrl+c to end playing")

    board = { }

    for i=1,10 do
        board[tostring(i) .. "\n"] = " "
    end

    for i=1,5 do
        ::start::

        drawBoard(board)
    
        s = io.read(2)-- 2 becouse it reads the \n charecter at the end
        if board[s] ~= " " then
            goto start
        end


        --if i % 2 == 1 then
            board[s] = "O"
        --else
        --    board[s] = "X"
        --end


        whoWon = ifWin(board)        
        if whoWon == 1 then
            print("X won!")
            break
        end
        if whoWon == -1 then
            print("O won!")
            break
        end

        if i == 5 then
            break
        end

        move = getComputerMove(board)

        board[move] = "X"

        drawBoard(board)

        whoWon = ifWin(board)        
        if whoWon == 1 then
            print("X won!")
            break
        end
        if whoWon == -1 then
            print("O won!")
            break
        end

    end



end

while true do
    main()
end
