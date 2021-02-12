

% for levels = [5,6]
%     for wavelet = ["db4","db8","db12"]
%         for distribution = {'Normal', 'tLocationScale', 'Stable'}
%             load(strcat("coefficients wt=",wavelet,"levels=",int2str(levels),".mat"))
%             fit_distribution(coeffs, distribution{1}, wavelet, levels)
%         end
%     end
% end

%fit_distribution(coeffs, 'Stable', wavelet, levels)

function fit_distribution(coeffs, distribution, wavelet, levels)
    dist_params = coeffs;
    for instance = 1:size(coeffs, 1)
        for level = 1:size(coeffs{instance,1}, 2)
            if level == 1
                dist = fitdist( coeffs{instance,1}{1, level}(1,:).', distribution);
                dist_params{instance,1}{1, level} = dist.ParameterValues(:);
            else
                dist_params{instance,1}{1, level} = [];
                for orientation = 1:3
                    a = size(dist.ParameterValues(:))
                    dist = fitdist( coeffs{instance,1}{1, level}(orientation,:).', distribution);
                    dist_params{instance,1}{1, level}(orientation,:) = dist.ParameterValues(:);

                end 
            end
        end
    end
    save(strcat("dist_params wt=", wavelet, " levels=", int2str(levels), " dist=", distribution), "dist_params", "distribution", "levels", "wavelet")
end