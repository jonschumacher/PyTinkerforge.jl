


export BrickStepperSpeedRamping
struct BrickStepperSpeedRamping
    acceleration::Integer
    deacceleration::Integer
end

export BrickStepperAllData
struct BrickStepperAllData
    current_velocity::Integer
    current_position::Integer
    remaining_steps::Integer
    stack_voltage::Integer
    external_voltage::Integer
    current_consumption::Integer
end

export BrickStepperSPITFPBaudrateConfig
struct BrickStepperSPITFPBaudrateConfig
    enable_dynamic_baudrate::Bool
    minimum_dynamic_baudrate::Integer
end

export BrickStepperSPITFPErrorCount
struct BrickStepperSPITFPErrorCount
    error_count_ack_checksum::Integer
    error_count_message_checksum::Integer
    error_count_frame::Integer
    error_count_overflow::Integer
end

export BrickStepperProtocol1BrickletName
struct BrickStepperProtocol1BrickletName
    protocol_version::Integer
    firmware_version::Vector{Integer}
    name::String
end

export BrickStepperIdentity
struct BrickStepperIdentity
    uid::String
    connected_uid::String
    position::Char
    hardware_version::Vector{Integer}
    firmware_version::Vector{Integer}
    device_identifier::Integer
end

export BrickStepper
"""
Drives one bipolar stepper motor with up to 38V and 2.5A per phase
"""
mutable struct BrickStepper <: TinkerforgeDevice
    ipcon::IPConnection
    deviceInternal::PyObject

    """
    Creates an object with the unique device ID *uid* and adds it to
    the IP Connection *ipcon*.
    """
    function BrickStepper(uid::String, ipcon::IPConnection)
        package = pyimport("tinkerforge.brick_stepper")
        deviceInternal = package.BrickStepper(uid, ipcon.ipconInternal)

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
function set_max_velocity(device::BrickStepper, velocity)
    device.deviceInternal.set_max_velocity(velocity)
end

export get_max_velocity
"""
    $(SIGNATURES)

Returns the velocity as set by :func:`Set Max Velocity`.
"""
function get_max_velocity(device::BrickStepper)
    return device.deviceInternal.get_max_velocity()
end

export get_current_velocity
"""
    $(SIGNATURES)

Returns the *current* velocity of the stepper motor.
"""
function get_current_velocity(device::BrickStepper)
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
function set_speed_ramping(device::BrickStepper, acceleration, deacceleration)
    device.deviceInternal.set_speed_ramping(acceleration, deacceleration)
end

export get_speed_ramping
"""
    $(SIGNATURES)

Returns the acceleration and deacceleration as set by
:func:`Set Speed Ramping`.
"""
function get_speed_ramping(device::BrickStepper)
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
function full_brake(device::BrickStepper)
    device.deviceInternal.full_brake()
end

export set_current_position
"""
    $(SIGNATURES)

Sets the current steps of the internal step counter. This can be used to
set the current position to 0 when some kind of starting position
is reached (e.g. when a CNC machine reaches a corner).
"""
function set_current_position(device::BrickStepper, position)
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
function get_current_position(device::BrickStepper)
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
function set_target_position(device::BrickStepper, position)
    device.deviceInternal.set_target_position(position)
end

export get_target_position
"""
    $(SIGNATURES)

Returns the last target position as set by :func:`Set Target Position`.
"""
function get_target_position(device::BrickStepper)
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
function set_steps(device::BrickStepper, steps)
    device.deviceInternal.set_steps(steps)
end

export get_steps
"""
    $(SIGNATURES)

Returns the last steps as set by :func:`Set Steps`.
"""
function get_steps(device::BrickStepper)
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
function get_remaining_steps(device::BrickStepper)
    return device.deviceInternal.get_remaining_steps()
end

export set_step_mode
"""
    $(SIGNATURES)

Sets the step mode of the stepper motor. Possible values are:

* Full Step = 1
* Half Step = 2
* Quarter Step = 4
* Eighth Step = 8

A higher value will increase the resolution and
decrease the torque of the stepper motor.
"""
function set_step_mode(device::BrickStepper, mode)
    device.deviceInternal.set_step_mode(mode)
