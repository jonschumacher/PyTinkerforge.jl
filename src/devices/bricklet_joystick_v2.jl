


export BrickletJoystickV2Position
struct BrickletJoystickV2Position
    x::Integer
    y::Integer
end

export BrickletJoystickV2PositionCallbackConfiguration
struct BrickletJoystickV2PositionCallbackConfiguration
    period::Integer
    value_has_to_change::Bool
end

export BrickletJoystickV2PressedCallbackConfiguration
struct BrickletJoystickV2PressedCallbackConfiguration
    period::Integer
    value_has_to_change::Bool
end

export BrickletJoystickV2SPITFPErrorCount
struct BrickletJoystickV2SPITFPErrorCount
    error_count_ack_checksum::Integer
    error_count_message_checksum::Integer
    error_count_frame::Integer
    error_count_overflow::Integer
end

export BrickletJoystickV2Identity
struct BrickletJoystickV2Identity
    uid::String
    connected_uid::String
    position::Char
    hardware_version::Vector{Integer}
    firmware_version::Vector{Integer}
    device_identifier::Integer
end

export BrickletJoystickV2
"""
2-axis joystick with push-button
"""
mutable struct BrickletJoystickV2 <: TinkerforgeDevice
    ipcon::IPConnection
    deviceInternal::PyObject

    """
    Creates an object with the unique device ID *uid* and adds it to
    the IP Connection *ipcon*.
    """
    function BrickletJoystickV2(uid::String, ipcon::IPConnection)
        package = pyimport("tinkerforge.bricklet_joystick_v2")
        deviceInternal = package.BrickletJoystickV2(uid, ipcon.ipconInternal)

        return new(ipcon, deviceInternal)
    end
end

export get_position
"""
    $(SIGNATURES)

Returns the position of the joystick. The middle position of the joystick is x=0, y=0.
The returned values are averaged and calibrated (see :func:`Calibrate`).

If you want to get the position periodically, it is recommended to use the
:cb:`Position` callback and set the period with
:func:`Set Position Callback Configuration`.
"""
function get_position(device::BrickletJoystickV2)
    return device.deviceInternal.get_position()
end

export is_pressed
"""
    $(SIGNATURES)

Returns *true* if the button is pressed and *false* otherwise.

If you want to get the press-state periodically, it is recommended to use the
:cb:`Pressed` callback and set the period with
:func:`Set Pressed Callback Configuration`.
"""
function is_pressed(device::BrickletJoystickV2)
    return device.deviceInternal.is_pressed()
end

export calibrate
"""
    $(SIGNATURES)

Calibrates the middle position of the joystick. If your Joystick Bricklet 2.0
does not return x=0 and y=0 in the middle position, call this function
while the joystick is standing still in the middle position.

The resulting calibration will be saved in non-volatile memory,
thus you only have to calibrate it once.
"""
function calibrate(device::BrickletJoystickV2)
    device.deviceInternal.calibrate()
end

export set_position_callback_configuration
"""
    $(SIGNATURES)

The period is the period with which the :cb:`Position`
callback is triggered periodically. A value of 0 turns the callback off.

If the `value has to change`-parameter is set to true, the callback is only
triggered after at least one of the values has changed. If the values didn't
change within the period, the callback is triggered immediately on change.

If it is set to false, the callback is continuously triggered with the period,
independent of the value.
"""
function set_position_callback_configuration(device::BrickletJoystickV2, period, value_has_to_change)
    device.deviceInternal.set_position_callback_configuration(period, value_has_to_change)
end

export get_position_callback_configuration
"""
    $(SIGNATURES)

Returns the callback configuration as set by
:func:`Set Position Callback Configuration`.
"""
function get_position_callback_configuration(device::BrickletJoystickV2)
    return device.deviceInternal.get_position_callback_configuration()
end

export set_pressed_callback_configuration
"""
    $(SIGNATURES)

The period is the period with which the :cb:`Pressed`
callback is triggered periodically. A value of 0 turns the callback off.

If the `value has to change`-parameter is set to true, the callback is only
triggered after at least one of the values has changed. If the values didn't
change within the period, the callback is triggered immediately on change.

If it is set to false, the callback is continuously triggered with the period,
independent of the value.
"""
function set_pressed_callback_configuration(device::BrickletJoystickV2, period, value_has_to_change)
    device.deviceInternal.set_pressed_callback_configuration(period, value_has_to_change)
end

export get_pressed_callback_configuration
"""
    $(SIGNATURES)

Returns the callback configuration as set by
:func:`Set Pressed Callback Configuration`.
"""
function get_pressed_callback_configuration(device::BrickletJoystickV2)
    return device.deviceInternal.get_pressed_callback_configuration()
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
function get_spitfp_error_count(device::BrickletJoystickV2)
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
function set_bootloader_mode(device::BrickletJoystickV2, mode)
    return device.deviceInternal.set_bootloader_mode(mode)
end

export get_bootloader_mode
"""
    $(SIGNATURES)

Returns the current bootloader mode, see :func:`Set Bootloader Mode`.
"""
function get_bootloader_mode(device::BrickletJoystickV2)
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
function set_write_firmware_pointer(device::BrickletJoystickV2, pointer)
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
function write_firmware(device::BrickletJoystickV2, data)
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
function set_status_led_config(device::BrickletJoystickV2, config)
    device.deviceInternal.set_status_led_config(config)
end

export get_status_led_config
"""
    $(SIGNATURES)

Returns the configuration as set by :func:`Set Status LED Config`
"""
function get_status_led_config(device::BrickletJoystickV2)
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
function get_chip_temperature(device::BrickletJoystickV2)
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
function reset(device::BrickletJoystickV2)
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
function write_uid(device::BrickletJoystickV2, uid)
    device.deviceInternal.write_uid(uid)
end

export read_uid
"""
    $(SIGNATURES)

Returns the current UID as an integer. Encode as
Base58 to get the usual string version.
"""
function read_uid(device::BrickletJoystickV2)
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
function get_identity(device::BrickletJoystickV2)
    return device.deviceInternal.get_identity()
end

export register_callback
"""
Registers the given *function* with the given *callback_id*.
"""
function register_callback(device::BrickletJoystickV2, callback_id, function_)
    if isnothing(function_)
        device.registered_callbacks.pop(callback_id, None)
    else
        device.registered_callbacks[callback_id] = function_
    end
end
