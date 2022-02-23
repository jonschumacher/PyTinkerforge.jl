


export BrickletSilentStepperV2SpeedRamping
struct BrickletSilentStepperV2SpeedRamping
    acceleration::Integer
    deacceleration::Integer
end

export BrickletSilentStepperV2StepConfiguration
struct BrickletSilentStepperV2StepConfiguration
    step_resolution::Integer
    interpolation::Bool
end

export BrickletSilentStepperV2BasicConfiguration
struct BrickletSilentStepperV2BasicConfiguration
    standstill_current::Integer
    motor_run_current::Integer
    standstill_delay_time::Integer
    power_down_time::Integer
    stealth_threshold::Integer
    coolstep_threshold::Integer
    classic_threshold::Integer
    high_velocity_chopper_mode::Bool
end

export BrickletSilentStepperV2SpreadcycleConfiguration
struct BrickletSilentStepperV2SpreadcycleConfiguration
    slow_decay_duration::Integer
    enable_random_slow_decay::Bool
    fast_decay_duration::Integer
    hysteresis_start_value::Integer
    hysteresis_end_value::Integer
    sine_wave_offset::Integer
    chopper_mode::Integer
    comparator_blank_time::Integer
    fast_decay_without_comparator::Bool
end

export BrickletSilentStepperV2StealthConfiguration
struct BrickletSilentStepperV2StealthConfiguration
    enable_stealth::Bool
    amplitude::Integer
    gradient::Integer
    enable_autoscale::Bool
    force_symmetric::Bool
    freewheel_mode::Integer
end

export BrickletSilentStepperV2CoolstepConfiguration
struct BrickletSilentStepperV2CoolstepConfiguration
    minimum_stallguard_value::Integer
    maximum_stallguard_value::Integer
    current_up_step_width::Integer
    current_down_step_width::Integer
    minimum_current::Integer
    stallguard_threshold_value::Integer
    stallguard_mode::Integer
end

export BrickletSilentStepperV2MiscConfiguration
struct BrickletSilentStepperV2MiscConfiguration
    disable_short_to_ground_protection::Bool
    synchronize_phase_frequency::Integer
end

export BrickletSilentStepperV2DriverStatus
struct BrickletSilentStepperV2DriverStatus
    open_load::Integer
    short_to_ground::Integer
    over_temperature::Integer
    motor_stalled::Bool
    actual_motor_current::Integer
    full_step_active::Bool
    stallguard_result::Integer
    stealth_voltage_amplitude::Integer
end

export BrickletSilentStepperV2AllData
struct BrickletSilentStepperV2AllData
    current_velocity::Integer
    current_position::Integer
    remaining_steps::Integer
    input_voltage::Integer
    current_consumption::Integer
end

export BrickletSilentStepperV2GPIOConfiguration
struct BrickletSilentStepperV2GPIOConfiguration
    debounce::Integer
    stop_deceleration::Integer
end

export BrickletSilentStepperV2SPITFPErrorCount
struct BrickletSilentStepperV2SPITFPErrorCount
    error_count_ack_checksum::Integer
    error_count_message_checksum::Integer
    error_count_frame::Integer
    error_count_overflow::Integer
end

export BrickletSilentStepperV2Identity
struct BrickletSilentStepperV2Identity
    uid::String
    connected_uid::String
    position::Char
    hardware_version::Vector{Integer}
    firmware_version::Vector{Integer}
    device_identifier::Integer
end

export BrickletSilentStepperV2
"""
Silently drives one bipolar stepper motor with up to 46V and 1.6A per phase
"""
mutable struct BrickletSilentStepperV2 <: TinkerforgeDevice
    ipcon::IPConnection
    deviceInternal::PyObject

    """
    Creates an object with the unique device ID *uid* and adds it to
    the IP Connection *ipcon*.
    """
    function BrickletSilentStepperV2(uid::String, ipcon::IPConnection)
        package = pyimport("tinkerforge.bricklet_silent_stepper_v2")
        deviceInternal = package.BrickletSilentStepperV2(uid, ipcon.ipconInternal)

        return new(ipcon, deviceInternal)
    end
end

export set_max_velocity
"""
    $(SIGNATURES)

Sets the maximum velocity of the stepper motor.
This function does *not* start the motor, it merely sets the maximum
velocity the stepper motor is accelerated to. To get the motor running use
either :func:`Set Target Position`, :func:`Set Steps`, :func:`Drive Forward` or
:func:`Drive Backward`.
"""
function set_max_velocity(device::BrickletSilentStepperV2, velocity)
    device.deviceInternal.set_max_velocity(velocity)
