function DriveSelf(brick, COLOR_SENSOR_PORT, TOUCH_SENSOR_PORT, ULTRASONIC_SENSOR_PORT, RIGHT_DRIVE_MOTOR, LEFT_DRIVE_MOTOR, DEST_COLOR)
    
% Ultrasonic Sensor Settings
    MAX_DIST=20;
    MIN_DIST=10;
    THRESHOLD=30;

    % Colors
    DESTINATION_CODE=ToColorCode(DEST_COLOR);
    
    BOTH_DRIVE_MOTORS = 'AB';

    while (brick.ColorCode(2) ~= DESTINATION_CODE)
        
        if (brick.UltrasonicDist(ULTRASONIC_SENSOR_PORT) > MAX_DIST + THRESHOLD)
            disp("turning right");
            brick.StopMotor('AB');
            
            brick.MoveMotor(BOTH_DRIVE_MOTORS, -80);
            pause(0.1);
            brick.StopMotor('AB');

            pause(1);
            brick.MoveMotor(LEFT_DRIVE_MOTOR, -90);
            brick.StopMotor(RIGHT_DRIVE_MOTOR, 'Brake');
            pause(1.1);
            brick.StopMotor('AB');

            brick.MoveMotor(RIGHT_DRIVE_MOTOR, -80);
            brick.MoveMotor(LEFT_DRIVE_MOTOR, -80);
            pause(0.3);
            brick.StopMotor('AB', 'Brake');
         elseif (brick.TouchPressed(TOUCH_SENSOR_PORT) == 1)
            disp("turning left");
            brick.StopMotor('AB');

            brick.MoveMotor(BOTH_DRIVE_MOTORS, 80);
            pause(0.45);
            brick.StopMotor('AB');

            pause(1);
            brick.MoveMotor(RIGHT_DRIVE_MOTOR, -90);
            pause(1);
            brick.StopMotor('AB');

            brick.MoveMotor(BOTH_DRIVE_MOTORS, -80);
            pause(0.3);
            brick.StopMotor('AB', 'Brake');
        elseif (brick.ColorCode(COLOR_SENSOR_PORT) == ToColorCode("red"))
            brick.StopMotor(BOTH_DRIVE_MOTORS, 'Brake');
            pause(1);
            brick.MoveMotor(BOTH_DRIVE_MOTORS, -50);
            pause(0.5);
            brick.StopMotor(BOTH_DRIVE_MOTORS, 'Coast');
            
        elseif (brick.UltrasonicDist(ULTRASONIC_SENSOR_PORT) >= MIN_DIST && brick.UltrasonicDist(ULTRASONIC_SENSOR_PORT) <= MAX_DIST)
            brick.MoveMotor(BOTH_DRIVE_MOTORS, -30);

        elseif (brick.UltrasonicDist(ULTRASONIC_SENSOR_PORT) < MIN_DIST)
            disp("adjusting proximity: too close");
            brick.MoveMotor(LEFT_DRIVE_MOTOR, -50);
            brick.MoveMotor(RIGHT_DRIVE_MOTOR, -60);

        elseif (brick.UltrasonicDist(ULTRASONIC_SENSOR_PORT) > MAX_DIST && brick.UltrasonicDist(ULTRASONIC_SENSOR_PORT) <= MAX_DIST + THRESHOLD)
            disp("adjusting proximity: too far");
            brick.MoveMotor(RIGHT_DRIVE_MOTOR, -50);
            brick.MoveMotor(LEFT_DRIVE_MOTOR, -60);

        end
    end

    brick.StopMotor('AB');
    disp("Resume manual control");
end


