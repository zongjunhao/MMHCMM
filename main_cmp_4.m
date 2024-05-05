% 用简单贪心选工作节点+负载分配HCMM 编码

clear
clc
close all
tic

master_num = 4; % 主机数量
worker_num = 400; % 工作节点数量

% 初始化主节点（每个主节点）
% master_task_list = [10000];
master_task_list = [10000, 20000, 40000, 80000];
% master_task_list = [10000, 10000, 10000, 10000];
% 初始化工作节点
[a, u] = init_worker(worker_num);

% 子节点计算能力（性能）
worker_ability = zeros(worker_num, 1);

for i = 1:worker_num
    worker_ability(i) = 1 / (1 / u(i) + a(i));
end

% 子节点的计算能力排序
[sorted_worker, sorted_worker_index] = sort(worker_ability, 'descend');
% 主节点的任务量排序
[sorted_master, sorted_master_index] = sort(master_task_list, 'descend');

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
    max_master_index = get_max_master(master_task_list, plan, a, u);
    plan(i) = max_master_index;
end

cost = calc_plan_cost(master_task_list, plan, a, u);

fprintf('4 cmp 用简单贪心选工作节点+负载分配HCMM 编码: %f \n', cost);

% 获取计算耗时最长的主节点
function max_master_index = get_max_master(master_task_list, plan, a, u)
    master_num = length(master_task_list);
    max_master_cost = 0;
    max_master_index = 0;

    for master_index = 1:master_num
        % 获取分配到该主节点的工作节点，
        worker_index_list = find(plan == master_index);
        worker_num = length(worker_index_list);

        % 该主节点的工作节点的a和u值
        plan_a = zeros(worker_num, 1);
        plan_u = zeros(worker_num, 1);

        for i = 1:worker_num
            plan_a(i) = a(worker_index_list(i));
            plan_u(i) = u(worker_index_list(i));
        end

        % 计算分配该主节点任务的hcmm消耗
        cost = hcmm(master_task_list(master_index), worker_num, plan_a, plan_u);

        if cost > max_master_cost
            max_master_cost = cost;
            max_master_index = master_index;
        end

    end

end