end

export get_max_velocity
"""
    $(SIGNATURES)

Returns the velocity as set by :func:`Set Max Velocity`.
"""
function get_max_velocity(device::BrickletSilentStepperV2)
    return device.deviceInternal.get_max_velocity()
end

export get_current_velocity
"""
    $(SIGNATURES)

Returns the *current* velocity of the stepper motor.
"""
function get_current_velocity(device::BrickletSilentStepperV2)
    return device.deviceInternal.get_current_velocity()
end

export set_speed_ramping
"""
    $(SIGNATURES)

Sets the acceleration and deacceleration of the stepper motor.
An acceleration of 1000 means, that
every second the velocity is increased by 1000 *steps/s*.

For example: If the current velocity is 0 and you want to accelerate to a
velocity of 8000 *steps/s* in 10 seconds, you should set an acceleration
of 800 *steps/s²*.

An acceleration/deacceleration of 0 means instantaneous
acceleration/deacceleration (not recommended)
"""
function set_speed_ramping(device::BrickletSilentStepperV2, acceleration, deacceleration)
    device.deviceInternal.set_speed_ramping(acceleration, deacceleration)
end

export get_speed_ramping
"""
    $(SIGNATURES)

Returns the acceleration and deacceleration as set by
:func:`Set Speed Ramping`.
"""
function get_speed_ramping(device::BrickletSilentStepperV2)
    return device.deviceInternal.get_speed_ramping()
end

export full_brake
"""
    $(SIGNATURES)

Executes an active full brake.

.. warning::
 This function is for emergency purposes,
 where an immediate brake is necessary. Depending on the current velocity and
 the strength of the motor, a full brake can be quite violent.

Call :func:`Stop` if you just want to stop the motor.
"""
function full_brake(device::BrickletSilentStepperV2)
    device.deviceInternal.full_brake()
end

export set_current_position
"""
    $(SIGNATURES)

Sets the current steps of the internal step counter. This can be used to
set the current position to 0 when some kind of starting position
is reached (e.g. when a CNC machine reaches a corner).
"""
function set_current_position(device::BrickletSilentStepperV2, position)
    device.deviceInternal.set_current_position(position)
end

export get_current_position
"""
    $(SIGNATURES)

Returns the current position of the stepper motor in steps. On startup
the position is 0. The steps are counted with all possible driving
functions (:func:`Set Target Position`, :func:`Set Steps`, :func:`Drive Forward` or
:func:`Drive Backward`). It also is possible to reset the steps to 0 or
set them to any other desired value with :func:`Set Current Position`.
"""
function get_current_position(device::BrickletSilentStepperV2)
    return device.deviceInternal.get_current_position()
end

export set_target_position
"""
    $(SIGNATURES)

Sets the target position of the stepper motor in steps. For example,
if the current position of the motor is 500 and :func:`Set Target Position` is
called with 1000, the stepper motor will drive 500 steps forward. It will
use the velocity, acceleration and deacceleration as set by
:func:`Set Max Velocity` and :func:`Set Speed Ramping`.

A call of :func:`Set Target Position` with the parameter *x* is equivalent to
a call of :func:`Set Steps` with the parameter
(*x* - :func:`Get Current Position`).
"""
function set_target_position(device::BrickletSilentStepperV2, position)
    device.deviceInternal.set_target_position(position)
end

export get_target_position
"""
    $(SIGNATURES)

Returns the last target position as set by :func:`Set Target Position`.
"""
function get_target_position(device::BrickletSilentStepperV2)
    return device.deviceInternal.get_target_position()
end

export set_steps
"""
    $(SIGNATURES)

Sets the number of steps the stepper motor should run. Positive values
will drive the motor forward and negative values backward.
The velocity, acceleration and deacceleration as set by
:func:`Set Max Velocity` and :func:`Set Speed Ramping` will be used.
"""
function set_steps(device::BrickletSilentStepperV2, steps)
    device.deviceInternal.set_steps(steps)
end

export get_steps
"""
    $(SIGNATURES)

Returns the last steps as set by :func:`Set Steps`.
"""
function get_steps(device::BrickletSilentStepperV2)
    return device.deviceInternal.get_steps()
end

export get_remaining_steps
"""
    $(SIGNATURES)

Returns the remaining steps of the last call of :func:`Set Steps`.
For example, if :func:`Set Steps` is called with 2000 and
:func:`Get Remaining Steps` is called after the motor has run for 500 steps,
it will return 1500.
"""
function get_remaining_steps(device::BrickletSilentStepperV2)
    return device.deviceInternal.get_remaining_steps()
