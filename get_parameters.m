% GET_PARAMETERS Returns a structure with the parameters for analyses for
% the manuscript, such as file paths
%
%=OUTPUT
%
%   P
%       A structure with parameters for analyses
%
function P = get_parameters()
%% paths
P.repository_path = fileparts(mfilename('fullpath'));
P.rat_info_path =               [P.repository_path filesep 'behavioral_performance' filesep 'rat_info.csv'];
P.behavior_table_path =         [P.repository_path filesep 'behavioral_performance' filesep 'behavior_table.csv'];
P.recording_sessions_path =     [P.repository_path filesep 'behavioral_performance' filesep 'recording_sessions.csv'];
P.performance_by_session_path = [P.repository_path filesep 'behavioral_performance' filesep 'performance_by_session.csv'];
P.performance_by_rat_path =     [P.repository_path filesep 'behavioral_performance' filesep 'performance_by_rat.csv'];
P.behavior_plots_folder =       [P.repository_path filesep 'behavioral_performance' filesep 'plots'];
P.opto_ephys_log_path =         [P.repository_path filesep 'behavioral_performance' filesep 'Opto-ephys log.xlsx'];
P.pharmacology_log_path =       [P.repository_path filesep 'behavioral_performance' filesep 'Pharmacology log.xlsx'];
P.gain_noise_fldr_path =        [P.repository_path filesep 'gain_noise'];
P.gain_noise_log_path =         [P.gain_noise_fldr_path filesep 'gain_noise_log.csv'];
P.gain_noise_data_path = 'X:\RATTER\PhysData\NP_gain_noise\';
P.longevity_folder_path = [P.repository_path filesep 'longevity'];
P.Thomass_recordings_path = [P.longevity_folder_path filesep 'Thomass_recordings.csv'];
P.Adrians_recordings_path = [P.longevity_folder_path filesep 'recordings_log.csv'];
P.implant_log_path = [P.longevity_folder_path filesep 'implant_log.csv'];
P.choice_sel_data_path = 'X:\RATTER\PhysData\NP_sorted\Thomas';
P.choice_sel_file_names = {'T212_2019_08_14'; ...
                           'T224_2019_11_18'; ...
                           'T249_2020_02_12'};
%% paths to folders to be ignored by git
P.plots_folder_path = [P.repository_path filesep 'plots'];
if ~isfolder(P.plots_folder_path)
    mkdir(P.plots_folder_path);
end
P.data_folder_path = [P.repository_path filesep 'data'];
if ~isfolder(P.data_folder_path)
    mkdir(P.data_folder_path);
end
P.choice_sel_mat_path = [P.data_folder_path filesep 'choice_modulation.mat'];
P.Cells_path = [P.data_folder_path filesep 'Cells.mat'];
P.exp_decay_data_path = [P.data_folder_path filesep 'exp_decay_data.mat'];
P.sum_exp_data_path = [P.data_folder_path filesep 'sum_exp_data.mat'];
%% analyses
P.noise_threshold_uV = 20;
P.gain_noise_example.implanted = 'gain_noise_17131311352_2019_10_09';
P.gain_noise_example.unimplanted = 'gain_noise_18194819542_2020_03_14';
% P.longevity_time_bin_edges = [0.5 1.5 2.5 6.5 14.5 30.5 60.5 120.5 500];
P.longevity_log2_time_bin_edges = -0.5:7.5;
P.longevity_time_bin_edges = 2.^(P.longevity_log2_time_bin_edges);
P.longevity_log2_time_bin_centers = P.longevity_log2_time_bin_edges(1:end-1)+diff(P.longevity_log2_time_bin_edges)/2;
P.longevity_time_bin_centers = 2.^(P.longevity_log2_time_bin_centers);
P.longevity_metrics = {'unit', ...
                       'single_unit', ...
                       'event_rate', ...
                       'Vpp', ...
                       'frac_single'};
P.longevity_n_boots = 1000;
P.exp_decay_n_boots = 1000;
P.ED_trode_factors = {'AP', 'AP_cat', 'DV', 'DV_cat', 'ML', 'SP', 'SO'};
P.ED_trode_regressors = {'y0_AP', 'y0_AP_cat', 'y0_DV', 'y0_DV_cat', 'y0_ML', 'y0_SP', 'y0_SO', ...
                         'k_AP',   'k_AP_cat',  'k_DV',  'k_DV_cat',     'k_ML',  'k_SP',  'k_SO'};
