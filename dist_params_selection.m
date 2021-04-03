%selection convention [level orientation] (matlab style: 1,2,3)
%[0 0] = aproximation
coeff_folder_path = "E:\Backups\Work&Uni\University\ML for food authentication\Results_fitting\coefficients\New Images\";
save_folder_path = "E:\Backups\Work&Uni\University\ML for food authentication\Results_fitting\dist_paramsSelect\New Images\";
coeffs_title = "coefficients wt=db4levels=3_hdf5.mat";
coeffs_path=strcat(coeff_folder_path, coeffs_title);
selection = [1 1;
             1 2;
             1 3;
             
             2 1;
             2 2;
             2 3;
             
             3 1;
             3 2;
             3 3;
             ];
         
distribution = 'Stable';
dist_params = fit_distribution_selection_hdf5(coeffs_path, save_folder_path, distribution, selection);




function dist_params = fit_distribution_selection(coeffs_path, save_folder_path, distribution, selection)
    load(coeffs_path);
    dist_params = coeffs;
    for instance = 1:size(coeffs, 1)
        for level = 1:size(coeffs{instance,1}, 2)
            [aproximation_selected, Loc] = ismember([0 0],selection,'rows');
            
            if level == 1 & aproximation_selected
                dist = fitdist( coeffs{instance,1}{1, level}(1,:).', distribution);
                dist_params{instance,1}{1, level} = dist.ParameterValues(:).';
            else
                dist_params{instance,1}{1, level} = [];
                for orientation = 1:3
                    [is_selected, Loc] = ismember([levels-level+2 orientation],selection,'rows');
                    if is_selected 
                        a=[levels-level+2 orientation]
                        dist = fitdist( coeffs{instance,1}{1, level}(orientation,:).', distribution);
                        dist_params{instance,1}{1, level}(orientation,:) = dist.ParameterValues(:).';
                    end
                end 
            end
        end
    end
    save(strcat(save_folder_path, "dist_paramsSelect wt=", wavelet, " levels=", int2str(levels), " dist=", distribution), "dist_params", "distribution", "levels", "wavelet", "selection")
end

function dist_params = fit_distribution_selection_hdf5(coeffs_path, save_folder_path, distribution, selection)
    load(coeffs_path);
    dist_params = coeffs;
    for instance = 1:size(coeffs, 1)
        for level = 1:size(coeffs{instance,1}, 2)
            [aproximation_selected, Loc] = ismember([0 0],selection,'rows');
            
            if level == 1 & aproximation_selected
                dist = fitdist( coeffs{instance,1}{1, level}(1,:).', distribution);
                dist_params{instance,1}{1, level} = dist.ParameterValues(:).';
            else
                dist_params{instance,1}{1, level} = [];
                for orientation = 1:3
                    [is_selected, Loc] = ismember([levels-level+2 orientation],selection,'rows');
                    if is_selected 
                        a=[levels-level+2 orientation]
                        dist = fitdist( coeffs{instance,1}{1, level}{1,orientation}(1,:).', distribution);
                        dist_params{instance,1}{1, level}(orientation,:) = dist.ParameterValues(:).';
                    end
                end 
            end
        end
    end
    save(strcat(save_folder_path, "dist_paramsSelect wt=", wavelet, " levels=", int2str(levels), " dist=", distribution), "dist_params", "distribution", "levels", "wavelet", "selection")
end