% 变异操作，交换一个plan的两个点
% @param: plan_list: [plan_num, worker_num]，种群
% @param: mutate_rate: float 变异率
% @return: plan_list: [plan_num, worker_num]，变异后的种群
function plan_list = ga_mutate(plan_list, mutate_rate)
    [plan_num, worker_num] = size(plan_list);

    for i = 1:plan_num

        if mutate_rate > rand()
            R = randperm(worker_num);
            plan_list(i, R(1:2)) = plan_list(i, R(2:-1:1));
        end

    end

end
