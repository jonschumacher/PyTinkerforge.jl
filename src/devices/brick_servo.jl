


export BrickServoPulseWidth
struct BrickServoPulseWidth
    min::Integer
    max::Integer
end

export BrickServoDegree
struct BrickServoDegree
    min::Integer
    max::Integer
end

export BrickServoSPITFPBaudrateConfig
struct BrickServoSPITFPBaudrateConfig
    enable_dynamic_baudrate::Bool
    minimum_dynamic_baudrate::Integer
end

export BrickServoSPITFPErrorCount
struct BrickServoSPITFPErrorCount
    error_count_ack_checksum::Integer
    error_count_message_checksum::Integer
    error_count_frame::Integer
    error_count_overflow::Integer
end

export BrickServoProtocol1BrickletName
struct BrickServoProtocol1BrickletName
    protocol_version::Integer
    firmware_version::Vector{Integer}
    name::String
end

export BrickServoIdentity
struct BrickServoIdentity
    uid::String
    connected_uid::String
    position::Char
    hardware_version::Vector{Integer}
    firmware_version::Vector{Integer}
    device_identifier::Integer
end

export BrickServo
"""
Drives up to 7 RC Servos with up to 3A
"""
mutable struct BrickServo <: TinkerforgeDevice
    ipcon::IPConnection
    deviceInternal::PyObject

    """
    Creates an object with the unique device ID *uid* and adds it to
    the IP Connection *ipcon*.
    """
    function BrickServo(uid::String, ipcon::IPConnection)
        package = pyimport("tinkerforge.brick_servo")
        deviceInternal = package.BrickServo(uid, ipcon.ipconInternal)

        return new(ipcon, deviceInternal)
    end
end

export enable
"""
    $(SIGNATURES)

Enables a servo (0 to 6). If a servo is enabled, the configured position,
velocity, acceleration, etc. are applied immediately.
"""
function enable(device::BrickServo, servo_num)
    device.deviceInternal.enable(servo_num)
end

export disable
"""
    $(SIGNATURES)

Disables a servo (0 to 6). Disabled servos are not driven at all, i.e. a
disabled servo will not hold its position if a load is applied.
"""
function disable(device::BrickServo, servo_num)
    device.deviceInternal.disable(servo_num)
end

export is_enabled
"""
    $(SIGNATURES)

Returns *true* if the specified servo is enabled, *false* otherwise.
"""
function is_enabled(device::BrickServo, servo_num)
    return device.deviceInternal.is_enabled(servo_num)
end

export set_position
"""
    $(SIGNATURES)

Sets the position for the specified servo.

The default range of the position is -9000 to 9000, but it can be specified
according to your servo with :func:`Set Degree`.

If you want to control a linear servo or RC brushless motor controller or
similar with the Servo Brick, you can also define lengths or speeds with
:func:`Set Degree`.
"""
function set_position(device::BrickServo, servo_num, position)
    device.deviceInternal.set_position(servo_num, position)
end

export get_position
"""
    $(SIGNATURES)

Returns the position of the specified servo as set by :func:`Set Position`.
"""
function get_position(device::BrickServo, servo_num)
    return device.deviceInternal.get_position(servo_num)
end

export get_current_position
"""
    $(SIGNATURES)

Returns the *current* position of the specified servo. This may not be the
value of :func:`Set Position` if the servo is currently approaching a
position goal.
"""
function get_current_position(device::BrickServo, servo_num)
    return device.deviceInternal.get_current_position(servo_num)
end

export set_velocity
"""
    $(SIGNATURES)

Sets the maximum velocity of the specified servo. The velocity
is accelerated according to the value set by :func:`Set Acceleration`.

The minimum velocity is 0 (no movement) and the maximum velocity is 65535.
With a value of 65535 the position will be set immediately (no velocity).
"""
function set_velocity(device::BrickServo, servo_num, velocity)
    device.deviceInternal.set_velocity(servo_num, velocity)
end

export get_velocity
"""
    $(SIGNATURES)

Returns the velocity of the specified servo as set by :func:`Set Velocity`.
"""
function get_velocity(device::BrickServo, servo_num)
    return device.deviceInternal.get_velocity(servo_num)
