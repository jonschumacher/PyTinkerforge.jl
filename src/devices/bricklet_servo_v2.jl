


export BrickletServoV2Status
struct BrickletServoV2Status
    enabled::Vector{Bool}
    current_position::Vector{Integer}
    current_velocity::Vector{Integer}
    current::Vector{Integer}
    input_voltage::Integer
end

export BrickletServoV2MotionConfiguration
struct BrickletServoV2MotionConfiguration
    velocity::Integer
    acceleration::Integer
    deceleration::Integer
end

export BrickletServoV2PulseWidth
struct BrickletServoV2PulseWidth
    min::Integer
    max::Integer
end

export BrickletServoV2Degree
struct BrickletServoV2Degree
    min::Integer
    max::Integer
end

export BrickletServoV2SPITFPErrorCount
struct BrickletServoV2SPITFPErrorCount
    error_count_ack_checksum::Integer
    error_count_message_checksum::Integer
    error_count_frame::Integer
    error_count_overflow::Integer
end

export BrickletServoV2Identity
struct BrickletServoV2Identity
    uid::String
    connected_uid::String
    position::Char
    hardware_version::Vector{Integer}
    firmware_version::Vector{Integer}
    device_identifier::Integer
end

export BrickletServoV2
"""
Drives up to 10 RC Servos
"""
mutable struct BrickletServoV2 <: TinkerforgeDevice
    ipcon::IPConnection
    deviceInternal::PyObject

    """
    Creates an object with the unique device ID *uid* and adds it to
    the IP Connection *ipcon*.
    """
    function BrickletServoV2(uid::String, ipcon::IPConnection)
        package = pyimport("tinkerforge.bricklet_servo_v2")
        deviceInternal = package.BrickletServoV2(uid, ipcon.ipconInternal)

        return new(ipcon, deviceInternal)
    end
end

export get_status
"""
    $(SIGNATURES)

Returns the status information of the Servo Bricklet 2.0.

The status includes

* for each channel if it is enabled or disabled,
* for each channel the current position,
* for each channel the current velocity,
* for each channel the current usage and
* the input voltage.

Please note that the position and the velocity is a snapshot of the
current position and velocity of the servo in motion.
"""
function get_status(device::BrickletServoV2)
    return device.deviceInternal.get_status()
end

export set_enable
"""
    $(SIGNATURES)

Enables a servo channel (0 to 9). If a servo is enabled, the configured position,
velocity, acceleration, etc. are applied immediately.
"""
function set_enable(device::BrickletServoV2, servo_channel, enable)
    device.deviceInternal.set_enable(servo_channel, enable)
end

export get_enabled
"""
    $(SIGNATURES)

Returns *true* if the specified servo channel is enabled, *false* otherwise.
"""
function get_enabled(device::BrickletServoV2, servo_channel)
    return device.deviceInternal.get_enabled(servo_channel)
end

export set_position
"""
    $(SIGNATURES)

Sets the position in °/100 for the specified servo channel.

The default range of the position is -9000 to 9000, but it can be specified
according to your servo with :func:`Set Degree`.

If you want to control a linear servo or RC brushless motor controller or
similar with the Servo Brick, you can also define lengths or speeds with
:func:`Set Degree`.
"""
function set_position(device::BrickletServoV2, servo_channel, position)
    device.deviceInternal.set_position(servo_channel, position)
end

export get_position
"""
    $(SIGNATURES)

Returns the position of the specified servo channel as set by :func:`Set Position`.
"""
function get_position(device::BrickletServoV2, servo_channel)
    return device.deviceInternal.get_position(servo_channel)
end

export get_current_position
"""
    $(SIGNATURES)

Returns the *current* position of the specified servo channel. This may not be the
value of :func:`Set Position` if the servo is currently approaching a
position goal.
"""
function get_current_position(device::BrickletServoV2, servo_channel)
    return device.deviceInternal.get_current_position(servo_channel)
end

export get_current_velocity
"""
    $(SIGNATURES)

Returns the *current* velocity of the specified servo channel. This may not be the
velocity specified by :func:`Set Motion Configuration`. if the servo is
currently approaching a velocity goal.
"""
function get_current_velocity(device::BrickletServoV2, servo_channel)
    return device.deviceInternal.get_current_velocity(servo_channel)
end

