function [ correct ] = testH( u2Trans, v2Trans, uBase, vBase, H )
% This method used to test the h matrix is correct.
% it may include test (uBase, vBase, 1)'= h*(u2Trans , v2Trans, 1)' 

    [~, pointSize] = size(u2Trans);
    
    correct = 0;
    
    myAnswer = zeros(pointSize, 1);
    
    for count = 1 : pointSize
        
        xPrime = uBase(:, count);
        yPrime = vBase(:, count);
        
        x = u2Trans(:, count);
        y = v2Trans(:, count);
        
        % get the right result after mutiply H
        right = H*[x, y, 1]'; % get h*(u2Trans , v2Trans, 1)'
        rightDownNumber = right(3,:);
        right = right/rightDownNumber; % then, make right down number is 1

        left = [xPrime, yPrime, 1]'; % get (uBase, vBase, 1)'

        % test each pair is correct match based on this H
        if isequal(round(left), round(right)) == 1
            myAnswer(count,:) = 1;
        end

    end
    
    % create matrix save values all equal to 1
    correctAnswer = ones(pointSize, 1);
    
    % compare our result and correct answer
    if isequal(correctAnswer, myAnswer) == 1
        correct = 1;
    end
    
    if correct == 1
        fprintf('The Homegraphy is correct.\n');
    end

end

