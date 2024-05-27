% HCMM算法，给定工作节点和任务，计算所需时间
% 说明：只获取时间消耗cost的情况下，如需要具体的节点任务分配 l 信息，可打开注释
% @param: task_num: int，任务量（行）
% @param: worker_num: int，工作节点数量
% @param: S: int，每行计算前大小
% @param: s: int，每行计算后大小
% @param: R: float，主节点任务下发时间
% @param: a: [worker_num]，工作节点的a值
% @param: u: [worker_num]，工作节点的u值
% @param: r: [worker_num]，工作节点的r值
% @return: cost: float，所需时间
function cost = hcmm(task_num, worker_num, S, s, R, a, u, r)
    % Tmax = 1000;
    % t = Tmax;

    lam = zeros(worker_num, 1);
    % l_star_t = zeros(worker_num, 1);
    % l_star_t_star = zeros(worker_num, 1);

    % 用二分法求解Lambda(i)
    for i = 1:worker_num
        lam(i) = hcmm_division(@hcmm_lambda, S, s, R, a(i), u(i), r(i), 0.00005, 0, 100);
    end

    % % solve P(alt1) for any feasible t
    % for i = 1:worker_num
    %     l_star_t(i) = t / lam(i);
    %
    %     if (t < a(i) * l(i))
    %         fprintf('警告：t < a(%d) * l(%d)\n', i, i);
    %     end
    %
    % end

    % 计算s（现为γ）
    s = 0;

    for i = 1:worker_num
        s = (u(i) / (1 + u(i) * lam(i))) + s;
    end

    % solve and obtain tstar
    t_star = task_num / s;

    % for i = 1:N
    %     l_star_t_star(i) = t_star / lam(i);
    %     %     fprintf('%f\n', a(i) * l_star(i));
    %     if (t < a(i) * l_star(i))
    %         fprintf('警告：t < a(%d) * l_star(%d), %f\n', i, i, a(i) * l_star(i));
    %     end
    %
    %     fprintf('第 %d 个子节点分配 %f 行\n', i, l_star(i));
    % end
    %
    % fprintf('计算总耗时：%f\n', t_star);

    cost = t_star;
end
