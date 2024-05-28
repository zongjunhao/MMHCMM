% 3. 均分工作节点数目+负载分配HCMM 编码

clear
clc
close all
tic

master_num = 2; % 主机数量
worker_num = 6; % 工作节点数量

% 初始化主节点（每个主节点）
[L, S, s, R] = init_master(master_num);
% 初始化工作节点
[a, u, r] = init_worker(worker_num);
plan = importdata('./utils/plan_equal_distribute.txt', ',');
plan_cost = calc_plan_cost(plan, L, S, s, R, a, u, r);

fprintf('3 cmp 均分工作节点数目+负载分配HCMM 编码 耗时: %f \n', plan_cost);

toc
