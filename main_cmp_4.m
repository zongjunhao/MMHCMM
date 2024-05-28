% 用简单贪心选工作节点+负载分配HCMM 编码

clear
clc
close all
tic

master_num = 4; % 主机数量
worker_num = 400; % 工作节点数量

% 初始化主节点（每个主节点）
[L, S, s, R] = init_master(master_num);
% 初始化工作节点
[a, u, r] = init_worker(worker_num);

% 子节点计算能力（性能）
worker_ability = zeros(1, worker_num);

for i = 1:worker_num
    worker_ability(i) = 1 / (1 / u(i) + a(i));
end

% 子节点的计算能力排序
[sorted_worker, sorted_worker_index] = sort(worker_ability, 'descend');
% 主节点的任务量排序
[sorted_master, sorted_master_index] = sort(L, 'descend');

plan = zeros(worker_num, 1);

% 将性能最强的四个子节点分配给四个主节点
for i = 1:master_num
    master_index = sorted_master_index(i);
    worker_index = sorted_worker_index(i);
    plan(worker_index) = master_index;
end

% 已经用到了第几个工作节点（按工作节点性能排序）
used_worker_index = 4;

for i = master_num + 1:worker_num
    max_master_index = get_max_master(plan, L, S, s, R, a, u, r);
    plan(i) = max_master_index;
end

cost = calc_plan_cost(plan, L, S, s, R, a, u, r);

fprintf('4 cmp 用简单贪心选工作节点+负载分配HCMM 编码: %f \n', cost);

toc

% 获取计算耗时最长的主节点
function max_master_index = get_max_master(plan, L, S, s, R, a, u, r)
    master_num = length(L);
    max_master_cost = 0;
    max_master_index = 0;

    for master_index = 1:master_num
        % 获取分配到该主节点的工作节点，
        worker_index_list = find(plan == master_index);
        worker_num = length(worker_index_list);

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

        if cost > max_master_cost
            max_master_cost = cost;
            max_master_index = master_index;
        end

    end

end
