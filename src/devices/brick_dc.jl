


export BrickDCSPITFPBaudrateConfig
struct BrickDCSPITFPBaudrateConfig
    enable_dynamic_baudrate::Bool
    minimum_dynamic_baudrate::Integer
end

export BrickDCSPITFPErrorCount
struct BrickDCSPITFPErrorCount
    error_count_ack_checksum::Integer
    error_count_message_checksum::Integer
    error_count_frame::Integer
    error_count_overflow::Integer
end

export BrickDCProtocol1BrickletName
struct BrickDCProtocol1BrickletName
    protocol_version::Integer
    firmware_version::Vector{Integer}
    name::String
end

export BrickDCIdentity
struct BrickDCIdentity
    uid::String
    connected_uid::String
    position::Char
    hardware_version::Vector{Integer}
    firmware_version::Vector{Integer}
    device_identifier::Integer
end

export BrickDC
"""
Drives one brushed DC motor with up to 28V and 5A (peak)
"""
mutable struct BrickDC <: TinkerforgeDevice
    ipcon::IPConnection
    deviceInternal::PyObject

    """
    Creates an object with the unique device ID *uid* and adds it to
    the IP Connection *ipcon*.
    """
    function BrickDC(uid::String, ipcon::IPConnection)
        package = pyimport("tinkerforge.brick_dc")
        deviceInternal = package.BrickDC(uid, ipcon.ipconInternal)

        return new(ipcon, deviceInternal)
    end
end

export set_velocity
"""
    $(SIGNATURES)

Sets the velocity of the motor. Whereas -32767 is full speed backward,
0 is stop and 32767 is full speed forward. Depending on the
acceleration (see :func:`Set Acceleration`), the motor is not immediately
brought to the velocity but smoothly accelerated.

The velocity describes the duty cycle of the PWM with which the motor is
controlled, e.g. a velocity of 3277 sets a PWM with a 10% duty cycle.
You can not only control the duty cycle of the PWM but also the frequency,
see :func:`Set PWM Frequency`.
"""
function set_velocity(device::BrickDC, velocity)
    device.deviceInternal.set_velocity(velocity)
end

export get_velocity
"""
    $(SIGNATURES)

Returns the velocity as set by :func:`Set Velocity`.
"""
function get_velocity(device::BrickDC)
    return device.deviceInternal.get_velocity()
end

export get_current_velocity
"""
    $(SIGNATURES)

Returns the *current* velocity of the motor. This value is different
from :func:`Get Velocity` whenever the motor is currently accelerating
to a goal set by :func:`Set Velocity`.
"""
function get_current_velocity(device::BrickDC)
    return device.deviceInternal.get_current_velocity()
end

export set_acceleration
"""
    $(SIGNATURES)

Sets the acceleration of the motor. It is given in *velocity/s*. An
acceleration of 10000 means, that every second the velocity is increased
by 10000 (or about 30% duty cycle).

For example: If the current velocity is 0 and you want to accelerate to a
velocity of 16000 (about 50% duty cycle) in 10 seconds, you should set
an acceleration of 1600.

If acceleration is set to 0, there is no speed ramping, i.e. a new velocity
is immediately given to the motor.
"""
function set_acceleration(device::BrickDC, acceleration)
    device.deviceInternal.set_acceleration(acceleration)
end

export get_acceleration
"""
    $(SIGNATURES)

Returns the acceleration as set by :func:`Set Acceleration`.
"""
function get_acceleration(device::BrickDC)
    return device.deviceInternal.get_acceleration()
end

export set_pwm_frequency
"""
    $(SIGNATURES)

Sets the frequency of the PWM with which the motor is driven.
Often a high frequency
is less noisy and the motor runs smoother. However, with a low frequency
there are less switches and therefore fewer switching losses. Also with
most motors lower frequencies enable higher torque.

If you have no idea what all this means, just ignore this function and use
the default frequency, it will very likely work fine.
"""
function set_pwm_frequency(device::BrickDC, frequency)
    device.deviceInternal.set_pwm_frequency(frequency)
