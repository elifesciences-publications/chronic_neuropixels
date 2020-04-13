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
    mkdir(plots_folder_path);
end
P.data_folder_path = [P.repository_path filesep 'data'];
if ~isfolder(P.data_folder_path)
    mkdir(data_folder_path);
end
P.choice_sel_mat_path = [P.data_folder_path filesep 'choice_modulation.mat'];
P.Cells_path = [P.data_folder_path filesep 'Cells.mat'];
%% analyses
P.noise_threshold_uV = 20;
P.gain_noise_example.implanted = 'gain_noise_17131311352_2019_10_09';
P.gain_noise_example.unimplanted = 'gain_noise_18194819542_2020_03_14';
% P.longevity_time_bin_edges = [0.5 1.5 2.5 6.5 14.5 30.5 60.5 120.5 500];
P.longevity_log2_time_bin_edges = -0.5:7.5;
P.longevity_time_bin_edges = 2.^(P.longevity_log2_time_bin_edges);
P.longevity_log2_time_bin_centers = P.longevity_log2_time_bin_edges(1:end-1)+diff(P.longevity_log2_time_bin_edges)/2;
P.longevity_time_bin_centers = 2.^(P.longevity_log2_time_bin_centers);
P.longevity_n_boots = 1000;
P.n_boots = 1000;
P.choice_sel_reference_event = 'cpoke_out';
P.choice_sel_steps_s = -1:0.02:0.5;
P.choice_sel_bin_s = 0.1;
%% plotting formats
P.figure_image_format = {'png', 'svg'};
P.figure_position_psychometrics = [rand*1000, rand*1000, 250, 250];
P.figure_position_behavioral_comparison = [rand*1000, rand*1000, 250, 250];
P.figure_position_gn = [rand*1000, rand*1000, 350, 250];
P.figure_position_gn_summary = [rand*1000, rand*1000, 250, 250];
P.figure_position_longevity = [rand*1000, rand*1000, 400, 350];
font_size = 14;
P.axes_properties = {'FontSize', font_size, ...
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
                                      'xtick',P.longevity_time_bin_centers, ...
                                      'fontsize', 12};
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
P.panel_label_font_size = font_size * 1.5;
P.panel_label_pos = [0.1, 0.9, 0.1, 0.1];
P.panel_labels = char(65:90);
P.text.unit = 'Units';
P.text.single_unit = 'Single units';
P.text.event_rate = 'Event rate';
P.text.Vpp = 'Peak-to-peak amplitude (uV)';