end

export get_step_mode
"""
    $(SIGNATURES)

Returns the step mode as set by :func:`Set Step Mode`.
"""
function get_step_mode(device::BrickStepper)
    return device.deviceInternal.get_step_mode()
end

export drive_forward
"""
    $(SIGNATURES)

Drives the stepper motor forward until :func:`Drive Backward` or
:func:`Stop` is called. The velocity, acceleration and deacceleration as
set by :func:`Set Max Velocity` and :func:`Set Speed Ramping` will be used.
"""
function drive_forward(device::BrickStepper)
    device.deviceInternal.drive_forward()
end

export drive_backward
"""
    $(SIGNATURES)

Drives the stepper motor backward until :func:`Drive Forward` or
:func:`Stop` is triggered. The velocity, acceleration and deacceleration as
set by :func:`Set Max Velocity` and :func:`Set Speed Ramping` will be used.
"""
function drive_backward(device::BrickStepper)
    device.deviceInternal.drive_backward()
end

export stop
"""
    $(SIGNATURES)

Stops the stepper motor with the deacceleration as set by
:func:`Set Speed Ramping`.
"""
function stop(device::BrickStepper)
    device.deviceInternal.stop()
end

export get_stack_input_voltage
"""
    $(SIGNATURES)

Returns the stack input voltage. The stack input voltage is the
voltage that is supplied via the stack, i.e. it is given by a
Step-Down or Step-Up Power Supply.
"""
function get_stack_input_voltage(device::BrickStepper)
    return device.deviceInternal.get_stack_input_voltage()
end

export get_external_input_voltage
"""
    $(SIGNATURES)

Returns the external input voltage. The external input voltage is
given via the black power input connector on the Stepper Brick.

If there is an external input voltage and a stack input voltage, the motor
will be driven by the external input voltage. If there is only a stack
voltage present, the motor will be driven by this voltage.

.. warning::
 This means, if you have a high stack voltage and a low external voltage,
 the motor will be driven with the low external voltage. If you then remove
 the external connection, it will immediately be driven by the high
 stack voltage
"""
function get_external_input_voltage(device::BrickStepper)
    return device.deviceInternal.get_external_input_voltage()
end

export get_current_consumption
"""
    $(SIGNATURES)

Returns the current consumption of the motor.
"""
function get_current_consumption(device::BrickStepper)
    return device.deviceInternal.get_current_consumption()
end

export set_motor_current
"""
    $(SIGNATURES)

Sets the current with which the motor will be driven.

.. warning::
 Do not set this value above the specifications of your stepper motor.
 Otherwise it may damage your motor.
"""
function set_motor_current(device::BrickStepper, current)
    device.deviceInternal.set_motor_current(current)
end

export get_motor_current
"""
    $(SIGNATURES)

Returns the current as set by :func:`Set Motor Current`.
"""
function get_motor_current(device::BrickStepper)
    return device.deviceInternal.get_motor_current()
end

export enable
"""
    $(SIGNATURES)

Enables the driver chip. The driver parameters can be configured (maximum velocity,
acceleration, etc) before it is enabled.
"""
function enable(device::BrickStepper)
    device.deviceInternal.enable()
end

export disable
"""
    $(SIGNATURES)

Disables the driver chip. The configurations are kept (maximum velocity,
acceleration, etc) but the motor is not driven until it is enabled again.

.. warning::
 Disabling the driver chip while the motor is still turning can damage the
 driver chip. The motor should be stopped calling :func:`Stop` function
 before disabling the motor power. The :func:`Stop` function will **not**
 wait until the motor is actually stopped. You have to explicitly wait for the
 appropriate time after calling the :func:`Stop` function before calling
 the :func:`Disable` function.
"""
function disable(device::BrickStepper)
    device.deviceInternal.disable()
end

export is_enabled
"""
    $(SIGNATURES)

Returns *true* if the driver chip is enabled, *false* otherwise.
"""
function is_enabled(device::BrickStepper)
    return device.deviceInternal.is_enabled()
