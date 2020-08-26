global key
InitKeyboard();

COLOR_SENSOR_PORT=2;
TOUCH_SENSOR_PORT=1;
ULTRASONIC_SENSOR_PORT=4;

RIGHT_DRIVE_MOTOR='B';
LEFT_DRIVE_MOTOR='A';
BOTH_DRIVE_MOTORS=convertStringsToChars("AB");

while 1
    pause(0.1);
    switch key
        case 'uparrow'
            disp('going forwards');
            brick.MoveMotor(BOTH_DRIVE_MOTORS,-100);
            
        case 'downarrow'
            disp('going backwards');
            brick.MoveMotor(BOTH_DRIVE_MOTORS, 100);
            
        case 'leftarrow'
            disp('turning left');
            brick.MoveMotorAngleRel('B', -100,180);
            brick.MoveMotorAngleRel('A', 100,180);
        case 'rightarrow'
            disp('turning right');
            brick.MoveMotorAngleRel('A', -100,180);
            brick.MoveMotorAngleRel('B', 100,180);
            
        case 0
            brick.StopMotor('A');
            brick.StopMotor('B');
        case 'q'
            disp('quitting');
            brick.StopMotor('A');
            brick.StopMotor('B');
            break;
        case 's'
            brick.MoveMotor('D',5);
            pause(0.55);
            brick.StopMotor('D');
        case 'w'
            brick.MoveMotor('D',-5);
            pause(0.55);
            brick.StopMotor('D');
        case 'd'
            disp('driving self to next destination');
            DriveSelf(brick, COLOR_SENSOR_PORT, TOUCH_SENSOR_PORT, ULTRASONIC_SENSOR_PORT, RIGHT_DRIVE_MOTOR, LEFT_DRIVE_MOTOR, "green");
    end
end
CloseKeyboard();