end

export set_step_configuration
"""
    $(SIGNATURES)

Sets the step resolution from full-step up to 1/256-step.

If interpolation is turned on, the Silent Stepper Bricklet 2.0 will always interpolate
your step inputs as 1/256-step. If you use full-step mode with interpolation, each
step will generate 256 1/256 steps.

For maximum torque use full-step without interpolation. For maximum resolution use
1/256-step. Turn interpolation on to make the Stepper driving less noisy.

If you often change the speed with high acceleration you should turn the
interpolation off.
"""
function set_step_configuration(device::BrickletSilentStepperV2, step_resolution, interpolation)
    device.deviceInternal.set_step_configuration(step_resolution, interpolation)
end

export get_step_configuration
"""
    $(SIGNATURES)

Returns the step mode as set by :func:`Set Step Configuration`.
"""
function get_step_configuration(device::BrickletSilentStepperV2)
    return device.deviceInternal.get_step_configuration()
end

export drive_forward
"""
    $(SIGNATURES)

Drives the stepper motor forward until :func:`Drive Backward` or
:func:`Stop` is called. The velocity, acceleration and deacceleration as
set by :func:`Set Max Velocity` and :func:`Set Speed Ramping` will be used.
"""
function drive_forward(device::BrickletSilentStepperV2)
    device.deviceInternal.drive_forward()
end

export drive_backward
"""
    $(SIGNATURES)

Drives the stepper motor backward until :func:`Drive Forward` or
:func:`Stop` is triggered. The velocity, acceleration and deacceleration as
set by :func:`Set Max Velocity` and :func:`Set Speed Ramping` will be used.
"""
function drive_backward(device::BrickletSilentStepperV2)
    device.deviceInternal.drive_backward()
end

export stop
"""
    $(SIGNATURES)

Stops the stepper motor with the deacceleration as set by
:func:`Set Speed Ramping`.
"""
function stop(device::BrickletSilentStepperV2)
    device.deviceInternal.stop()
end

export get_input_voltage
"""
    $(SIGNATURES)

Returns the external input voltage. The external input voltage is
given via the black power input connector on the Silent Stepper Bricklet 2.0.

If there is an external input voltage and a stack input voltage, the motor
will be driven by the external input voltage. If there is only a stack
voltage present, the motor will be driven by this voltage.

.. warning::
 This means, if you have a high stack voltage and a low external voltage,
 the motor will be driven with the low external voltage. If you then remove
 the external connection, it will immediately be driven by the high
 stack voltage
"""
function get_input_voltage(device::BrickletSilentStepperV2)
    return device.deviceInternal.get_input_voltage()
end

export set_motor_current
"""
    $(SIGNATURES)

Sets the current with which the motor will be driven.

.. warning::
 Do not set this value above the specifications of your stepper motor.
 Otherwise it may damage your motor.
"""
function set_motor_current(device::BrickletSilentStepperV2, current)
    device.deviceInternal.set_motor_current(current)
end

export get_motor_current
"""
    $(SIGNATURES)

Returns the current as set by :func:`Set Motor Current`.
"""
function get_motor_current(device::BrickletSilentStepperV2)
    return device.deviceInternal.get_motor_current()
end

export set_enabled
"""
    $(SIGNATURES)

Enables/Disables the driver chip. The driver parameters can be configured (maximum velocity,
acceleration, etc) before it is enabled.

.. warning::
 Disabling the driver chip while the motor is still turning can damage the
 driver chip. The motor should be stopped calling :func:`Stop` function
 before disabling the motor power. The :func:`Stop` function will **not**
 wait until the motor is actually stopped. You have to explicitly wait for the
 appropriate time after calling the :func:`Stop` function before calling
 the :func:`Set Enabled` with false function.
"""
function set_enabled(device::BrickletSilentStepperV2, enabled)
    device.deviceInternal.set_enabled(enabled)
end

export get_enabled
"""
    $(SIGNATURES)

Returns *true* if the stepper driver is enabled, *false* otherwise.
"""
function get_enabled(device::BrickletSilentStepperV2)
    return device.deviceInternal.get_enabled()
end

