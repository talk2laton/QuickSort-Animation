function A = QuickSort(A, animate)
    close all;  n = numel(A); handles = [];
    if(animate)
        handles = Animator(A);
    end

    A = [A, Inf];
    A = quicksort(A, 1, n+1, handles);
    A(end) = [];
end

function handles = Animator(A)
    figure('Color', 'w'); hold on;
    recx = [-0.5,-0.5,0.5,0.5]; recy = [0,1,1,0];
    lo = 1; hi = numel(A);
    handles = arrayfun(@(i)fill(recx+i, A(i)*recy, 'm'), lo:hi);
    axis tight; axis off; delay = 3;
    txt = text(mean(xlim), mean(ylim), num2str(delay), ...
        'FontSize', 200,'Interpreter','latex', ...
        'HorizontalAlignment', 'center');
    while(delay >= 0)
        if(delay>0)
            pause(1); 
        else
            pause(0.05);
        end
        delay = delay - 1;
        txt.String = num2str(delay);
    end
    txt.String = "";
end

function [A, handles] = quicksort(A, lo, hi, handles)
   if(lo < hi)
       [A, j, handles] = partition(A, lo, hi, handles);
       [A, handles] = quicksort(A, lo, j, handles);
       [A, handles] = quicksort(A, j+1, hi, handles);
   end
end

function [A, j, handles] = partition(A, lo, hi, handles)
    pivot = A(lo);
    i = lo; j = hi;
    while(i < j)
        while(A(i) <= pivot)
            i = i + 1;
        end
        while(A(j) > pivot)
            j = j - 1;
        end
        if(i < j) 
            [A, handles] = swap(A, i, j, handles);
        end
    end
    [A, handles] = swap(A, lo, j, handles);
end

function [A, handles] = swap(A, i, j, handles)
    A([i,j]) = A([j,i]); 
    if(~isempty(handles))
        handles(i).FaceColor = 'r';
        handles(j).FaceColor = 'g';
        recx = [-0.5,-0.5,0.5,0.5];
        ai = recx+double(i); bj = recx+double(j);
        for f = 0:0.2:1
            h = handles(i); h.XData = ai + f*(bj - ai);
            h = handles(j); h.XData = bj + f*(ai - bj);
            drawnow; 
        end
        handles([i, j]) = handles([j, i]);
        handles(i).FaceColor = 'b'; 
        handles(j).FaceColor = 'b';
    end
end