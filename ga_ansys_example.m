% ga_ansys_example.m
% Example script showing how to integrate MATLAB's GA with ANSYS 2022 R1
% to minimize drag and run topology optimization.

function bestDesign = ga_ansys_example()
    % Number of design variables: e.g., length, diameter, curvature
    nvars = 3;

    % Bounds for design variables
    lb = [0.01, 0.005, 0];  % lower bounds
    ub = [0.1, 0.05, 1];    % upper bounds

    % GA options
    options = optimoptions('ga', ...
        'PopulationSize', 20, ...
        'MaxGenerations', 30, ...
        'UseParallel', false, ...
        'Display', 'iter');

    % Objective function handle
    obj = @(x) run_ansys_and_compute_drag(x);

    % Run the genetic algorithm
    [bestDesign, bestDrag] = ga(obj, nvars, [], [], [], [], lb, ub, [], options);

    fprintf('Best design variables: %s\n', mat2str(bestDesign));
    fprintf('Corresponding drag: %g\n', bestDrag);
end

function drag = run_ansys_and_compute_drag(designVars)
    % Write design variables to ANSYS input parameters file
    paramFile = 'design_parameters.txt';
    fid = fopen(paramFile, 'w');
    fprintf(fid, 'L=%f\nD=%f\nC=%f\n', designVars(1), designVars(2), designVars(3));
    fclose(fid);

    % Call ANSYS in batch mode using a journal or APDL script
    % Update the path to your ANSYS executable and script as needed.
    ansysExe = 'ansys2022r1';
    ansysScript = 'run_drag_simulation.jou';
    cmd = sprintf('%s -b -i %s -o ansys_out.log', ansysExe, ansysScript);
    status = system(cmd);
    if status ~= 0
        error('ANSYS run failed');
    end

    % Read drag value from ANSYS results
    resultFile = 'drag_output.txt';
    if ~isfile(resultFile)
        error('Expected result file not found');
    end
    data = readtable(resultFile, 'FileType', 'text');
    drag = data.Drag(1);
end