end

export set_decay
"""
    $(SIGNATURES)

Sets the decay mode of the stepper motor.
A value of 0 sets the fast decay mode, a value of
65535 sets the slow decay mode and a value in between sets the mixed
decay mode.

Changing the decay mode is only possible if synchronous rectification
is enabled (see :func:`Set Sync Rect`).

For a good explanation of the different decay modes see
`this <https://ebldc.com/?p=86/>`__ blog post by Avayan.

A good decay mode is unfortunately different for every motor. The best
way to work out a good decay mode for your stepper motor, if you can't
measure the current with an oscilloscope, is to listen to the sound of
the motor. If the value is too low, you often hear a high pitched
sound and if it is too high you can often hear a humming sound.

Generally, fast decay mode (small value) will be noisier but also
allow higher motor speeds.

.. note::
 There is unfortunately no formula to calculate a perfect decay
 mode for a given stepper motor. If you have problems with loud noises
 or the maximum motor speed is too slow, you should try to tinker with
 the decay value
"""
function set_decay(device::BrickStepper, decay)
    device.deviceInternal.set_decay(decay)
end

export get_decay
"""
    $(SIGNATURES)

Returns the decay mode as set by :func:`Set Decay`.
"""
function get_decay(device::BrickStepper)
    return device.deviceInternal.get_decay()
end

export set_minimum_voltage
"""
    $(SIGNATURES)

Sets the minimum voltage, below which the :cb:`Under Voltage` callback
is triggered. The minimum possible value that works with the Stepper Brick is 8V.
You can use this function to detect the discharge of a battery that is used
to drive the stepper motor. If you have a fixed power supply, you likely do
not need this functionality.
"""
function set_minimum_voltage(device::BrickStepper, voltage)
    device.deviceInternal.set_minimum_voltage(voltage)
end

export get_minimum_voltage
"""
    $(SIGNATURES)

Returns the minimum voltage as set by :func:`Set Minimum Voltage`.
"""
function get_minimum_voltage(device::BrickStepper)
    return device.deviceInternal.get_minimum_voltage()
end

export set_sync_rect
"""
    $(SIGNATURES)

Turns synchronous rectification on or off (*true* or *false*).

With synchronous rectification on, the decay can be changed
(see :func:`Set Decay`). Without synchronous rectification fast
decay is used.

For an explanation of synchronous rectification see
`here <https://en.wikipedia.org/wiki/Active_rectification>`__.

.. warning::
 If you want to use high speeds (> 10000 steps/s) for a large
 stepper motor with a large inductivity we strongly
 suggest that you disable synchronous rectification. Otherwise the
 Brick may not be able to cope with the load and overheat.
"""
function set_sync_rect(device::BrickStepper, sync_rect)
    device.deviceInternal.set_sync_rect(sync_rect)
end

export is_sync_rect
"""
    $(SIGNATURES)

Returns *true* if synchronous rectification is enabled, *false* otherwise.
"""
function is_sync_rect(device::BrickStepper)
    return device.deviceInternal.is_sync_rect()
end

export set_time_base
"""
    $(SIGNATURES)

Sets the time base of the velocity and the acceleration of the stepper brick.

For example, if you want to make one step every 1.5 seconds, you can set
the time base to 15 and the velocity to 10. Now the velocity is
10steps/15s = 1steps/1.5s.
"""
function set_time_base(device::BrickStepper, time_base)
    device.deviceInternal.set_time_base(time_base)
end

export get_time_base
"""
    $(SIGNATURES)

Returns the time base as set by :func:`Set Time Base`.
"""
function get_time_base(device::BrickStepper)
    return device.deviceInternal.get_time_base()
end

export get_all_data
"""
    $(SIGNATURES)

Returns the following parameters: The current velocity,
the current position, the remaining steps, the stack voltage, the external
voltage and the current consumption of the stepper motor.

There is also a callback for this function, see :cb:`All Data` callback.
"""
function get_all_data(device::BrickStepper)
    return device.deviceInternal.get_all_data()
end