export set_basic_configuration
"""
    $(SIGNATURES)

Sets the basic configuration parameters for the different modes (Stealth, Coolstep, Classic).

* Standstill Current: This value can be used to lower the current during stand still. This might
  be reasonable to reduce the heating of the motor and the Bricklet 2.0. When the motor is in standstill
  the configured motor phase current will be driven until the configured
  Power Down Time is elapsed. After that the phase current will be reduced to the standstill
  current. The elapsed time for this reduction can be configured with the Standstill Delay Time.
  The maximum allowed value is the configured maximum motor current
  (see :func:`Set Motor Current`).

* Motor Run Current: The value sets the motor current when the motor is running.
  Use a value of at least one half of the global maximum motor current for a good
  microstep performance. The maximum allowed value is the current
  motor current. The API maps the entered value to 1/32 ... 32/32 of the maximum
  motor current. This value should be used to change the motor current during motor movement,
  whereas the global maximum motor current should not be changed while the motor is moving
  (see :func:`Set Motor Current`).

* Standstill Delay Time: Controls the duration for motor power down after a motion
  as soon as standstill is detected and the Power Down Time is expired. A high Standstill Delay
  Time results in a smooth transition that avoids motor jerk during power down.

* Power Down Time: Sets the delay time after a stand still.

* Stealth Threshold: Sets the upper threshold for Stealth mode.
  If the velocity of the motor goes above this value, Stealth mode is turned
  off. Otherwise it is turned on. In Stealth mode the torque declines with high speed.

* Coolstep Threshold: Sets the lower threshold for Coolstep mode.
  The Coolstep Threshold needs to be above the Stealth Threshold.

* Classic Threshold: Sets the lower threshold for classic mode.
  In classic mode the stepper becomes more noisy, but the torque is maximized.

* High Velocity Chopper Mode: If High Velocity Chopper Mode is enabled, the stepper control
  is optimized to run the stepper motors at high velocities.

If you want to use all three thresholds make sure that
Stealth Threshold < Coolstep Threshold < Classic Threshold.
"""
function set_basic_configuration(device::BrickletSilentStepperV2, standstill_current, motor_run_current, standstill_delay_time, power_down_time, stealth_threshold, coolstep_threshold, classic_threshold, high_velocity_chopper_mode)
    device.deviceInternal.set_basic_configuration(standstill_current, motor_run_current, standstill_delay_time, power_down_time, stealth_threshold, coolstep_threshold, classic_threshold, high_velocity_chopper_mode)
end

export get_basic_configuration
"""
    $(SIGNATURES)

Returns the configuration as set by :func:`Set Basic Configuration`.
"""
function get_basic_configuration(device::BrickletSilentStepperV2)
    return device.deviceInternal.get_basic_configuration()
end

export set_spreadcycle_configuration
"""
    $(SIGNATURES)

Note: If you don't know what any of this means you can very likely keep all of
the values as default!

Sets the Spreadcycle configuration parameters. Spreadcycle is a chopper algorithm which actively
controls the motor current flow. More information can be found in the TMC2130 datasheet on page
47 (7 spreadCycle and Classic Chopper).

* Slow Decay Duration: Controls duration of off time setting of slow decay phase.
  0 = driver disabled, all bridges off. Use 1 only with Comparator Blank time >= 2.

* Enable Random Slow Decay: Set to false to fix chopper off time as set by Slow Decay Duration.
  If you set it to true, Decay Duration is randomly modulated.

* Fast Decay Duration: Sets the fast decay duration. This parameters is
  only used if the Chopper Mode is set to Fast Decay.

* Hysteresis Start Value: Sets the hysteresis start value. This parameter is
  only used if the Chopper Mode is set to Spread Cycle.

* Hysteresis End Value: Sets the hysteresis end value. This parameter is
  only used if the Chopper Mode is set to Spread Cycle.

* Sine Wave Offset: Sets the sine wave offset. This parameters is
  only used if the Chopper Mode is set to Fast Decay. 1/512 of the value becomes added to the absolute
  value of the sine wave.

* Chopper Mode: 0 = Spread Cycle, 1 = Fast Decay.

* Comparator Blank Time: Sets the blank time of the comparator. Available values are

  * 0 = 16 clocks,
  * 1 = 24 clocks,
  * 2 = 36 clocks and
  * 3 = 54 clocks.

  A value of 1 or 2 is recommended for most applications.

* Fast Decay Without Comparator: If set to true the current comparator usage for termination of the
  fast decay cycle is disabled.
"""
function set_spreadcycle_configuration(device::BrickletSilentStepperV2, slow_decay_duration, enable_random_slow_decay, fast_decay_duration, hysteresis_start_value, hysteresis_end_value, sine_wave_offset, chopper_mode, comparator_blank_time, fast_decay_without_comparator)
    device.deviceInternal.set_spreadcycle_configuration(slow_decay_duration, enable_random_slow_decay, fast_decay_duration, hysteresis_start_value, hysteresis_end_value, sine_wave_offset, chopper_mode, comparator_blank_time, fast_decay_without_comparator)
