% Convergence of Manufactured Solutions Code

        % [Ui_5,Uiexact_5]=implicit_ms(5,0.01);
        % [Ui_10,Uiexact_10]=implicit_ms(10,0.01);
        % [Ui_20,Uiexact_20]=implicit_ms(20,0.01);
        % [Ui_30,Uiexact_30]=implicit_ms(30,0.01);
        % [Ui_40,Uiexact_40]=implicit_ms(40,0.01);
        % [Ui_50,Uiexact_50]=implicit_ms(50,0.01);
        % [Ui_60,Uiexact_60]=implicit_ms(60,0.01);
        % [Ui_70,Uiexact_70]=implicit_ms(70,0.01);

        % [Ue_5,Ueexact_5]=explicit_ms(5,0.001);
        % [Ue_10,Ueexact_10]=explicit_ms(10,0.001);
        % [Ue_15,Ueexact_15]=explicit_ms(15,0.001);
        % [Ue_20,Ueexact_20]=explicit_ms(20,0.001);
        % [Ue_25,Ueexact_25]=explicit_ms(25,0.001);
        % [Ue_30,Ueexact_30]=explicit_ms(30,0.001);
        % [Ue_35,Ueexact_35]=explicit_ms(35,0.001);
        % [Ue_40,Ueexact_40]=explicit_ms(40,0.001);
        % [Ue_50,Ueexact_50]=explicit_ms(50,0.001);
        % [Ue_60,Ueexact_60]=explicit_ms(60,0.001);
        % [Ue_70,Ueexact_70]=explicit_ms(70,0.001);
        % [Ue_80,Ueexact_80]=explicit_ms(80,0.001);
        % [Ue_90,Ueexact_90]=explicit_ms(90,0.001);
        
        % Convergence wrt time

        % [Ui_5,~,~,ti_5]=implicit_ms(5,0.01);
        % [Ui_10,~,~,ti_10]=implicit_ms(10,0.01);
        % [Ui_15,~,~,ti_15]=implicit_ms(15,0.01);
        % [Ui_20,~,~,ti_20]=implicit_ms(20,0.01);
        % [Ui_30,~,~,ti_30]=implicit_ms(30,0.01);
        % [Ui_40,~,~,ti_40]=implicit_ms(40,0.01);

        % [Ue_5,Ueexact_5]=explicit_ms(5,0.001);
        % [Ue_10,Ueexact_10]=explicit_ms(10,0.001);
        % [Ue_15,Ueexact_15]=explicit_ms(15,0.001);
        % [Ue_20,Ueexact_20]=explicit_ms(20,0.001);
        % [Ue_25,Ueexact_25]=explicit_ms(25,0.001);
        % [Ue_30,Ueexact_30]=explicit_ms(30,0.001);
        % [Ue_35,Ueexact_35]=explicit_ms(35,0.001);
        % [Ue_40,Ueexact_40]=explicit_ms(40,0.001);
        % [Ue_45,Ueexact_45]=explicit_ms(45,0.001);
        % [Ue_50,Ueexact_50]=explicit_ms(50,0.001);
        % [Ue_60,Ueexact_60]=explicit_ms(60,0.001);
        % [Ue_80,Ueexact_80]=explicit_ms(80,0.001);

% Convergence wrt spatial mesh, steady state

    % [Ui_5,~,~,ti_5]=implicit_ss(5,0.01);
    % [Ui_10,~,~,ti_10]=implicit_ss(10,0.01);
    % [Ui_15,~,~,ti_15]=implicit_ss(15,0.01);
    % [Ui_20,~,~,ti_20]=implicit_ss(20,0.01);
    % [Ui_30,~,~,ti_30]=implicit_ss(30,0.01);
    % [Ui_40,~,~,ti_40]=implicit_ss(40,0.01);

    % [Ue_5,~,~,te_5]=explicit_ss(5,0.001);
    % [Ue_10,~,~,te_10]=explicit_ss(10,0.001);
    % [Ue_15,~,~,te_15]=explicit_ss(15,0.001);
    % [Ue_20,~,~,te_20]=explicit_ss(20,0.001);
    % [Ue_30,~,~,te_30]=explicit_ss(25,0.001);
    % [Ue_40,~,~,te_40]=explicit_ss(30,0.001);
    % [Ue_20,~,~,te_20]=explicit_ss(35,0.001);
    % [Ue_30,~,~,te_30]=explicit_ss(40,0.001);
    % [Ue_40,~,~,te_40]=explicit_ss(45,0.001);
    % [Ue_20,~,~,te_20]=explicit_ss(50,0.001);

% Convergence wrt time, steady state
% 
%     [Ui_1,~,~,ti_1]=implicit_ss(20,0.5);
%     [Ui_2,~,~,ti_2]=implicit_ss(20,0.25);
%     [Ui_3,~,~,ti_3]=implicit_ss(20,0.1);
%     [Ui_4,~,~,ti_4]=implicit_ss(20,0.05);
%     [Ui_5,~,~,ti_5]=implicit_ss(20,0.025);
%     [Ui_6,~,~,ti_6]=implicit_ss(20,0.01);
%     [Ui_7,~,~,ti_7]=implicit_ss(20,0.001);

%     [Ue_1,~,~,te_1]=explicit_ss(20,0.5);
%     [Ue_2,~,~,te_2]=explicit_ss(20,0.25);
%     [Ue_3,~,~,te_3]=explicit_ss(20,0.1);
%     [Ue_4,~,~,te_4]=explicit_ss(20,0.05);
%     [Ue_5,~,~,te_5]=explicit_ss(20,0.025);
%     [Ue_6,~,~,te_6]=explicit_ss(20,0.01);
%     [Ue_7,~,~,te_7]=explicit_ss(20,0.001);