% 遗传算法节点分配方案（种群）初始化
% @param: pop_size: 种群大小
% @param: master_num: 主机数量
% @param: worker_num: 工作节点数量
% @return: pop_list: [pop_size, worker_num]，每一行代表一种分配方案
function pop_list = init_pop(pop_size, master_num, worker_num)
    pop_list = zeros(pop_size, worker_num);
    for i = 1:pop_size
        % 随机生成主机分配方案
        pop_list(i, :) = randi([1, master_num], 1, worker_num);
    end
end