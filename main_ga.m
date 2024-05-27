% 节点选择GA+编码（未固定码率）+负载分配HCMM
clear
clc
close all
tic

pop_size = 100; % 种群大小
max_itr = 200; % 迭代轮次
cross_rate = 0.9; % 交叉概率
mutate_rate = 0.05; % 变异概率
gap_rate = 0.9; % 代沟(Generation gap)

master_num = 4; % 主机数量
worker_num = 400; % 工作节点数量

% 初始化主节点（每个主节点）
% master_task_list = [10000];
master_task_list = [10000, 20000, 40000, 80000];
% master_task_list = [10000, 10000, 10000, 10000];
% 初始化工作节点
[a, u] = init_worker(worker_num);
% 1. 初始化种群
plan_list = ga_init_pop(pop_size, master_num, worker_num);

for itr = 1:max_itr
    % 2. 计算适应度（时间花费的倒数）
    plan_cost_list = zeros(pop_size, 1);

    for i = 1:pop_size
        plan_cost_list(i) = calc_plan_cost(master_task_list, plan_list(i, :), a, u);
    end
    
    fprintf('itr: %d, cost: %f \n', itr, min(plan_cost_list));

    fitness_list = 1 ./ plan_cost_list * 10000;

    % 3. 选择
    child_plan_list = ga_select(plan_list, fitness_list, gap_rate);
    % 4. 交叉操作
    child_plan_list = ga_cross(child_plan_list, cross_rate);
    % 5. 变异
    child_plan_list = ga_mutate(child_plan_list, mutate_rate);
    % 6. 逆转
    child_plan_list = ga_reverse(child_plan_list, master_task_list, a, u);
    % 7. 重插入子代的新种群
    plan_list = ga_replace(plan_list, fitness_list, child_plan_list);
end


for i = 1:pop_size
    plan_cost_list(i) = calc_plan_cost(master_task_list, plan_list(i, :), a, u);
end

fprintf('最短耗时: %f \n', min(plan_cost_list));

toc