export set_all_data_period
"""
    $(SIGNATURES)

Sets the period with which the :cb:`All Data` callback is triggered
periodically. A value of 0 turns the callback off.
"""
function set_all_data_period(device::BrickStepper, period)
    device.deviceInternal.set_all_data_period(period)
end

export get_all_data_period
"""
    $(SIGNATURES)

Returns the period as set by :func:`Set All Data Period`.
"""
function get_all_data_period(device::BrickStepper)
    return device.deviceInternal.get_all_data_period()
end

export set_spitfp_baudrate_config
"""
    $(SIGNATURES)

The SPITF protocol can be used with a dynamic baudrate. If the dynamic baudrate is
enabled, the Brick will try to adapt the baudrate for the communication
between Bricks and Bricklets according to the amount of data that is transferred.

The baudrate will be increased exponentially if lots of data is sent/received and
decreased linearly if little data is sent/received.

This lowers the baudrate in applications where little data is transferred (e.g.
a weather station) and increases the robustness. If there is lots of data to transfer
(e.g. Thermal Imaging Bricklet) it automatically increases the baudrate as needed.

In cases where some data has to transferred as fast as possible every few seconds
(e.g. RS485 Bricklet with a high baudrate but small payload) you may want to turn
the dynamic baudrate off to get the highest possible performance.

The maximum value of the baudrate can be set per port with the function
:func:`Set SPITFP Baudrate`. If the dynamic baudrate is disabled, the baudrate
as set by :func:`Set SPITFP Baudrate` will be used statically.

.. versionadded:: 2.3.6\$nbsp;(Firmware)
"""
function set_spitfp_baudrate_config(device::BrickStepper, enable_dynamic_baudrate, minimum_dynamic_baudrate)
    device.deviceInternal.set_spitfp_baudrate_config(enable_dynamic_baudrate, minimum_dynamic_baudrate)
end

export get_spitfp_baudrate_config
"""
    $(SIGNATURES)

Returns the baudrate config, see :func:`Set SPITFP Baudrate Config`.

.. versionadded:: 2.3.6\$nbsp;(Firmware)
"""
function get_spitfp_baudrate_config(device::BrickStepper)
    return device.deviceInternal.get_spitfp_baudrate_config()
end

export get_send_timeout_count
"""
    $(SIGNATURES)

Returns the timeout count for the different communication methods.

The methods 0-2 are available for all Bricks, 3-7 only for Master Bricks.

This function is mostly used for debugging during development, in normal operation
the counters should nearly always stay at 0.

.. versionadded:: 2.3.4\$nbsp;(Firmware)
"""
function get_send_timeout_count(device::BrickStepper, communication_method)
    return device.deviceInternal.get_send_timeout_count(communication_method)
end

export set_spitfp_baudrate
"""
    $(SIGNATURES)

Sets the baudrate for a specific Bricklet port.

If you want to increase the throughput of Bricklets you can increase
the baudrate. If you get a high error count because of high
interference (see :func:`Get SPITFP Error Count`) you can decrease the
baudrate.

If the dynamic baudrate feature is enabled, the baudrate set by this
function corresponds to the maximum baudrate (see :func:`Set SPITFP Baudrate Config`).

Regulatory testing is done with the default baudrate. If CE compatibility
or similar is necessary in your applications we recommend to not change
the baudrate.

.. versionadded:: 2.3.3\$nbsp;(Firmware)
"""
function set_spitfp_baudrate(device::BrickStepper, bricklet_port, baudrate)
    device.deviceInternal.set_spitfp_baudrate(bricklet_port, baudrate)
end

export get_spitfp_baudrate
"""
    $(SIGNATURES)

Returns the baudrate for a given Bricklet port, see :func:`Set SPITFP Baudrate`.

.. versionadded:: 2.3.3\$nbsp;(Firmware)
"""
function get_spitfp_baudrate(device::BrickStepper, bricklet_port)
    return device.deviceInternal.get_spitfp_baudrate(bricklet_port)
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

The errors counts are for errors that occur on the Brick side. All
Bricklets have a similar function that returns the errors on the Bricklet side.

