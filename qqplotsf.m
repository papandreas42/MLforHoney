coeff_folder_path = "D:\Work and uni\University\ML for food authentication\Results_fitting\coefficients\";
save_folder_path = "D:\Work and uni\University\ML for food authentication\Results_fitting\dist_params\";
coeffs_title = "coefficients wt=db4levels=5.mat";
coeffs_path=strcat(coeff_folder_path, coeffs_title);

load(strcat(coeffs_path))
qqplots( save_folder_path ,coeffs{5,1}, 5-1, 'tLocationScale', wavelet, levels);


% for levels = [5,6]
%     for wavelet = ["db4","db8","db12"]
%         load(strcat(coeff_folder_path,"coefficients wt=",wavelet,"levels=",int2str(levels),".mat"))
%         for distribution = {'Normal', 'tLocationScale', 'Stable'}
%             for index = 1:size(coeffs, 1)
%                 qqplots( save_folder_path ,coeffs{index,1}, index-1, distribution{1}, wavelet, levels);
%                 close;
%             end
%         end
%     end
% end



function qqplots(save_folder_path ,coeffs_of_one_image, id_of_image, distribution, wavelet, levels)
    font_size = 2;
    fig = figure;
    levels=double(levels);
    rows = levels+1;
    columns = 3;
    for level = 1:size(coeffs_of_one_image, 2)
        if level == 1
            ax = subplot(rows , columns, levels.*3 + 1);
            line = qqplot(coeffs_of_one_image{1, level}(1,:), makedist(distribution));
            %style
            ax.PlotBoxAspectRatioMode = 'manual';
            ax.PlotBoxAspectRatio = [2 1 1];
            ax.Title.String = 'Approximation';
            ax.YLabel.String = 'Sample Quantiles';
            ax.XLabel.String = 'Theoretical Quantiles';
            ax.FontSize=font_size;
            set(line(1),  'Marker','.');
            set(line(1),  'MarkerSize',1);
            set(line(1),  'MarkerEdgeColor', 'black');
            set(line(3),  'LineStyle','-');
            set(line(3),  'LineWidth', 0.2);

        else
            for orientation = 1:3
                if orientation == 1
                    title_of_plot=strcat("Level ",int2str(levels-level+2),": Horizontal");
                elseif orientation == 2
                    title_of_plot=strcat("Level ",int2str(levels-level+2),": Vertical");
                elseif orientation == 3
                    title_of_plot=strcat("Level ",int2str(levels-level+2),": Diagonal");
                end
                ax = subplot(rows , columns, (levels-level+1).*3 + orientation);
                line = qqplot(coeffs_of_one_image{1, level}(orientation,:), makedist(distribution));
                %style
                ax.PlotBoxAspectRatioMode = 'manual';
                ax.PlotBoxAspectRatio = [2 1 1];
                ax.Title.String = title_of_plot;
                ax.YLabel.String = 'Sample Quantiles';
                ax.XLabel.String = 'Theoretical Quantiles';
                ax.FontSize=font_size;
                set(line(1),  'Marker','.');
                set(line(1),  'MarkerSize',1);
                set(line(1),  'MarkerEdgeColor', 'black');
                set(line(3),  'LineStyle','-');
                set(line(3),  'LineWidth', 0.2);
            end 
        end
    end
    title= strcat("qqplots wt=", wavelet, " levels=", int2str(levels), " dist= ", distribution, " ", int2str(id_of_image));
    sup_title = suptitle(title);
    set(sup_title, 'FontSize', 5)
    print(fig, strcat(save_folder_path ,title, ".jpg" ), '-djpeg', '-r600')
end

