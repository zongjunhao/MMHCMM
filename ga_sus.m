% sus 选择策略具体可以参考 https://zhuanlan.zhihu.com/p/514480067
% @param: fitness_list  个体的适应度值
% @param: select_num   被选择个体的数目
% @param: fitness_list  个体的适应度值
% @return: selected_indices  被选择的个体的索引
function selected_indices = ga_sus(fitness_list, select_num)

    % 累积fitness
    cum_fitness = cumsum(fitness_list);

    % 选择步长与起始点
    step = cum_fitness(end) / select_num;
    start_point = rand() * step;

    selected_indices = zeros(select_num, 1);
    index = 1;
    right_val = cum_fitness(index);
    current_point = start_point;

    for i = 1:select_num
        % 找到第一个大于当前点的累积fitness值
        while current_point > right_val
            index = index + 1;
            right_val = cum_fitness(index);
        end

        selected_indices(i) = index;
        current_point = current_point + step;
    end

    shuffled_indices = randperm(length(selected_indices));
    selected_indices = selected_indices(shuffled_indices);
end
