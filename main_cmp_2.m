% 均分工作节点数目+均分工作节点的任务量=总任务量10000/节点数目 未编码

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
plan = importdata('./utils/plan_equal_distribute.txt', ',');

cost = 0;

for master_index = 1:master_num
    % 找到该主节点下的工作节点
    worker_index_list = find(plan == master_index);
    worker_num = length(worker_index_list);

    if worker_num == 0
        cost = inf;
        break;
    end

    master_L = L(master_index);
    master_S = S(master_index);
    master_s = s(master_index);
    master_R = R(master_index);
    % TODO 考虑每个工作节点分到的任务非整数个
    worker_task_num = master_L / worker_num;

    master_cost = 0;

    for i = 1:worker_num
        worker_index = worker_index_list(i);
        worker_a = a(worker_index);
        worker_u = u(worker_index);
        worker_r = r(worker_index);

        worker_cost = (1 / worker_u + worker_a + master_S / master_R + master_s / worker_r) * worker_task_num;
        master_cost = max(master_cost, worker_cost);
    end

    cost = max(cost, master_cost);

end

fprintf('2 cmp 均分工作节点数目+均分工作节点的任务量 未编码 耗时: %f \n', cost);