P.ED_excluded_pairs = {[1,2], [3,4], [8,9], [10,11], [1,9], [2,8], [3,11], [4,10]};
P.ED_trode_regressors_all = {'y0', 'y0_AP', 'y0_AP_cat', 'y0_DV', 'y0_DV_cat', 'y0_ML', 'y0_SP', 'y0_SO', ...
                             'k', 'k_AP',   'k_AP_cat',  'k_DV',  'k_DV_cat',     'k_ML',  'k_SP',  'k_SO'};
P.ED_trode_regressors_symbols = {'\beta_{0}^{N_{1}}',
                                '\beta_{AP}^{N_{1}}', 
                                '\beta_{AP>0}^{N_{1}}', 
                                '\beta_{DV}^{N_{1}}',
                                '\beta_{DV>-2}^{N_{1}}', 
                                '\beta_{ML}^{N_{1}}', 
                                '\beta_{SP}^{N_{1}}',
                                '\beta_{SO}^{N_{1}}'
                                '\beta_{0}^{\tau}',
                                '\beta_{AP}^{\tau}', 
                                '\beta_{AP>0}^{\tau}', 
                                '\beta_{DV}^{\tau}',
                                '\beta_{DV>-2}^{\tau}', 
                                '\beta_{ML}^{\tau}', 
                                '\beta_{SP}^{\tau}',
                                '\beta_{SO}^{\tau}'};
P.ED_trode_regressors_explanation = { '',
                                '(mm anterior)', 
                                '', 
                                '(mm dorsal)',
                                '(dorsal cortex)', 
                                '(mm lateral)', 
                                '(mm from tip)',
                                '(coronal plane)'
                                '',
                                '(mm anterior)', 
                                '', 
                                '(mm dorsal)',
                                '(dorsal cortex)', 
                                '(mm lateral)', 
                                '(mm from tip)',
                                '(coronal plane)'};
P.ED_trode_regressors_names =cellfun(@(x,y) ['\parbox[b]{2in}{$' x, '\\$', y '}'], ...
                                    P.ED_trode_regressors_symbols, ...
                                    P.ED_trode_regressors_explanation, 'uni', 0);
P.ED_trode_regressors_symbols = cellfun(@(x) ['$' x '$'], P.ED_trode_regressors_symbols, 'uni', 0);
P.ED_trode_selection_criterion = 'mse_med';

P.unit_distance = 0;
P.x0 = min(P.longevity_time_bin_centers);
P.n_boots = 1000;
P.choice_sel_reference_event = 'cpoke_out';
P.choice_sel_steps_s = -1:0.02:0.5;
P.choice_sel_bin_s = 0.1;
P.AP_bin_edges = [-8, 0, 4];
P.DV_bin_edges = [-10, -2,   0];
P.EI_bin_edges = [1, 193, 385, 577, 769];
P.ML_bin_edges = [0 1 4];
P.brain_area_groups = {{'PrL', 'MO'}, {'other'}};
%% Sum of exponentials model for electrodes

P.sum_exp_trodes.exp_factors = {'AP', 'AP_gt0', 'DV', 'DV_gtn2', 'ML', 'SP', 'SO'};
P.sum_exp_trodes.regressors = {'N1_const', 'N1_AP', 'N1_AP_gt0', 'N1_DV', 'N1_DV_gtn2', 'N1_ML', ...
                               'k_const',   'k_AP',  'k_AP_gt0',  'k_DV',  'k_DV_gtn2',  'k_ML', 'k_SP', 'k_SO'};