end

export get_pwm_frequency
"""
    $(SIGNATURES)

Returns the PWM frequency as set by :func:`Set PWM Frequency`.
"""
function get_pwm_frequency(device::BrickDC)
    return device.deviceInternal.get_pwm_frequency()
end

export full_brake
"""
    $(SIGNATURES)

Executes an active full brake.

.. warning::
 This function is for emergency purposes,
 where an immediate brake is necessary. Depending on the current velocity and
 the strength of the motor, a full brake can be quite violent.

Call :func:`Set Velocity` with 0 if you just want to stop the motor.
"""
function full_brake(device::BrickDC)
    device.deviceInternal.full_brake()
end

export get_stack_input_voltage
"""
    $(SIGNATURES)

Returns the stack input voltage. The stack input voltage is the
voltage that is supplied via the stack, i.e. it is given by a
Step-Down or Step-Up Power Supply.
"""
function get_stack_input_voltage(device::BrickDC)
    return device.deviceInternal.get_stack_input_voltage()
end

export get_external_input_voltage
"""
    $(SIGNATURES)

Returns the external input voltage. The external input voltage is
given via the black power input connector on the DC Brick.

If there is an external input voltage and a stack input voltage, the motor
will be driven by the external input voltage. If there is only a stack
voltage present, the motor will be driven by this voltage.

.. warning::
 This means, if you have a high stack voltage and a low external voltage,
 the motor will be driven with the low external voltage. If you then remove
 the external connection, it will immediately be driven by the high
 stack voltage.
"""
function get_external_input_voltage(device::BrickDC)
    return device.deviceInternal.get_external_input_voltage()
end

export get_current_consumption
"""
    $(SIGNATURES)

Returns the current consumption of the motor.
"""
function get_current_consumption(device::BrickDC)
    return device.deviceInternal.get_current_consumption()
end

export enable
"""
    $(SIGNATURES)

Enables the driver chip. The driver parameters can be configured (velocity,
acceleration, etc) before it is enabled.
"""
function enable(device::BrickDC)
    device.deviceInternal.enable()
end

export disable
"""
    $(SIGNATURES)

Disables the driver chip. The configurations are kept (velocity,
acceleration, etc) but the motor is not driven until it is enabled again.

.. warning::
 Disabling the driver chip while the motor is still turning can damage the
 driver chip. The motor should be stopped calling :func:`Set Velocity` with 0
 before disabling the motor power. The :func:`Set Velocity` function will **not**
 wait until the motor is actually stopped. You have to explicitly wait for the
 appropriate time after calling the :func:`Set Velocity` function before calling
 the :func:`Disable` function.
"""
function disable(device::BrickDC)
    device.deviceInternal.disable()
end

export is_enabled
"""
    $(SIGNATURES)

Returns *true* if the driver chip is enabled, *false* otherwise.
"""
function is_enabled(device::BrickDC)
    return device.deviceInternal.is_enabled()
end

export set_minimum_voltage
"""
    $(SIGNATURES)

Sets the minimum voltage, below which the :cb:`Under Voltage` callback
is triggered. The minimum possible value that works with the DC Brick is 6V.
You can use this function to detect the discharge of a battery that is used
to drive the motor. If you have a fixed power supply, you likely do not need
this functionality.
"""
function set_minimum_voltage(device::BrickDC, voltage)
    device.deviceInternal.set_minimum_voltage(voltage)
end

export get_minimum_voltage
"""
    $(SIGNATURES)

Returns the minimum voltage as set by :func:`Set Minimum Voltage`
"""
function get_minimum_voltage(device::BrickDC)
    return device.deviceInternal.get_minimum_voltage()
end