end

export get_current_velocity
"""
    $(SIGNATURES)

Returns the *current* velocity of the specified servo. This may not be the
value of :func:`Set Velocity` if the servo is currently approaching a
velocity goal.
"""
function get_current_velocity(device::BrickServo, servo_num)
    return device.deviceInternal.get_current_velocity(servo_num)
end

export set_acceleration
"""
    $(SIGNATURES)

Sets the acceleration of the specified servo.

The minimum acceleration is 1 and the maximum acceleration is 65535.
With a value of 65535 the velocity will be set immediately (no acceleration).
"""
function set_acceleration(device::BrickServo, servo_num, acceleration)
    device.deviceInternal.set_acceleration(servo_num, acceleration)
end

export get_acceleration
"""
    $(SIGNATURES)

Returns the acceleration for the specified servo as set by
:func:`Set Acceleration`.
"""
function get_acceleration(device::BrickServo, servo_num)
    return device.deviceInternal.get_acceleration(servo_num)
end

export set_output_voltage
"""
    $(SIGNATURES)

Sets the output voltages with which the servos are driven.

.. note::
 We recommend that you set this value to the maximum voltage that is
 specified for your servo, most servos achieve their maximum force only
 with high voltages.
"""
function set_output_voltage(device::BrickServo, voltage)
    device.deviceInternal.set_output_voltage(voltage)
end

export get_output_voltage
"""
    $(SIGNATURES)

Returns the output voltage as specified by :func:`Set Output Voltage`.
"""
function get_output_voltage(device::BrickServo)
    return device.deviceInternal.get_output_voltage()
end

export set_pulse_width
"""
    $(SIGNATURES)

Sets the minimum and maximum pulse width of the specified servo.

Usually, servos are controlled with a
`PWM <https://en.wikipedia.org/wiki/Pulse-width_modulation>`__, whereby the
length of the pulse controls the position of the servo. Every servo has
different minimum and maximum pulse widths, these can be specified with
this function.

If you have a datasheet for your servo that specifies the minimum and
maximum pulse width, you should set the values accordingly. If your servo
comes without any datasheet you have to find the values via trial and error.

The minimum must be smaller than the maximum.
"""
function set_pulse_width(device::BrickServo, servo_num, min, max)
    device.deviceInternal.set_pulse_width(servo_num, min, max)
end

export get_pulse_width
"""
    $(SIGNATURES)

Returns the minimum and maximum pulse width for the specified servo as set by
:func:`Set Pulse Width`.
"""
function get_pulse_width(device::BrickServo, servo_num)
    return device.deviceInternal.get_pulse_width(servo_num)
end

export set_degree
"""
    $(SIGNATURES)

Sets the minimum and maximum degree for the specified servo (by default
given as °/100).

This only specifies the abstract values between which the minimum and maximum
pulse width is scaled. For example: If you specify a pulse width of 1000µs
to 2000µs and a degree range of -90° to 90°, a call of :func:`Set Position`
with 0 will result in a pulse width of 1500µs
(-90° = 1000µs, 90° = 2000µs, etc.).

Possible usage:

* The datasheet of your servo specifies a range of 200° with the middle position
  at 110°. In this case you can set the minimum to -9000 and the maximum to 11000.
* You measure a range of 220° on your servo and you don't have or need a middle
  position. In this case you can set the minimum to 0 and the maximum to 22000.
* You have a linear servo with a drive length of 20cm, In this case you could
  set the minimum to 0 and the maximum to 20000. Now you can set the Position
  with :func:`Set Position` with a resolution of cm/100. Also the velocity will
  have a resolution of cm/100s and the acceleration will have a resolution of
  cm/100s².
* You don't care about units and just want the highest possible resolution. In
  this case you should set the minimum to -32767 and the maximum to 32767.
* You have a brushless motor with a maximum speed of 10000 rpm and want to
  control it with a RC brushless motor controller. In this case you can set the
  minimum to 0 and the maximum to 10000. :func:`Set Position` now controls the rpm.

The minimum must be smaller than the maximum.
"""
function set_degree(device::BrickServo, servo_num, min, max)
    device.deviceInternal.set_degree(servo_num, min, max)
