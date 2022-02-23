


export BrickletMotorizedLinearPotiPositionCallbackConfiguration
struct BrickletMotorizedLinearPotiPositionCallbackConfiguration
    period::Integer
    value_has_to_change::Bool
    option::Char
    min::Integer
    max::Integer
end

export BrickletMotorizedLinearPotiMotorPosition
struct BrickletMotorizedLinearPotiMotorPosition
    position::Integer
    drive_mode::Integer
    hold_position::Bool
    position_reached::Bool
end

export BrickletMotorizedLinearPotiSPITFPErrorCount
struct BrickletMotorizedLinearPotiSPITFPErrorCount
    error_count_ack_checksum::Integer
    error_count_message_checksum::Integer
    error_count_frame::Integer
    error_count_overflow::Integer
end

export BrickletMotorizedLinearPotiIdentity
struct BrickletMotorizedLinearPotiIdentity
    uid::String
    connected_uid::String
    position::Char
    hardware_version::Vector{Integer}
    firmware_version::Vector{Integer}
    device_identifier::Integer
end

export BrickletMotorizedLinearPoti
"""
Motorized Linear Potentiometer
"""
mutable struct BrickletMotorizedLinearPoti <: TinkerforgeDevice
    ipcon::IPConnection
    deviceInternal::PyObject

    """
    Creates an object with the unique device ID *uid* and adds it to
    the IP Connection *ipcon*.
    """
    function BrickletMotorizedLinearPoti(uid::String, ipcon::IPConnection)
        package = pyimport("tinkerforge.bricklet_motorized_linear_poti")
        deviceInternal = package.BrickletMotorizedLinearPoti(uid, ipcon.ipconInternal)

        return new(ipcon, deviceInternal)
    end
end

export get_position
"""
    $(SIGNATURES)

Returns the position of the linear potentiometer. The value is
between 0 (slider down) and 100 (slider up).


If you want to get the value periodically, it is recommended to use the
:cb:`Position` callback. You can set the callback configuration
with :func:`Set Position Callback Configuration`.
"""
function get_position(device::BrickletMotorizedLinearPoti)
    return device.deviceInternal.get_position()
end

export set_position_callback_configuration
"""
    $(SIGNATURES)

The period is the period with which the :cb:`Position` callback is triggered
periodically. A value of 0 turns the callback off.

If the `value has to change`-parameter is set to true, the callback is only
triggered after the value has changed. If the value didn't change
within the period, the callback is triggered immediately on change.

If it is set to false, the callback is continuously triggered with the period,
independent of the value.

It is furthermore possible to constrain the callback with thresholds.

The `option`-parameter together with min/max sets a threshold for the :cb:`Position` callback.

The following options are possible:

.. csv-table::
 :header: "Option", "Description"
 :widths: 10, 100

 "'x'",    "Threshold is turned off"
 "'o'",    "Threshold is triggered when the value is *outside* the min and max values"
 "'i'",    "Threshold is triggered when the value is *inside* or equal to the min and max values"
 "'<'",    "Threshold is triggered when the value is smaller than the min value (max is ignored)"
 "'>'",    "Threshold is triggered when the value is greater than the min value (max is ignored)"

If the option is set to 'x' (threshold turned off) the callback is triggered with the fixed period.
"""
function set_position_callback_configuration(device::BrickletMotorizedLinearPoti, period, value_has_to_change, option, min, max)
    device.deviceInternal.set_position_callback_configuration(period, value_has_to_change, option, min, max)
end

export get_position_callback_configuration
"""
    $(SIGNATURES)

Returns the callback configuration as set by :func:`Set Position Callback Configuration`.
"""
function get_position_callback_configuration(device::BrickletMotorizedLinearPoti)
    return device.deviceInternal.get_position_callback_configuration()
end