.. versionadded:: 2.3.3\$nbsp;(Firmware)
"""
function get_spitfp_error_count(device::BrickStepper, bricklet_port)
    return device.deviceInternal.get_spitfp_error_count(bricklet_port)
end

export enable_status_led
"""
    $(SIGNATURES)

Enables the status LED.

The status LED is the blue LED next to the USB connector. If enabled is is
on and it flickers if data is transfered. If disabled it is always off.

The default state is enabled.

.. versionadded:: 2.3.1\$nbsp;(Firmware)
"""
function enable_status_led(device::BrickStepper)
    device.deviceInternal.enable_status_led()
end

export disable_status_led
"""
    $(SIGNATURES)

Disables the status LED.

The status LED is the blue LED next to the USB connector. If enabled is is
on and it flickers if data is transfered. If disabled it is always off.

The default state is enabled.

.. versionadded:: 2.3.1\$nbsp;(Firmware)
"""
function disable_status_led(device::BrickStepper)
    device.deviceInternal.disable_status_led()
end

export is_status_led_enabled
"""
    $(SIGNATURES)

Returns *true* if the status LED is enabled, *false* otherwise.

.. versionadded:: 2.3.1\$nbsp;(Firmware)
"""
function is_status_led_enabled(device::BrickStepper)
    return device.deviceInternal.is_status_led_enabled()
end

export get_protocol1_bricklet_name
"""
    $(SIGNATURES)

Returns the firmware and protocol version and the name of the Bricklet for a
given port.

This functions sole purpose is to allow automatic flashing of v1.x.y Bricklet
plugins.
"""
function get_protocol1_bricklet_name(device::BrickStepper, port)
    return device.deviceInternal.get_protocol1_bricklet_name(port)
end

export get_chip_temperature
"""
    $(SIGNATURES)

Returns the temperature as measured inside the microcontroller. The
value returned is not the ambient temperature!

The temperature is only proportional to the real temperature and it has an
accuracy of ±15%. Practically it is only useful as an indicator for
temperature changes.
"""
function get_chip_temperature(device::BrickStepper)
    return device.deviceInternal.get_chip_temperature()
end

export reset
"""
    $(SIGNATURES)

Calling this function will reset the Brick. Calling this function
on a Brick inside of a stack will reset the whole stack.

After a reset you have to create new device objects,
calling functions on the existing ones will result in
undefined behavior!
"""
function reset(device::BrickStepper)
    device.deviceInternal.reset()
end

export write_bricklet_plugin
"""
    $(SIGNATURES)

Writes 32 bytes of firmware to the bricklet attached at the given port.
The bytes are written to the position offset * 32.

This function is used by Brick Viewer during flashing. It should not be
necessary to call it in a normal user program.
"""
function write_bricklet_plugin(device::BrickStepper, port, offset, chunk)
    device.deviceInternal.write_bricklet_plugin(port, offset, chunk)
end

export read_bricklet_plugin
"""
    $(SIGNATURES)

Reads 32 bytes of firmware from the bricklet attached at the given port.
The bytes are read starting at the position offset * 32.

This function is used by Brick Viewer during flashing. It should not be
necessary to call it in a normal user program.
"""
function read_bricklet_plugin(device::BrickStepper, port, offset)
    return device.deviceInternal.read_bricklet_plugin(port, offset)
end

export get_identity
"""
    $(SIGNATURES)

Returns the UID, the UID where the Brick is connected to,
the position, the hardware and firmware version as well as the
device identifier.

The position is the position in the stack from '0' (bottom) to '8' (top).

The device identifier numbers can be found :ref:`here <device_identifier>`.
|device_identifier_constant|
"""
function get_identity(device::BrickStepper)
    return device.deviceInternal.get_identity()
end

export register_callback
"""
Registers the given *function* with the given *callback_id*.
"""
function register_callback(device::BrickStepper, callback_id, function_)
    if isnothing(function_)
        device.registered_callbacks.pop(callback_id, None)
    else
        device.registered_callbacks[callback_id] = function_
    end
end
