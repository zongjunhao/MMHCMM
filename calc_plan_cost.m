% 获取一种分配方案花费的时间
% 1. 子节点按照分配方案分配到主节点上
% 2. 计算每个主节点的cost（HCMM）
% 3. 取最大的cost 作为分配方案的cost
% @param: L: [master_num, 1]，每个主节点的任务量
% @param: plan: [worker_num, 1]，一种分配方案，记录了每个子节点分配到的主节点
% @param: a: [worker_num, 1]，工作节点的a值
% @param: u: [worker_num, 1]，工作节点的u值
% @return: plan_cost: float，分配方案的时间花费
function plan_cost = calc_plan_cost(plan, L, S, s, R, a, u, r)
    master_num = length(L);
    plan_cost = 0;

    for master_index = 1:master_num
        % 获取分配到该主节点的工作节点，
        worker_index_list = find(plan == master_index);
        worker_num = length(worker_index_list);

        % 如果没有工作节点分配到该主节点，该方案无法计算（计算时间无穷大）
        % TODO 此处待优化，先把所有节点的worker_num全计算出来，如果有0的情况，直接返回inf，减少不必要的HCMM计算（情况较少，后面再考虑要不要修改）
        if worker_num == 0
            plan_cost = inf;
            return;
        end

        % 该主节点的工作节点的a和u值
        plan_a = zeros(1, worker_num);
        plan_u = zeros(1, worker_num);
        plan_r = zeros(1, worker_num);

        for i = 1:worker_num
            plan_a(i) = a(worker_index_list(i));
            plan_u(i) = u(worker_index_list(i));
            plan_r(i) = r(worker_index_list(i));
        end

        % 计算分配该主节点任务的hcmm消耗
        cost = hcmm(worker_num, L(master_index), S(master_index), s(master_index), R(master_index), plan_a, plan_u, plan_r);
        plan_cost = max(plan_cost, cost);
    end

end