end

export get_spreadcycle_configuration
"""
    $(SIGNATURES)

Returns the configuration as set by :func:`Set Basic Configuration`.
"""
function get_spreadcycle_configuration(device::BrickletSilentStepperV2)
    return device.deviceInternal.get_spreadcycle_configuration()
end

export set_stealth_configuration
"""
    $(SIGNATURES)

Note: If you don't know what any of this means you can very likely keep all of
the values as default!

Sets the configuration relevant for Stealth mode.

* Enable Stealth: If set to true the stealth mode is enabled, if set to false the
  stealth mode is disabled, even if the speed is below the threshold set in :func:`Set Basic Configuration`.

* Amplitude: If autoscale is disabled, the PWM amplitude is scaled by this value. If autoscale is enabled,
  this value defines the maximum PWM amplitude change per half wave.

* Gradient: If autoscale is disabled, the PWM gradient is scaled by this value. If autoscale is enabled,
  this value defines the maximum PWM gradient. With autoscale a value above 64 is recommended,
  otherwise the regulation might not be able to measure the current.

* Enable Autoscale: If set to true, automatic current control is used. Otherwise the user defined
  amplitude and gradient are used.

* Force Symmetric: If true, A symmetric PWM cycle is enforced. Otherwise the PWM value may change within each
  PWM cycle.

* Freewheel Mode: The freewheel mode defines the behavior in stand still if the Standstill Current
  (see :func:`Set Basic Configuration`) is set to 0.
"""
function set_stealth_configuration(device::BrickletSilentStepperV2, enable_stealth, amplitude, gradient, enable_autoscale, force_symmetric, freewheel_mode)
    device.deviceInternal.set_stealth_configuration(enable_stealth, amplitude, gradient, enable_autoscale, force_symmetric, freewheel_mode)
end

export get_stealth_configuration
"""
    $(SIGNATURES)

Returns the configuration as set by :func:`Set Stealth Configuration`.
"""
function get_stealth_configuration(device::BrickletSilentStepperV2)
    return device.deviceInternal.get_stealth_configuration()
end

export set_coolstep_configuration
"""
    $(SIGNATURES)

Note: If you don't know what any of this means you can very likely keep all of
the values as default!

Sets the configuration relevant for Coolstep.

* Minimum Stallguard Value: If the Stallguard result falls below this value*32, the motor current
  is increased to reduce motor load angle. A value of 0 turns Coolstep off.

* Maximum Stallguard Value: If the Stallguard result goes above
  (Min Stallguard Value + Max Stallguard Value + 1) * 32, the motor current is decreased to save
  energy.

* Current Up Step Width: Sets the up step increment per Stallguard value. The value range is 0-3,
  corresponding to the increments 1, 2, 4 and 8.

* Current Down Step Width: Sets the down step decrement per Stallguard value. The value range is 0-3,
  corresponding to the decrements 1, 2, 8 and 16.

* Minimum Current: Sets the minimum current for Coolstep current control. You can choose between
  half and quarter of the run current.

* Stallguard Threshold Value: Sets the level for stall output (see :func:`Get Driver Status`).
  A lower value gives a higher sensitivity. You have to find a suitable value for your
  motor by trial and error, 0 works for most motors.

* Stallguard Mode: Set to 0 for standard resolution or 1 for filtered mode. In filtered mode the Stallguard
  signal will be updated every four full-steps.
"""
function set_coolstep_configuration(device::BrickletSilentStepperV2, minimum_stallguard_value, maximum_stallguard_value, current_up_step_width, current_down_step_width, minimum_current, stallguard_threshold_value, stallguard_mode)
    device.deviceInternal.set_coolstep_configuration(minimum_stallguard_value, maximum_stallguard_value, current_up_step_width, current_down_step_width, minimum_current, stallguard_threshold_value, stallguard_mode)
end

export get_coolstep_configuration
"""
    $(SIGNATURES)

Returns the configuration as set by :func:`Set Coolstep Configuration`.
"""
function get_coolstep_configuration(device::BrickletSilentStepperV2)
    return device.deviceInternal.get_coolstep_configuration()
end