export set_drive_mode
"""
    $(SIGNATURES)

Sets the drive mode. Possible modes are:

* 0 = Drive/Brake
* 1 = Drive/Coast

These modes are different kinds of motor controls.

In Drive/Brake mode, the motor is always either driving or braking. There
is no freewheeling. Advantages are: A more linear correlation between
PWM and velocity, more exact accelerations and the possibility to drive
with slower velocities.

In Drive/Coast mode, the motor is always either driving or freewheeling.
Advantages are: Less current consumption and less demands on the motor and
driver chip.
"""
function set_drive_mode(device::BrickDC, mode)
    device.deviceInternal.set_drive_mode(mode)
end

export get_drive_mode
"""
    $(SIGNATURES)

Returns the drive mode, as set by :func:`Set Drive Mode`.
"""
function get_drive_mode(device::BrickDC)
    return device.deviceInternal.get_drive_mode()
end

export set_current_velocity_period
"""
    $(SIGNATURES)

Sets a period with which the :cb:`Current Velocity` callback is triggered.
A period of 0 turns the callback off.
"""
function set_current_velocity_period(device::BrickDC, period)
    device.deviceInternal.set_current_velocity_period(period)
end

export get_current_velocity_period
"""
    $(SIGNATURES)

Returns the period as set by :func:`Set Current Velocity Period`.
"""
function get_current_velocity_period(device::BrickDC)
    return device.deviceInternal.get_current_velocity_period()
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

.. versionadded:: 2.3.5\$nbsp;(Firmware)
"""
function set_spitfp_baudrate_config(device::BrickDC, enable_dynamic_baudrate, minimum_dynamic_baudrate)
    device.deviceInternal.set_spitfp_baudrate_config(enable_dynamic_baudrate, minimum_dynamic_baudrate)
end

export get_spitfp_baudrate_config
"""
    $(SIGNATURES)

Returns the baudrate config, see :func:`Set SPITFP Baudrate Config`.

.. versionadded:: 2.3.5\$nbsp;(Firmware)
"""
function get_spitfp_baudrate_config(device::BrickDC)
    return device.deviceInternal.get_spitfp_baudrate_config()
end

export get_send_timeout_count
"""
    $(SIGNATURES)

Returns the timeout count for the different communication methods.

The methods 0-2 are available for all Bricks, 3-7 only for Master Bricks.

This function is mostly used for debugging during development, in normal operation
the counters should nearly always stay at 0.

.. versionadded:: 2.3.3\$nbsp;(Firmware)
"""
function get_send_timeout_count(device::BrickDC, communication_method)
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
function set_spitfp_baudrate(device::BrickDC, bricklet_port, baudrate)
    device.deviceInternal.set_spitfp_baudrate(bricklet_port, baudrate)
end

export get_spitfp_baudrate
"""
    $(SIGNATURES)

Returns the baudrate for a given Bricklet port, see :func:`Set SPITFP Baudrate`.

.. versionadded:: 2.3.3\$nbsp;(Firmware)
"""
function get_spitfp_baudrate(device::BrickDC, bricklet_port)
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
function get_spitfp_error_count(device::BrickDC, bricklet_port)
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
function enable_status_led(device::BrickDC)
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
function disable_status_led(device::BrickDC)
    device.deviceInternal.disable_status_led()
end

export is_status_led_enabled
"""
    $(SIGNATURES)

Returns *true* if the status LED is enabled, *false* otherwise.

.. versionadded:: 2.3.1\$nbsp;(Firmware)
"""
function is_status_led_enabled(device::BrickDC)
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
function get_protocol1_bricklet_name(device::BrickDC, port)
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
function get_chip_temperature(device::BrickDC)
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
function reset(device::BrickDC)
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
function write_bricklet_plugin(device::BrickDC, port, offset, chunk)
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
function read_bricklet_plugin(device::BrickDC, port, offset)
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
function get_identity(device::BrickDC)
    return device.deviceInternal.get_identity()
end

export register_callback
"""
Registers the given *function* with the given *callback_id*.
"""
function register_callback(device::BrickDC, callback_id, function_)
    if isnothing(function_)
        device.registered_callbacks.pop(callback_id, None)
    else
        device.registered_callbacks[callback_id] = function_
    end
end