end

export get_degree
"""
    $(SIGNATURES)

Returns the minimum and maximum degree for the specified servo as set by
:func:`Set Degree`.
"""
function get_degree(device::BrickServo, servo_num)
    return device.deviceInternal.get_degree(servo_num)
end

export set_period
"""
    $(SIGNATURES)

Sets the period of the specified servo.

Usually, servos are controlled with a
`PWM <https://en.wikipedia.org/wiki/Pulse-width_modulation>`__. Different
servos expect PWMs with different periods. Most servos run well with a
period of about 20ms.

If your servo comes with a datasheet that specifies a period, you should
set it accordingly. If you don't have a datasheet and you have no idea
what the correct period is, the default value will most likely
work fine.
"""
function set_period(device::BrickServo, servo_num, period)
    device.deviceInternal.set_period(servo_num, period)
end

export get_period
"""
    $(SIGNATURES)

Returns the period for the specified servo as set by :func:`Set Period`.
"""
function get_period(device::BrickServo, servo_num)
    return device.deviceInternal.get_period(servo_num)
end

export get_servo_current
"""
    $(SIGNATURES)

Returns the current consumption of the specified servo.
"""
function get_servo_current(device::BrickServo, servo_num)
    return device.deviceInternal.get_servo_current(servo_num)
end

export get_overall_current
"""
    $(SIGNATURES)

Returns the current consumption of all servos together.
"""
function get_overall_current(device::BrickServo)
    return device.deviceInternal.get_overall_current()
end

export get_stack_input_voltage
"""
    $(SIGNATURES)

Returns the stack input voltage. The stack input voltage is the
voltage that is supplied via the stack, i.e. it is given by a
Step-Down or Step-Up Power Supply.
"""
function get_stack_input_voltage(device::BrickServo)
    return device.deviceInternal.get_stack_input_voltage()
end

export get_external_input_voltage
"""
    $(SIGNATURES)

Returns the external input voltage. The external input voltage is
given via the black power input connector on the Servo Brick.

If there is an external input voltage and a stack input voltage, the motors
will be driven by the external input voltage. If there is only a stack
voltage present, the motors will be driven by this voltage.

.. warning::
 This means, if you have a high stack voltage and a low external voltage,
 the motors will be driven with the low external voltage. If you then remove
 the external connection, it will immediately be driven by the high
 stack voltage
"""
function get_external_input_voltage(device::BrickServo)
    return device.deviceInternal.get_external_input_voltage()
end

export set_minimum_voltage
"""
    $(SIGNATURES)

Sets the minimum voltage, below which the :cb:`Under Voltage` callback
is triggered. The minimum possible value that works with the Servo Brick is 5V.
You can use this function to detect the discharge of a battery that is used
to drive the stepper motor. If you have a fixed power supply, you likely do
not need this functionality.
"""
function set_minimum_voltage(device::BrickServo, voltage)
    device.deviceInternal.set_minimum_voltage(voltage)
end

export get_minimum_voltage
"""
    $(SIGNATURES)

Returns the minimum voltage as set by :func:`Set Minimum Voltage`
"""
function get_minimum_voltage(device::BrickServo)
    return device.deviceInternal.get_minimum_voltage()
end

export enable_position_reached_callback
"""
    $(SIGNATURES)

Enables the :cb:`Position Reached` callback.

Default is disabled.

.. versionadded:: 2.0.1\$nbsp;(Firmware)
"""
function enable_position_reached_callback(device::BrickServo)
    device.deviceInternal.enable_position_reached_callback()
end

export disable_position_reached_callback
"""
    $(SIGNATURES)

Disables the :cb:`Position Reached` callback.

.. versionadded:: 2.0.1\$nbsp;(Firmware)
"""
function disable_position_reached_callback(device::BrickServo)
    device.deviceInternal.disable_position_reached_callback()
end

export is_position_reached_callback_enabled
"""
    $(SIGNATURES)

Returns *true* if :cb:`Position Reached` callback is enabled, *false* otherwise.

.. versionadded:: 2.0.1\$nbsp;(Firmware)
"""
function is_position_reached_callback_enabled(device::BrickServo)
    return device.deviceInternal.is_position_reached_callback_enabled()
