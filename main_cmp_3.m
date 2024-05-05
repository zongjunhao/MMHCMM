% 3. 均分工作节点数目+负载分配HCMM 编码

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
plan = importdata('./utils/plan_equal_distribute.txt', ',');
plan_cost = calc_plan_cost(master_task_list, plan, a, u);

fprintf('3 cmp 均分工作节点数目+负载分配HCMM 编码 耗时: %f \n', plan_cost);

toc
