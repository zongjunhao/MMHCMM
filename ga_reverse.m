% 逆转计划中的某些部分，仅逆转后优于原来的计划保留
% @param: plan_list: [plan_num, worker_num]，种群
% @param: master_task_list: [master_num, 1]，每个主节点的任务量
% @param: a: [worker_num, 1]，工作节点的a值
% @param: u: [worker_num, 1]，工作节点的u值
% @return: plan_list: [plan_num, worker_num]，逆转后的种群
function plan_list = ga_reverse(plan_list, master_task_list, a, u)
    [plan_num, worker_num] = size(plan_list);
    new_plan_list = plan_list;

    for i = 1:plan_num
        rand_1 = randi(worker_num);
        rand_2 = randi(worker_num);

        left = min(rand_1, rand_2);
        right = max(rand_1, rand_2);
        
        new_plan_list(i, left:right) = new_plan_list(i, right:-1:left);

        raw_cost = calc_plan_cost(master_task_list, plan_list(i), a, u);
        new_cost = calc_plan_cost(master_task_list, new_plan_list(i), a, u);

        if new_cost < raw_cost
            plan_list(i, :) = new_plan_list(i, :);
        end

    end

end
