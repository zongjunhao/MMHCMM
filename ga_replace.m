function new_plan_list = ga_replace(plan_list, fitness_list, child_plan_list)
    raw_size = size(plan_list, 1);
    selected_size = size(child_plan_list, 1);
    [~, sorted_index] = sort(fitness_list);
    new_plan_list = [plan_list(sorted_index(1:raw_size - selected_size), :); child_plan_list];
end
