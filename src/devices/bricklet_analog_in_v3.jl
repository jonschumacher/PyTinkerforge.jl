


export BrickletAnalogInV3VoltageCallbackConfiguration
struct BrickletAnalogInV3VoltageCallbackConfiguration
    period::Integer
    value_has_to_change::Bool
    option::Char
    min::Integer
    max::Integer
end

export BrickletAnalogInV3Calibration
struct BrickletAnalogInV3Calibration
    offset::Integer
    multiplier::Integer
    divisor::Integer
end

export BrickletAnalogInV3SPITFPErrorCount
struct BrickletAnalogInV3SPITFPErrorCount
    error_count_ack_checksum::Integer
    error_count_message_checksum::Integer
    error_count_frame::Integer
    error_count_overflow::Integer
end

export BrickletAnalogInV3Identity
struct BrickletAnalogInV3Identity
    uid::String
    connected_uid::String
    position::Char
    hardware_version::Vector{Integer}
    firmware_version::Vector{Integer}
    device_identifier::Integer
end

export BrickletAnalogInV3
"""
Measures DC voltage between 0V and 42V
"""
mutable struct BrickletAnalogInV3 <: TinkerforgeDevice
    ipcon::IPConnection
    deviceInternal::PyObject

    """
    Creates an object with the unique device ID *uid* and adds it to
    the IP Connection *ipcon*.
    """
    function BrickletAnalogInV3(uid::String, ipcon::IPConnection)
        package = pyimport("tinkerforge.bricklet_analog_in_v3")
        deviceInternal = package.BrickletAnalogInV3(uid, ipcon.ipconInternal)

        return new(ipcon, deviceInternal)
    end
end

export get_voltage
"""
    $(SIGNATURES)

Returns the measured voltage. The resolution is approximately 10mV to 1mV
depending on the oversampling configuration (:func:`Set Oversampling`).


If you want to get the value periodically, it is recommended to use the
:cb:`Voltage` callback. You can set the callback configuration
with :func:`Set Voltage Callback Configuration`.
"""
function get_voltage(device::BrickletAnalogInV3)
    return device.deviceInternal.get_voltage()
end

export set_voltage_callback_configuration
"""
    $(SIGNATURES)

The period is the period with which the :cb:`Voltage` callback is triggered
periodically. A value of 0 turns the callback off.

If the `value has to change`-parameter is set to true, the callback is only
triggered after the value has changed. If the value didn't change
within the period, the callback is triggered immediately on change.

If it is set to false, the callback is continuously triggered with the period,
independent of the value.

It is furthermore possible to constrain the callback with thresholds.

The `option`-parameter together with min/max sets a threshold for the :cb:`Voltage` callback.

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
function set_voltage_callback_configuration(device::BrickletAnalogInV3, period, value_has_to_change, option, min, max)
    device.deviceInternal.set_voltage_callback_configuration(period, value_has_to_change, option, min, max)
end

export get_voltage_callback_configuration
"""
    $(SIGNATURES)

Returns the callback configuration as set by :func:`Set Voltage Callback Configuration`.
"""
function get_voltage_callback_configuration(device::BrickletAnalogInV3)
    return device.deviceInternal.get_voltage_callback_configuration()
end

export set_oversampling
"""
    $(SIGNATURES)

Sets the oversampling between 32x and 16384x. The Bricklet
takes one 12bit sample every 17.5µs. Thus an oversampling
of 32x is equivalent to an integration time of 0.56ms and
a oversampling of 16384x is equivalent to an integration
time of 286ms.

The oversampling uses the moving average principle. A
new value is always calculated once per millisecond.

With increased oversampling the noise decreases. With decreased
oversampling the reaction time increases (changes in voltage will be
measured faster).
"""
function set_oversampling(device::BrickletAnalogInV3, oversampling)
    device.deviceInternal.set_oversampling(oversampling)
end

export get_oversampling
"""
    $(SIGNATURES)

Returns the oversampling value as set by :func:`Set Oversampling`.
"""
function get_oversampling(device::BrickletAnalogInV3)
    return device.deviceInternal.get_oversampling()
end

export set_calibration
"""
    $(SIGNATURES)

Sets a calibration for the measured voltage value.
The formula for the calibration is as follows::

 Calibrated Value = (Value + Offset) * Multiplier / Divisor

We recommend that you use the Brick Viewer to calibrate
the Bricklet. The calibration will be saved internally and only
has to be done once.
"""
function set_calibration(device::BrickletAnalogInV3, offset, multiplier, divisor)
    device.deviceInternal.set_calibration(offset, multiplier, divisor)
end

export get_calibration
"""
    $(SIGNATURES)

Returns the calibration as set by :func:`Set Calibration`.
"""
function get_calibration(device::BrickletAnalogInV3)
    return device.deviceInternal.get_calibration()
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
function get_spitfp_error_count(device::BrickletAnalogInV3)
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
function set_bootloader_mode(device::BrickletAnalogInV3, mode)
    return device.deviceInternal.set_bootloader_mode(mode)
end

export get_bootloader_mode
"""
    $(SIGNATURES)

Returns the current bootloader mode, see :func:`Set Bootloader Mode`.
"""
function get_bootloader_mode(device::BrickletAnalogInV3)
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
function set_write_firmware_pointer(device::BrickletAnalogInV3, pointer)
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
function write_firmware(device::BrickletAnalogInV3, data)
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
function set_status_led_config(device::BrickletAnalogInV3, config)
    device.deviceInternal.set_status_led_config(config)
end

export get_status_led_config
"""
    $(SIGNATURES)

Returns the configuration as set by :func:`Set Status LED Config`
"""
function get_status_led_config(device::BrickletAnalogInV3)
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
function get_chip_temperature(device::BrickletAnalogInV3)
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
function reset(device::BrickletAnalogInV3)
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
function write_uid(device::BrickletAnalogInV3, uid)
    device.deviceInternal.write_uid(uid)
end

export read_uid
"""
    $(SIGNATURES)

Returns the current UID as an integer. Encode as
Base58 to get the usual string version.
"""
function read_uid(device::BrickletAnalogInV3)
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
function get_identity(device::BrickletAnalogInV3)
    return device.deviceInternal.get_identity()
end

export register_callback
"""
Registers the given *function* with the given *callback_id*.
"""
function register_callback(device::BrickletAnalogInV3, callback_id, function_)
    if isnothing(function_)
        device.registered_callbacks.pop(callback_id, None)
    else
        device.registered_callbacks[callback_id] = function_
    end
end