export set_motion_configuration
"""
    $(SIGNATURES)

Sets the maximum velocity of the specified servo channel in °/100s as well as
the acceleration and deceleration in °/100s²

With a velocity of 0 °/100s the position will be set immediately (no velocity).

With an acc-/deceleration of 0 °/100s² the velocity will be set immediately
(no acc-/deceleration).
"""
function set_motion_configuration(device::BrickletServoV2, servo_channel, velocity, acceleration, deceleration)
    device.deviceInternal.set_motion_configuration(servo_channel, velocity, acceleration, deceleration)
end

export get_motion_configuration
"""
    $(SIGNATURES)

Returns the motion configuration as set by :func:`Set Motion Configuration`.
"""
function get_motion_configuration(device::BrickletServoV2, servo_channel)
    return device.deviceInternal.get_motion_configuration(servo_channel)
end

export set_pulse_width
"""
    $(SIGNATURES)

Sets the minimum and maximum pulse width of the specified servo channel in µs.

Usually, servos are controlled with a
`PWM <https://en.wikipedia.org/wiki/Pulse-width_modulation>`__, whereby the
length of the pulse controls the position of the servo. Every servo has
different minimum and maximum pulse widths, these can be specified with
this function.

If you have a datasheet for your servo that specifies the minimum and
maximum pulse width, you should set the values accordingly. If your servo
comes without any datasheet you have to find the values via trial and error.

Both values have a range from 1 to 65535 (unsigned 16-bit integer). The
minimum must be smaller than the maximum.

The default values are 1000µs (1ms) and 2000µs (2ms) for minimum and
maximum pulse width.
"""
function set_pulse_width(device::BrickletServoV2, servo_channel, min, max)
    device.deviceInternal.set_pulse_width(servo_channel, min, max)
end

export get_pulse_width
"""
    $(SIGNATURES)

Returns the minimum and maximum pulse width for the specified servo channel as set by
:func:`Set Pulse Width`.
"""
function get_pulse_width(device::BrickletServoV2, servo_channel)
    return device.deviceInternal.get_pulse_width(servo_channel)
end

export set_degree
"""
    $(SIGNATURES)

Sets the minimum and maximum degree for the specified servo channel (by default
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

Both values have a possible range from -32767 to 32767
(signed 16-bit integer). The minimum must be smaller than the maximum.

The default values are -9000 and 9000 for the minimum and maximum degree.
"""
function set_degree(device::BrickletServoV2, servo_channel, min, max)
    device.deviceInternal.set_degree(servo_channel, min, max)
end

export get_degree
"""
    $(SIGNATURES)

Returns the minimum and maximum degree for the specified servo channel as set by
:func:`Set Degree`.
"""
function get_degree(device::BrickletServoV2, servo_channel)
    return device.deviceInternal.get_degree(servo_channel)
end

export set_period
"""
    $(SIGNATURES)

Sets the period of the specified servo channel in µs.

Usually, servos are controlled with a
`PWM <https://en.wikipedia.org/wiki/Pulse-width_modulation>`__. Different
servos expect PWMs with different periods. Most servos run well with a
period of about 20ms.

If your servo comes with a datasheet that specifies a period, you should
set it accordingly. If you don't have a datasheet and you have no idea
what the correct period is, the default value (19.5ms) will most likely
work fine.

The minimum possible period is 1µs and the maximum is 1000000µs.

The default value is 19.5ms (19500µs).
"""
function set_period(device::BrickletServoV2, servo_channel, period)
    device.deviceInternal.set_period(servo_channel, period)
end

export get_period
"""
    $(SIGNATURES)

Returns the period for the specified servo channel as set by :func:`Set Period`.
"""
function get_period(device::BrickletServoV2, servo_channel)
    return device.deviceInternal.get_period(servo_channel)
end

export get_servo_current
"""
    $(SIGNATURES)

Returns the current consumption of the specified servo channel in mA.
"""
function get_servo_current(device::BrickletServoV2, servo_channel)
    return device.deviceInternal.get_servo_current(servo_channel)
end

export set_servo_current_configuration
"""
    $(SIGNATURES)

Sets the averaging duration of the current measurement for the specified servo channel in ms.
"""
function set_servo_current_configuration(device::BrickletServoV2, servo_channel, averaging_duration)
    device.deviceInternal.set_servo_current_configuration(servo_channel, averaging_duration)
