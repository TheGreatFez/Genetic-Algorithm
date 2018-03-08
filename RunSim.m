Throttle = sim_runner(1);
PitchOverAlt = sim_runner(2);
PitchOverAngle = sim_runner(3);
GravityTurn = 1;
PitchProgram = PitchProgramSet(GravityTurn, PitchOverAlt, PitchOverAngle);
SSIGN = sim_runner(4);
PitchSwitch = sim_runner(5);
evalc('sim(''NewOrbitSimulation'')');