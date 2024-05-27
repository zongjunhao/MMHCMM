% 逆转计划中的某些部分，仅逆转后优于原来的计划保留
% @param: plan_list: [plan_num, worker_num]，种群
% @param: L: [master_num, 1]，每个主节点的任务量
% @param: a: [worker_num, 1]，工作节点的a值
% @param: u: [worker_num, 1]，工作节点的u值
% @return: plan_list: [plan_num, worker_num]，逆转后的种群
function plan_list = ga_reverse(plan_list, L, S, s, R, a, u, r)
    [plan_num, worker_num] = size(plan_list);
    new_plan_list = plan_list;

    for i = 1:plan_num
        rand_1 = randi(worker_num);
        rand_2 = randi(worker_num);

        left = min(rand_1, rand_2);
        right = max(rand_1, rand_2);

        new_plan_list(i, left:right) = new_plan_list(i, right:-1:left);

        raw_cost = calc_plan_cost(plan_list(i), L, S, s, R, a, u, r);
        new_cost = calc_plan_cost(new_plan_list(i), L, S, s, R, a, u, r);

        if new_cost < raw_cost
            plan_list(i, :) = new_plan_list(i, :);
        end

    end

end
