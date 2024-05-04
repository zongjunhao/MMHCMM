% 交叉操作，相邻两个plan之间随机交换片段
% @param: plan_list: [plan_num, worker_num]，种群
% @param: cross_rate: float 交叉率
% @return: plan_list: [plan_num, worker_num]，交叉后的种群
function plan_list = ga_cross(plan_list, cross_rate)
    [plan_num, ~] = size(plan_list);

    for i = 1:2:plan_num - mod(plan_num, 2)

        if cross_rate > rand()
            [plan_list(i, :), plan_list(i + 1, :)] = crossover(plan_list(i, :), plan_list(i + 1, :));
        end

    end

end

% 交叉操作，随机选取起始和终止位置并交换片段
function [a, b] = crossover(a, b)
    worker_num = length(a);
    rand_1 = randi(worker_num);
    rand_2 = randi(worker_num);

    left = min(rand_1, rand_2);
    right = max(rand_1, rand_2);

    temp = a(left:right);
    a(left:right) = b(left:right);
    b(left:right) = temp;
end