P.sum_exp_trodes.selection_criterion='MSE_norm';
P.sum_exp_trodes.data_path=[P.data_folder_path filesep 'sum_exp_trodes_data.mat'];
P.sum_exp_trodes.regressor_labels = {'$\alpha$', ...
                                       '$k_{0}$', ...
                                       '$\beta^{N_{1}}_{0}$', ...
                                       '$\beta^{N_{1}}_{AP}$', ...
                                       '$\beta^{N_{1}}_{AP>0}$', ...
                                       '$\beta^{N_{1}}_{DV}$', ...
                                       '$\beta^{N_{1}}_{DV>-2}$', ...
                                       '$\beta^{N_{1}}_{ML}$', ...
                                       '$\beta^{k}_{0}$', ...
                                       '$\beta^{k}_{AP}$', ...
                                       '$\beta^{k}_{AP>0}$', ...
                                       '$\beta^{k}_{DV}$', ...
                                       '$\beta^{k}_{DV>-2}$', ...
                                       '$\beta^{k}_{ML}$', ...
                                       '$\beta^{k}_{SP}$', ...
                                       '$\beta^{k}_{SO}$'};
%% plotting formats
P.figure_image_format = {'png', 'svg'};
P.figure_position_psychometrics = [rand*1000, rand*1000, 250, 250];
P.figure_position_behavioral_comparison = [rand*1000, rand*1000, 250, 250];
P.figure_position_gn = [rand*1000, rand*1000, 350, 250];
P.figure_position_gn_summary = [rand*1000, rand*1000, 250, 250];
P.figure_position_longevity = [rand*1000, rand*1000, 400, 350];
P.font_size = 14;
P.axes_properties = {'FontSize', P.font_size, ...
                     'Color', 'none', ...
                     'TickDir', 'Out',...
                     'Nextplot', 'add', ...
                     'LineWidth', 1,...
                     'XColor', [0,0,0], ...
                     'YColor', [0,0,0], ...
                     'LabelFontSizeMultiplier', 1};
P.custom_axes_properties.trials_done = {'XScale', 'log', ...
                                        'YScale', 'log', ...
                                        'XLim', [100, 2e3], ...
                                        'YLim', [100, 2e3]};
P.custom_axes_properties.abs_bias = {'XLim', [0, 12], ...
                                        'YLim', [0, 12], ...
                                        'XTick', [0, 5, 10], ...
                                        'YTick', [0, 5, 10]};
P.custom_axes_properties.sens = {'XLim', [0, 0.3], ...
                                        'YLim', [0, 0.3]};
P.custom_axes_properties.longevity = {'xscale','log',...
                                      'xlim',[min(P.longevity_time_bin_edges), ...
                                              max(P.longevity_time_bin_edges)],...
                                      'xtick',P.longevity_time_bin_centers};
P.color_order = 1/255 *  [230,  25,  75; ...
                               60, 180,  75; ...
                              ...255, 225,  25; ...
                                0, 130, 200; ...
                              245, 130,  48; ...
                              145,  30, 180; ...
                               70, 240, 240; ...
                              ...240,  50, 230; ...
                              ...210, 245,  60; ...
                              ...250, 190, 190; ...
                                0, 128, 128; ...
                              ...230, 190, 255; ...
                              170, 110,  40; ...
                              ...255, 250, 200; ...
                              128,   0,   0; ...
                              ...170, 255, 195; ...
                              128, 128,   0; ...
                              ...255, 215, 180; ...
                                0,   0, 128];
P.color_order = repmat(P.color_order, 10, 1);
P.marker_order = 'o*^+xsdv><ph';
P.marker_order = repmat(P.marker_order, 1, 10);
P.line_order = {'-', '--', ':', '-.'};
P.panel_label_font_size = P.font_size * 1.5;
P.panel_label_pos = [0.1, 0.9, 0.1, 0.1];
P.panel_labels = char(65:90);
P.text.unit = 'Units';
P.text.single_unit = 'Single units';
P.text.frac_single = 'Fraction single units';
P.text.event_rate = 'Event rate';
P.text.Vpp = 'Peak-to-peak amplitude (uV)';
P.text.AP = 'AP';
P.text.DV = 'DV';
P.text.ML = 'ML';
P.text.AP = 'AP';
P.text.DV = 'DV';
P.text.SP = 'Shank\newline  pos.';
P.text.SO = 'Shank\newline  ori.';
P.text.alpha = 'Frac. with fast decay (\alpha)';
P.text.tau_s = '\tau_{slow}';
P.text.tau_f = '\tau_{fast}';