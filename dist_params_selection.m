%selection convention [level orientation] (matlab style: 1,2,3)
%[0 0] = aproximation

load("coefficients wt=db4levels=5.mat")
selection = [5 1;
             4 3;
             4 2;
             3 2;
             0 0
             ];
distribution = 'Normal';
dist_params=fit_distribution_selection(coeffs, distribution, wavelet, levels, selection);




function dist_params = fit_distribution_selection(coeffs, distribution, wavelet, levels, selection)
    dist_params = coeffs;
    for instance = 1:size(coeffs, 1)
        for level = 1:size(coeffs{instance,1}, 2)
            [aproximation_selected, Loc] = ismember([0 0],selection,'rows');
            
            if level == 1 & aproximation_selected
                dist = fitdist( coeffs{instance,1}{1, level}(1,:).', distribution);
                dist_params{instance,1}{1, level} = dist.ParameterValues(1:2);
            else
                dist_params{instance,1}{1, level} = [];
                for orientation = 1:3
                        [is_selected, Loc] = ismember([levels-level+2 orientation],selection,'rows');
                        if is_selected 
                            dist = fitdist( coeffs{instance,1}{1, level}(orientation,:).', distribution);
                            dist_params{instance,1}{1, level}(orientation,:) = dist.ParameterValues(1:2);
                        end
                end 
            end
        end
    end
    save(strcat("dist_paramsSelect wt=", wavelet, " levels=", int2str(levels), " dist=", distribution), "dist_params", "distribution", "levels", "wavelet", "selection")
end