% 初始化工作节点，在此处修改工作节点性能参数
% @param: worker_num: 工作节点数量
% @return: a: [master_num] 位移参数
% @return: u: [master_num] 掉队参数
% @return: r: [master_num] 上传速率
function [a, u, r] = init_worker(worker_num)
    % 设定 worker 种类数，每种 worker 的参数，不同种 worker 的比例
    worker_type_num = 3;
    base_a = [1, 4, 12];
    base_u = [0.5, 2, 0.25];
    base_r = [10, 50, 100];
    scale = [1, 1, 1];

    total_scale = sum(scale);
    type_start_end = zeros(1, worker_type_num + 1);
    % 按比例计算不同 worker 的数量起始点
    for i = 1:worker_type_num
        type_start_end(i + 1) = type_start_end(i) + round(scale(i) / total_scale * worker_num);
    end
    % 由于四舍五入余下的节点分配给最后一类
    type_start_end(worker_type_num + 1) = worker_num;
    a = zeros(1, worker_num);
    u = zeros(1, worker_num);
    r = zeros(1, worker_num);

    % 对不同种类 worker 分配对应的参数
    for type_idx = 1:worker_type_num

        for worker_idx = type_start_end(type_idx) + 1:type_start_end(type_idx + 1)
            a(worker_idx) = base_a(type_idx);
            u(worker_idx) = base_u(type_idx);
            r(worker_idx) = base_r(type_idx);
        end

    end

end