export set_motor_position
"""
    $(SIGNATURES)

Sets the position of the potentiometer. The motorized potentiometer will
immediately start to approach the position. Depending on the chosen drive mode,
the position will either be reached as fast as possible or in a slow but smooth
motion.

The position has to be between 0 (slider down) and 100 (slider up).

If you set the hold position parameter to true, the position will automatically
be retained. If a user changes the position of the potentiometer, it will
automatically drive back to the original set point.

If the hold position parameter is set to false, the potentiometer can be changed
again by the user as soon as the set point was reached once.
"""
function set_motor_position(device::BrickletMotorizedLinearPoti, position, drive_mode, hold_position)
    device.deviceInternal.set_motor_position(position, drive_mode, hold_position)
end

export get_motor_position
"""
    $(SIGNATURES)

Returns the last motor position as set by :func:`Set Motor Position`. This is not
the current position (use :func:`Get Position` to get the current position). This
is the last used set point and configuration.

The position reached parameter is true if the position has been reached at one point.
The position may have been changed again in the meantime by the user.
"""
function get_motor_position(device::BrickletMotorizedLinearPoti)
    return device.deviceInternal.get_motor_position()
end

export calibrate
"""
    $(SIGNATURES)

Starts a calibration procedure. The potentiometer will be driven to the extreme
points to calibrate the potentiometer.

The calibration is saved in flash, it does not have to be called on every start up.

The Motorized Linear Poti Bricklet is already factory-calibrated during
testing at Tinkerforge.
"""
function calibrate(device::BrickletMotorizedLinearPoti)
    device.deviceInternal.calibrate()
end

export set_position_reached_callback_configuration
"""
    $(SIGNATURES)

Enables/Disables :cb:`Position Reached` callback.
"""
function set_position_reached_callback_configuration(device::BrickletMotorizedLinearPoti, enabled)
    device.deviceInternal.set_position_reached_callback_configuration(enabled)
end

export get_position_reached_callback_configuration
"""
    $(SIGNATURES)

Returns the :cb:`Position Reached` callback configuration
as set by :func:`Set Position Reached Callback Configuration`.
"""
function get_position_reached_callback_configuration(device::BrickletMotorizedLinearPoti)
    return device.deviceInternal.get_position_reached_callback_configuration()
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
function get_spitfp_error_count(device::BrickletMotorizedLinearPoti)
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
function set_bootloader_mode(device::BrickletMotorizedLinearPoti, mode)
    return device.deviceInternal.set_bootloader_mode(mode)
end

export get_bootloader_mode
"""
    $(SIGNATURES)

Returns the current bootloader mode, see :func:`Set Bootloader Mode`.
"""
function get_bootloader_mode(device::BrickletMotorizedLinearPoti)
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
function set_write_firmware_pointer(device::BrickletMotorizedLinearPoti, pointer)
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
function write_firmware(device::BrickletMotorizedLinearPoti, data)
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
function set_status_led_config(device::BrickletMotorizedLinearPoti, config)
    device.deviceInternal.set_status_led_config(config)
end

export get_status_led_config
"""
    $(SIGNATURES)

Returns the configuration as set by :func:`Set Status LED Config`
"""
function get_status_led_config(device::BrickletMotorizedLinearPoti)
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
function get_chip_temperature(device::BrickletMotorizedLinearPoti)
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
function reset(device::BrickletMotorizedLinearPoti)
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
function write_uid(device::BrickletMotorizedLinearPoti, uid)
    device.deviceInternal.write_uid(uid)
end

export read_uid
"""
    $(SIGNATURES)

Returns the current UID as an integer. Encode as
Base58 to get the usual string version.
"""
function read_uid(device::BrickletMotorizedLinearPoti)
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
function get_identity(device::BrickletMotorizedLinearPoti)
    return device.deviceInternal.get_identity()
end

export register_callback
"""
Registers the given *function* with the given *callback_id*.
"""
function register_callback(device::BrickletMotorizedLinearPoti, callback_id, function_)
    if isnothing(function_)
        device.registered_callbacks.pop(callback_id, None)
    else
        device.registered_callbacks[callback_id] = function_
    end
end
