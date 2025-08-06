# GA-ANSYS Optimization Example

This repository contains a MATLAB example demonstrating how to integrate a
Genetic Algorithm (GA) with ANSYS 2022 R1 to minimize drag on a parametrized
body and prepare the resulting geometry for topology optimization.

## Files
- `ga_ansys_example.m`: MATLAB script that runs GA and calls ANSYS in batch mode.
- `run_drag_simulation.jou`: Placeholder ANSYS journal script that should read
  design parameters, build the model, run a CFD analysis, and output the drag
  value to `drag_output.txt`.

## Usage
1. Edit `run_drag_simulation.jou` with the appropriate APDL commands for your
   model.
2. Ensure the ANSYS executable path (`ansysExe`) in `ga_ansys_example.m` matches
   your installation.
3. Run the optimization from MATLAB:
   ```matlab
   bestDesign = ga_ansys_example();
   ```
4. After GA convergence, use the final parameters in ANSYS Mechanical to export
   an `.inp` file and perform topology optimization as needed.

> **Note:** The provided scripts are templates and must be completed with actual
> modeling and analysis commands to function in a real workflow.
