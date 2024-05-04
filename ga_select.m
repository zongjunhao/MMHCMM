% sus 选择策略
% @param: plan_list: [plan_num, worker_num]，种群
% @param: fitness_list: [plan_num, 1]，适应度
% @param: gap_rate: 留存率
% @return: selected_plan_list: [select_num, worker_num]，选择后的种群
function selected_plan_list = ga_select(plan_list, fitness_list, gap_rate)
    plan_num = length(plan_list);
    select_num = round(plan_num * gap_rate);
    selected_indices = ga_sus(fitness_list, select_num);
    selected_plan_list = plan_list(selected_indices, :);
end