end

export get_servo_current_configuration
"""
    $(SIGNATURES)

Returns the servo current configuration for the specified servo channel as set
by :func:`Set Servo Current Configuration`.
"""
function get_servo_current_configuration(device::BrickletServoV2, servo_channel)
    return device.deviceInternal.get_servo_current_configuration(servo_channel)
end

export set_input_voltage_configuration
"""
    $(SIGNATURES)

Sets the averaging duration of the input voltage measurement for the specified servo channel in ms.
"""
function set_input_voltage_configuration(device::BrickletServoV2, averaging_duration)
    device.deviceInternal.set_input_voltage_configuration(averaging_duration)
end

export get_input_voltage_configuration
"""
    $(SIGNATURES)

Returns the input voltage configuration as set by :func:`Set Input Voltage Configuration`.
"""
function get_input_voltage_configuration(device::BrickletServoV2)
    return device.deviceInternal.get_input_voltage_configuration()
end

export get_overall_current
"""
    $(SIGNATURES)

Returns the current consumption of all servos together in mA.
"""
function get_overall_current(device::BrickletServoV2)
    return device.deviceInternal.get_overall_current()
end

export get_input_voltage
"""
    $(SIGNATURES)

Returns the input voltage in mV. The input voltage is
given via the black power input connector on the Servo Brick.
"""
function get_input_voltage(device::BrickletServoV2)
    return device.deviceInternal.get_input_voltage()
end

export set_current_calibration
"""
    $(SIGNATURES)

Sets an offset value (in mA) for each channel.

Note: On delivery the Servo Bricklet 2.0 is already calibrated.
"""
function set_current_calibration(device::BrickletServoV2, offset)
    device.deviceInternal.set_current_calibration(offset)
end

export get_current_calibration
"""
    $(SIGNATURES)

Returns the current calibration as set by :func:`Set Current Calibration`.
"""
function get_current_calibration(device::BrickletServoV2)
    return device.deviceInternal.get_current_calibration()
end

export set_position_reached_callback_configuration
"""
    $(SIGNATURES)

Enable/Disable :cb:`Position Reached` callback.
"""
function set_position_reached_callback_configuration(device::BrickletServoV2, servo_channel, enabled)
    device.deviceInternal.set_position_reached_callback_configuration(servo_channel, enabled)
end

export get_position_reached_callback_configuration
"""
    $(SIGNATURES)

Returns the callback configuration as set by
:func:`Set Position Reached Callback Configuration`.
"""
function get_position_reached_callback_configuration(device::BrickletServoV2, servo_channel)
    return device.deviceInternal.get_position_reached_callback_configuration(servo_channel)
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
function get_spitfp_error_count(device::BrickletServoV2)
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
function set_bootloader_mode(device::BrickletServoV2, mode)
    return device.deviceInternal.set_bootloader_mode(mode)
end

export get_bootloader_mode
"""
    $(SIGNATURES)

Returns the current bootloader mode, see :func:`Set Bootloader Mode`.
"""
function get_bootloader_mode(device::BrickletServoV2)
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
function set_write_firmware_pointer(device::BrickletServoV2, pointer)
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
function write_firmware(device::BrickletServoV2, data)
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
function set_status_led_config(device::BrickletServoV2, config)
    device.deviceInternal.set_status_led_config(config)
end

export get_status_led_config
"""
    $(SIGNATURES)

Returns the configuration as set by :func:`Set Status LED Config`
"""
function get_status_led_config(device::BrickletServoV2)
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
function get_chip_temperature(device::BrickletServoV2)
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
function reset(device::BrickletServoV2)
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
function write_uid(device::BrickletServoV2, uid)
    device.deviceInternal.write_uid(uid)
end

export read_uid
"""
    $(SIGNATURES)

Returns the current UID as an integer. Encode as
Base58 to get the usual string version.
"""
function read_uid(device::BrickletServoV2)
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
function get_identity(device::BrickletServoV2)
    return device.deviceInternal.get_identity()
end

export register_callback
"""
Registers the given *function* with the given *callback_id*.
"""
function register_callback(device::BrickletServoV2, callback_id, function_)
    if isnothing(function_)
        device.registered_callbacks.pop(callback_id, None)
    else
        device.registered_callbacks[callback_id] = function_
    end
end