export set_misc_configuration
"""
    $(SIGNATURES)

Note: If you don't know what any of this means you can very likely keep all of
the values as default!

Sets miscellaneous configuration parameters.

* Disable Short To Ground Protection: Set to false to enable short to ground protection, otherwise
  it is disabled.

* Synchronize Phase Frequency: With this parameter you can synchronize the chopper for both phases
  of a two phase motor to avoid the occurrence of a beat. The value range is 0-15. If set to 0,
  the synchronization is turned off. Otherwise the synchronization is done through the formula
  f_sync = f_clk/(value*64). In Classic Mode the synchronization is automatically switched off.
  f_clk is 12.8MHz.
"""
function set_misc_configuration(device::BrickletSilentStepperV2, disable_short_to_ground_protection, synchronize_phase_frequency)
    device.deviceInternal.set_misc_configuration(disable_short_to_ground_protection, synchronize_phase_frequency)
end

export get_misc_configuration
"""
    $(SIGNATURES)

Returns the configuration as set by :func:`Set Misc Configuration`.
"""
function get_misc_configuration(device::BrickletSilentStepperV2)
    return device.deviceInternal.get_misc_configuration()
end

export set_error_led_config
"""
    $(SIGNATURES)

Configures the error LED to be either turned off, turned on, blink in
heartbeat mode or show an error.

If the LED is configured to show errors it has three different states:

* Off: No error present.
* 250ms interval blink: Overtemperature warning.
* 1s interval blink: Input voltage too small.
* full red: motor disabled because of short to ground in phase a or b or because of overtemperature.
"""
function set_error_led_config(device::BrickletSilentStepperV2, config)
    device.deviceInternal.set_error_led_config(config)
end

export get_error_led_config
"""
    $(SIGNATURES)

Returns the LED configuration as set by :func:`Set Error LED Config`
"""
function get_error_led_config(device::BrickletSilentStepperV2)
    return device.deviceInternal.get_error_led_config()
end

export get_driver_status
"""
    $(SIGNATURES)

Returns the current driver status.

* Open Load: Indicates if an open load is present on phase A, B or both. This could mean that there is a problem
  with the wiring of the motor. False detection can occur in fast motion as well as during stand still.

* Short To Ground: Indicates if a short to ground is present on phase A, B or both. If this is detected the driver
  automatically becomes disabled and stays disabled until it is enabled again manually.

* Over Temperature: The over temperature indicator switches to "Warning" if the driver IC warms up. The warning flag
  is expected during long duration stepper uses. If the temperature limit is reached the indicator switches
  to "Limit". In this case the driver becomes disabled until it cools down again.

* Motor Stalled: Is true if a motor stall was detected.

* Actual Motor Current: Indicates the actual current control scaling as used in Coolstep mode.
  It represents a multiplier of 1/32 to 32/32 of the
  ``Motor Run Current`` as set by :func:`Set Basic Configuration`. Example: If a ``Motor Run Current``
  of 1000mA was set and the returned value is 15, the ``Actual Motor Current`` is 16/32*1000mA = 500mA.

* Stallguard Result: Indicates the load of the motor. A lower value signals a higher load. Per trial and error
  you can find out which value corresponds to a suitable torque for the velocity used in your application.
  After that you can use this threshold value to find out if a motor stall becomes probable and react on it (e.g.
  decrease velocity).
  During stand still this value can not be used for stall detection, it shows the chopper on-time for motor coil A.

* Stealth Voltage Amplitude: Shows the actual PWM scaling. In Stealth mode it can be used to detect motor load and
  stall if autoscale is enabled (see :func:`Set Stealth Configuration`).
"""
function get_driver_status(device::BrickletSilentStepperV2)
    return device.deviceInternal.get_driver_status()
end

export set_minimum_voltage
"""
    $(SIGNATURES)

Sets the minimum voltage, below which the :cb:`Under Voltage` callback
is triggered. The minimum possible value that works with the Silent Stepper
Bricklet 2.0 is 8V.
You can use this function to detect the discharge of a battery that is used
to drive the stepper motor. If you have a fixed power supply, you likely do
not need this functionality.
"""
function set_minimum_voltage(device::BrickletSilentStepperV2, voltage)
    device.deviceInternal.set_minimum_voltage(voltage)
end

export get_minimum_voltage
"""
    $(SIGNATURES)

Returns the minimum voltage as set by :func:`Set Minimum Voltage`.
"""
function get_minimum_voltage(device::BrickletSilentStepperV2)
    return device.deviceInternal.get_minimum_voltage()
end

