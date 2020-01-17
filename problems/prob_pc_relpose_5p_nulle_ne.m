classdef prob_pc_relpose_5p_nulle_ne < problem
    properties
        NE = sym('NE%d%d%d', [4, 3, 3]);
        w = sym('w%d', [3, 1]);
    end
    methods
        function [eqs_sym, abbr_subs] = gen_eqs_sym(obj)
            NE = permute(obj.NE, [2, 3, 1]);
            NE = reshape(NE, 9, 4);
            E = reshape(NE * [obj.w; 1], 3, 3);
            eqs_sym = sym([]);
            eqs_sym(1) = det(E);
            Et = transpose(E);
            te = 2*(E*Et)*E - trace(E*Et)*E;
            eqs_sym(2:10) = te(:);

            abbr_subs = struct([]);
        end
        function [in_subs, out_subs] = gen_arg_subs(obj)
            in_subs = struct();
            in_subs.NE = obj.NE;
            out_subs.w = obj.w;
        end
        function [in_zp, out_zp] = rand_var_zp(obj, p)
            [in_zp, out_zp] = vzp_rand_relpose_pinhole(5, p, {'NE'}, {'w'});
        end
        function [in_rl, out_rl] = rand_par_rl(obj)
            [in_rl, out_rl] = vrl_rand_relpose_pinhole(5, {'NE'}, {'w'});
        end
    end
end