end

export enable_velocity_reached_callback
"""
    $(SIGNATURES)

Enables the :cb:`Velocity Reached` callback.

Default is disabled.

.. versionadded:: 2.0.1\$nbsp;(Firmware)
"""
function enable_velocity_reached_callback(device::BrickServo)
    device.deviceInternal.enable_velocity_reached_callback()
end

export disable_velocity_reached_callback
"""
    $(SIGNATURES)

Disables the :cb:`Velocity Reached` callback.

Default is disabled.

.. versionadded:: 2.0.1\$nbsp;(Firmware)
"""
function disable_velocity_reached_callback(device::BrickServo)
    device.deviceInternal.disable_velocity_reached_callback()
end

export is_velocity_reached_callback_enabled
"""
    $(SIGNATURES)

Returns *true* if :cb:`Velocity Reached` callback is enabled, *false* otherwise.

.. versionadded:: 2.0.1\$nbsp;(Firmware)
"""
function is_velocity_reached_callback_enabled(device::BrickServo)
    return device.deviceInternal.is_velocity_reached_callback_enabled()
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

.. versionadded:: 2.3.4\$nbsp;(Firmware)
"""
function set_spitfp_baudrate_config(device::BrickServo, enable_dynamic_baudrate, minimum_dynamic_baudrate)
    device.deviceInternal.set_spitfp_baudrate_config(enable_dynamic_baudrate, minimum_dynamic_baudrate)
end

export get_spitfp_baudrate_config
"""
    $(SIGNATURES)

Returns the baudrate config, see :func:`Set SPITFP Baudrate Config`.

.. versionadded:: 2.3.4\$nbsp;(Firmware)
"""
function get_spitfp_baudrate_config(device::BrickServo)
    return device.deviceInternal.get_spitfp_baudrate_config()
end

export get_send_timeout_count
"""
    $(SIGNATURES)

Returns the timeout count for the different communication methods.

The methods 0-2 are available for all Bricks, 3-7 only for Master Bricks.

This function is mostly used for debugging during development, in normal operation
the counters should nearly always stay at 0.

.. versionadded:: 2.3.2\$nbsp;(Firmware)
"""
function get_send_timeout_count(device::BrickServo, communication_method)
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

.. versionadded:: 2.3.2\$nbsp;(Firmware)
"""
function set_spitfp_baudrate(device::BrickServo, bricklet_port, baudrate)
    device.deviceInternal.set_spitfp_baudrate(bricklet_port, baudrate)
end

export get_spitfp_baudrate
"""
    $(SIGNATURES)

Returns the baudrate for a given Bricklet port, see :func:`Set SPITFP Baudrate`.

.. versionadded:: 2.3.2\$nbsp;(Firmware)
"""
function get_spitfp_baudrate(device::BrickServo, bricklet_port)
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

.. versionadded:: 2.3.2\$nbsp;(Firmware)
"""
function get_spitfp_error_count(device::BrickServo, bricklet_port)
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
function enable_status_led(device::BrickServo)
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
function disable_status_led(device::BrickServo)
    device.deviceInternal.disable_status_led()
end

export is_status_led_enabled
"""
    $(SIGNATURES)

Returns *true* if the status LED is enabled, *false* otherwise.

.. versionadded:: 2.3.1\$nbsp;(Firmware)
"""
function is_status_led_enabled(device::BrickServo)
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
function get_protocol1_bricklet_name(device::BrickServo, port)
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
function get_chip_temperature(device::BrickServo)
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
function reset(device::BrickServo)
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
function write_bricklet_plugin(device::BrickServo, port, offset, chunk)
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
function read_bricklet_plugin(device::BrickServo, port, offset)
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
function get_identity(device::BrickServo)
    return device.deviceInternal.get_identity()
end

export register_callback
"""
Registers the given *function* with the given *callback_id*.
"""
function register_callback(device::BrickServo, callback_id, function_)
    if isnothing(function_)
        device.registered_callbacks.pop(callback_id, None)
    else
        device.registered_callbacks[callback_id] = function_
    end
end