export set_time_base
"""
    $(SIGNATURES)

Sets the time base of the velocity and the acceleration of the Silent Stepper
Bricklet 2.0.

For example, if you want to make one step every 1.5 seconds, you can set
the time base to 15 and the velocity to 10. Now the velocity is
10steps/15s = 1steps/1.5s.
"""
function set_time_base(device::BrickletSilentStepperV2, time_base)
    device.deviceInternal.set_time_base(time_base)
end

export get_time_base
"""
    $(SIGNATURES)

Returns the time base as set by :func:`Set Time Base`.
"""
function get_time_base(device::BrickletSilentStepperV2)
    return device.deviceInternal.get_time_base()
end

export get_all_data
"""
    $(SIGNATURES)

Returns the following parameters: The current velocity,
the current position, the remaining steps, the stack voltage, the external
voltage and the current consumption of the stepper motor.

The current consumption is calculated by multiplying the ``Actual Motor Current``
value (see :func:`Set Basic Configuration`) with the ``Motor Run Current``
(see :func:`Get Driver Status`). This is an internal calculation of the
driver, not an independent external measurement.

The current consumption calculation was broken up to firmware 2.0.1, it is fixed
since firmware 2.0.2.

There is also a callback for this function, see :cb:`All Data` callback.
"""
function get_all_data(device::BrickletSilentStepperV2)
    return device.deviceInternal.get_all_data()
end

export set_all_callback_configuration
"""
    $(SIGNATURES)

Sets the period with which the :cb:`All Data` callback is triggered
periodically. A value of 0 turns the callback off.
"""
function set_all_callback_configuration(device::BrickletSilentStepperV2, period)
    device.deviceInternal.set_all_callback_configuration(period)
end

export get_all_data_callback_configuraton
"""
    $(SIGNATURES)

Returns the period as set by :func:`Set All Callback Configuration`.
"""
function get_all_data_callback_configuraton(device::BrickletSilentStepperV2)
    return device.deviceInternal.get_all_data_callback_configuraton()
end

export set_gpio_configuration
"""
    $(SIGNATURES)

Sets the GPIO configuration for the given channel.
You can configure a debounce and the deceleration that is used if the action is
configured as ``normal stop``. See :func:`Set GPIO Action`.
"""
function set_gpio_configuration(device::BrickletSilentStepperV2, channel, debounce, stop_deceleration)
    device.deviceInternal.set_gpio_configuration(channel, debounce, stop_deceleration)
end

export get_gpio_configuration
"""
    $(SIGNATURES)

Returns the GPIO configuration for a channel as set by :func:`Set GPIO Configuration`.
"""
function get_gpio_configuration(device::BrickletSilentStepperV2, channel)
    return device.deviceInternal.get_gpio_configuration(channel)
end

export set_gpio_action
"""
    $(SIGNATURES)

Sets the GPIO action for the given channel.

The action can be a normal stop, a full brake or a callback. Each for a rising
edge or falling edge. The actions are a bitmask they can be used at the same time.
You can for example trigger a full brake and a callback at the same time or for
rising and falling edge.

The deceleration speed for the normal stop can be configured with
:func:`Set GPIO Configuration`.
"""
function set_gpio_action(device::BrickletSilentStepperV2, channel, action)
    device.deviceInternal.set_gpio_action(channel, action)
end

export get_gpio_action
"""
    $(SIGNATURES)

Returns the GPIO action for a channel as set by :func:`Set GPIO Action`.
"""
function get_gpio_action(device::BrickletSilentStepperV2, channel)
    return device.deviceInternal.get_gpio_action(channel)
end

export get_gpio_state
"""
    $(SIGNATURES)

Returns the GPIO state for both channels. True if the state is ``high`` and
false if the state is ``low``.
"""
function get_gpio_state(device::BrickletSilentStepperV2)
    return device.deviceInternal.get_gpio_state()
end

export get_spitfp_error_count
"""
    $(SIGNATURES)

Returns the error count for the communication between Brick and Bricklet.

The errors are divided into

* ACK checksum errors,
* message checksum errors,
* framing errors and
* overflow errors.

The errors counts are for errors that occur on the Bricklet side. All
Bricks have a similar function that returns the errors on the Brick side.
"""
function get_spitfp_error_count(device::BrickletSilentStepperV2)
    return device.deviceInternal.get_spitfp_error_count()
end

