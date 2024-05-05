% 用简单贪心选工作节点+负载分配HCMM 编码

clear
clc
close all
tic

master_num = 4; % 主机数量
worker_num = 400; % 工作节点数量

% 初始化主节点（每个主节点）
% master_task_list = [10000];
% master_task_list = [10000, 20000, 40000, 80000];
master_task_list = [10000, 10000, 10000, 10000];
% 初始化工作节点
[a, u] = init_worker(worker_num);

% 子节点计算能力
worker_ability = zeros(worker_num, 1);

for i = 1:worker_num
    worker_ability(i) = 1 / (1 / u(i) + a(i));
end

[sorted_worker, sorted_index] = sort(worker_ability, 'descend');

plan = zeros(worker_num, 1);