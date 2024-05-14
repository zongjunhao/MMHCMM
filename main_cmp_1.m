% 遍历所有工作节点选择方案+遍历所有负载分配方案 （小模型下）
% 1. 遍历所有节点选择方案，每个方案存储在 plan[worker_num. 1] 矩阵中。
% 2. 针对一个 plan 从中取出一个主节点，同时取出对应工作节点，对该组数据遍历所有负载分配方案，获得最低耗时。
% 3. 对一个计划中所有主节点重复应用步骤2，以耗时最长的主节点作为该 plan 耗时。
% 4. 对所有 plan 重复执行步骤 2-3，取耗时最小的plan作为最终输出结果。
clear
clc
close all
tic

master_num = 2; % 主机数量
worker_num = 5; % 工作节点数量

% 初始化主节点（每个主节点）
% master_task_list = [10000];
% master_task_list = [10000, 20000, 40000, 80000];
% master_task_list = [10000, 10000, 10000, 10000];
master_task_list = [200, 300];
% 初始化工作节点
[a, u] = init_worker(worker_num);

% 子节点计算时间
worker_cost = zeros(worker_num, 1);

for i = 1:worker_num
    worker_cost(i) = 1 / u(i) + a(i);
end

plan_num = master_num ^ worker_num;
min_cost = inf;

% 遍历所有节点选择方案
for plan_index = 1:plan_num
    plan = zeros(1, worker_num);

    % 获取节点选择方案 plan
    for worker_index = 1:worker_num
        plan(worker_index) = mod(floor((plan_index - 1) / master_num ^ (worker_index - 1)), master_num) + 1;
    end
    disp(plan)

    plan_cost = 0;
    % 对每个主节点计算耗时 master_cost，取最长耗时最为该 plan 耗时
    for master_index = 1:master_num
        fprintf("Plan %d, master %d start\n", plan_index, master_index)
        task_num = master_task_list(master_index);
        worker_index_list = find(plan == master_index);
        worker_num_of_master = length(worker_index_list);

        if worker_num_of_master == 0
            fprintf("Plan %d, master %d end.\n", plan_index, master_index)
            plan_cost = inf;
            break;
        end

        % 该主节点的工作节点的a和u值
        worker_cost_list = zeros(worker_num_of_master, 1);

        for i = 1:worker_num_of_master
            worker_cost_list(i) = worker_cost(worker_index_list(i));
        end

        master_cost = get_master_cost(task_num, worker_cost_list);

        plan_cost = max(plan_cost, master_cost);

        fprintf("Plan %d, master %d end. \n", plan_index, master_index)
    end

    % 取耗时最小的 plan 作为最终结果
    min_cost = min(min_cost, plan_cost);
end

fprintf('1 cmp 遍历所有工作节点选择方案+遍历所有负载分配方案 （小模型下）: %f \n', min_cost);

toc

% 对一个主节点和其对应的工作节点，遍历所有负载分配方案，求最小耗时作为 master_cost
function master_cost = get_master_cost(task_num, worker_cost_list)
    worker_num = length(worker_cost_list);
    all_assignments = get_all_assignments(task_num, worker_num);

    assignment_num = length(all_assignments);

    master_cost = inf;

    for assign_index = 1:assignment_num
        assignment = all_assignments{assign_index};
        assignment_cost = 0;
        % 计算每个子节点的耗时，取耗时最大的子节点作为该分配方案耗时
        for worker_index = 1:worker_num
            cost = worker_cost_list(worker_index) * assignment(worker_index);
            assignment_cost = max(assignment_cost, cost);
        end

        % 取耗时最小的分配方案作为该主节点的耗时
        master_cost = min(master_cost, assignment_cost);
    end

end

% 递归地获取所有负载分配方案
function all_assignments = get_all_assignments(task_num, worker_num)
    % 初始化结果列表
    all_assignments = {};

    % 递归分配任务
    function recurse(current_assignment, remain_tasks, remaining_workers)

        if remaining_workers == 1
            % 如果只剩一个worker，他必须接受所有剩余的任务
            all_assignments{end + 1} = [current_assignment, remain_tasks];
        else
            % 否则尝试分配至少一个任务给当前的worker，并递归处理剩余的任务和worker
            for i = 1:(remain_tasks - remaining_workers + 1)
                recurse([current_assignment, i], remain_tasks - i, remaining_workers - 1);
            end

        end

    end

    % 如果任务数不少于人数，开始递归分配
    if task_num >= worker_num
        recurse([], task_num, worker_num);
    end

end