export set_bootloader_mode
"""
    $(SIGNATURES)

Sets the bootloader mode and returns the status after the requested
mode change was instigated.

You can change from bootloader mode to firmware mode and vice versa. A change
from bootloader mode to firmware mode will only take place if the entry function,
device identifier and CRC are present and correct.

This function is used by Brick Viewer during flashing. It should not be
necessary to call it in a normal user program.
"""
function set_bootloader_mode(device::BrickletSilentStepperV2, mode)
    return device.deviceInternal.set_bootloader_mode(mode)
end

export get_bootloader_mode
"""
    $(SIGNATURES)

Returns the current bootloader mode, see :func:`Set Bootloader Mode`.
"""
function get_bootloader_mode(device::BrickletSilentStepperV2)
    return device.deviceInternal.get_bootloader_mode()
end

export set_write_firmware_pointer
"""
    $(SIGNATURES)

Sets the firmware pointer for :func:`Write Firmware`. The pointer has
to be increased by chunks of size 64. The data is written to flash
every 4 chunks (which equals to one page of size 256).

This function is used by Brick Viewer during flashing. It should not be
necessary to call it in a normal user program.
"""
function set_write_firmware_pointer(device::BrickletSilentStepperV2, pointer)
    device.deviceInternal.set_write_firmware_pointer(pointer)
end

export write_firmware
"""
    $(SIGNATURES)

Writes 64 Bytes of firmware at the position as written by
:func:`Set Write Firmware Pointer` before. The firmware is written
to flash every 4 chunks.

You can only write firmware in bootloader mode.

This function is used by Brick Viewer during flashing. It should not be
necessary to call it in a normal user program.
"""
function write_firmware(device::BrickletSilentStepperV2, data)
    return device.deviceInternal.write_firmware(data)
end

export set_status_led_config
"""
    $(SIGNATURES)

Sets the status LED configuration. By default the LED shows
communication traffic between Brick and Bricklet, it flickers once
for every 10 received data packets.

You can also turn the LED permanently on/off or show a heartbeat.

If the Bricklet is in bootloader mode, the LED is will show heartbeat by default.
"""
function set_status_led_config(device::BrickletSilentStepperV2, config)
    device.deviceInternal.set_status_led_config(config)
end

export get_status_led_config
"""
    $(SIGNATURES)

Returns the configuration as set by :func:`Set Status LED Config`
"""
function get_status_led_config(device::BrickletSilentStepperV2)
    return device.deviceInternal.get_status_led_config()
end

export get_chip_temperature
"""
    $(SIGNATURES)

Returns the temperature as measured inside the microcontroller. The
value returned is not the ambient temperature!

The temperature is only proportional to the real temperature and it has bad
accuracy. Practically it is only useful as an indicator for
temperature changes.
"""
function get_chip_temperature(device::BrickletSilentStepperV2)
    return device.deviceInternal.get_chip_temperature()
end

export reset
"""
    $(SIGNATURES)

Calling this function will reset the Bricklet. All configurations
will be lost.

After a reset you have to create new device objects,
calling functions on the existing ones will result in
undefined behavior!
"""
function reset(device::BrickletSilentStepperV2)
    device.deviceInternal.reset()
end

export write_uid
"""
    $(SIGNATURES)

Writes a new UID into flash. If you want to set a new UID
you have to decode the Base58 encoded UID string into an
integer first.

We recommend that you use Brick Viewer to change the UID.
"""
function write_uid(device::BrickletSilentStepperV2, uid)
    device.deviceInternal.write_uid(uid)
end

export read_uid
"""
    $(SIGNATURES)

Returns the current UID as an integer. Encode as
Base58 to get the usual string version.
"""
function read_uid(device::BrickletSilentStepperV2)
    return device.deviceInternal.read_uid()
end

export get_identity
"""
    $(SIGNATURES)

Returns the UID, the UID where the Bricklet is connected to,
the position, the hardware and firmware version as well as the
device identifier.

The position can be 'a', 'b', 'c', 'd', 'e', 'f', 'g' or 'h' (Bricklet Port).
A Bricklet connected to an :ref:`Isolator Bricklet <isolator_bricklet>` is always at
position 'z'.

The device identifier numbers can be found :ref:`here <device_identifier>`.
|device_identifier_constant|
"""
function get_identity(device::BrickletSilentStepperV2)
    return device.deviceInternal.get_identity()
end

export register_callback
"""
Registers the given *function* with the given *callback_id*.
"""
function register_callback(device::BrickletSilentStepperV2, callback_id, function_)
    if isnothing(function_)
        device.registered_callbacks.pop(callback_id, None)
    else
        device.registered_callbacks[callback_id] = function_
    end
end
