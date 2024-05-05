% 均分工作节点数目+均分工作节点的任务量=总任务量10000/节点数目 未编码

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
plan = importdata('./utils/plan_equal_distribute.txt', ',');

% 子节点计算时间
worker_cost = zeros(worker_num, 1);

for i = 1:worker_num
    worker_cost(i) = 1 / u(i) + a(i);
end

cost = 0;

for master_index = 1:master_num
    % 找到该主节点下的工作节点
    worker_index_list = find(plan == master_index);
    worker_num = length(worker_index_list);

    if worker_num == 0
        cost = inf;
        break;
    end

    total_task_num = master_task_list(master_index);
    % TODO 考虑每个工作节点分到的任务非整数个
    worker_task_num = total_task_num / worker_num;

    master_cost = 0;

    for i = 1:worker_num
        worker_task_cost = worker_cost(worker_index_list(i)) * worker_task_num;
        master_cost = max(master_cost, worker_task_cost);
    end

    cost = max(cost, master_cost);

end

fprintf('2 cmp 均分工作节点数目+均分工作节点的任务量 未编码 耗时: %f \n', cost);
