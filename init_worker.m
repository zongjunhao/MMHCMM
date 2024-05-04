% 初始化工作节点，在此处修改工作节点性能参数
% @param: worker_num: 工作节点数量
% @return: a, u: [worker_num, 1]
function [a, u] = init_worker(worker_num)
    a = zeros(worker_num, 1);
    u = zeros(worker_num, 1);

    for i = 1:round(worker_num / 2)
        a(i) = 1;
        u(i) = 1;
    end

    for i = round(worker_num / 2) + 1:worker_num
        a(i) = 4;
        u(i) = 0.5;
    end

end
