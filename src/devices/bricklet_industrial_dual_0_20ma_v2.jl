


export BrickletIndustrialDual020mAV2CurrentCallbackConfiguration
struct BrickletIndustrialDual020mAV2CurrentCallbackConfiguration
    period::Integer
    value_has_to_change::Bool
    option::Char
    min::Integer
    max::Integer
end

export BrickletIndustrialDual020mAV2ChannelLEDStatusConfig
struct BrickletIndustrialDual020mAV2ChannelLEDStatusConfig
    min::Integer
    max::Integer
    config::Integer
end

export BrickletIndustrialDual020mAV2SPITFPErrorCount
struct BrickletIndustrialDual020mAV2SPITFPErrorCount
    error_count_ack_checksum::Integer
    error_count_message_checksum::Integer
    error_count_frame::Integer
    error_count_overflow::Integer
end

export BrickletIndustrialDual020mAV2Identity
struct BrickletIndustrialDual020mAV2Identity
    uid::String
    connected_uid::String
    position::Char
    hardware_version::Vector{Integer}
    firmware_version::Vector{Integer}
    device_identifier::Integer
end

export BrickletIndustrialDual020mAV2
"""
Measures two DC currents between 0mA and 20mA (IEC 60381-1)
"""
mutable struct BrickletIndustrialDual020mAV2 <: TinkerforgeDevice
    ipcon::IPConnection
    deviceInternal::PyObject

    """
    Creates an object with the unique device ID *uid* and adds it to
    the IP Connection *ipcon*.
    """
    function BrickletIndustrialDual020mAV2(uid::String, ipcon::IPConnection)
        package = pyimport("tinkerforge.bricklet_industrial_dual_0_20ma_v2")
        deviceInternal = package.BrickletIndustrialDual020mAV2(uid, ipcon.ipconInternal)

        return new(ipcon, deviceInternal)
    end
end

export get_current
"""
    $(SIGNATURES)

Returns the current of the specified channel.

It is possible to detect if an IEC 60381-1 compatible sensor is connected
and if it works probably.

If the returned current is below 4mA, there is likely no sensor connected
or the connected sensor is defective. If the returned current is over 20mA,
there might be a short circuit or the sensor is defective.


If you want to get the value periodically, it is recommended to use the
:cb:`Current` callback. You can set the callback configuration
with :func:`Set Current Callback Configuration`.
"""
function get_current(device::BrickletIndustrialDual020mAV2, channel)
    return device.deviceInternal.get_current(channel)
end

export set_current_callback_configuration
"""
    $(SIGNATURES)

The period is the period with which the :cb:`Current` callback is triggered
periodically. A value of 0 turns the callback off.

If the `value has to change`-parameter is set to true, the callback is only
triggered after the value has changed. If the value didn't change
within the period, the callback is triggered immediately on change.

If it is set to false, the callback is continuously triggered with the period,
independent of the value.

It is furthermore possible to constrain the callback with thresholds.

The `option`-parameter together with min/max sets a threshold for the :cb:`Current` callback.

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
function set_current_callback_configuration(device::BrickletIndustrialDual020mAV2, channel, period, value_has_to_change, option, min, max)
    device.deviceInternal.set_current_callback_configuration(channel, period, value_has_to_change, option, min, max)
end

export get_current_callback_configuration
"""
    $(SIGNATURES)

Returns the callback configuration as set by :func:`Set Current Callback Configuration`.
"""
function get_current_callback_configuration(device::BrickletIndustrialDual020mAV2, channel)
    return device.deviceInternal.get_current_callback_configuration(channel)
end

export set_sample_rate
"""
    $(SIGNATURES)

Sets the sample rate to either 240, 60, 15 or 4 samples per second.
The resolution for the rates is 12, 14, 16 and 18 bit respectively.

.. csv-table::
 :header: "Value", "Description"
 :widths: 10, 100

 "0",    "240 samples per second, 12 bit resolution"
 "1",    "60 samples per second, 14 bit resolution"
 "2",    "15 samples per second, 16 bit resolution"
 "3",    "4 samples per second, 18 bit resolution"
"""
function set_sample_rate(device::BrickletIndustrialDual020mAV2, rate)
    device.deviceInternal.set_sample_rate(rate)
end

export get_sample_rate
"""
    $(SIGNATURES)

Returns the sample rate as set by :func:`Set Sample Rate`.
"""
function get_sample_rate(device::BrickletIndustrialDual020mAV2)
    return device.deviceInternal.get_sample_rate()
end

export set_gain
"""
    $(SIGNATURES)

Sets a gain between 1x and 8x. If you want to measure a very small current,
you can increase the gain to get some more resolution.

Example: If you measure 0.5mA with a gain of 8x the return value will be
4mA.
"""
function set_gain(device::BrickletIndustrialDual020mAV2, gain)
    device.deviceInternal.set_gain(gain)
end

export get_gain
"""
    $(SIGNATURES)

Returns the gain as set by :func:`Set Gain`.
"""
function get_gain(device::BrickletIndustrialDual020mAV2)
    return device.deviceInternal.get_gain()
end

export set_channel_led_config
"""
    $(SIGNATURES)

Each channel has a corresponding LED. You can turn the LED off, on or show a
heartbeat. You can also set the LED to "Channel Status". In this mode the
LED can either be turned on with a pre-defined threshold or the intensity
of the LED can change with the measured value.

You can configure the channel status behavior with :func:`Set Channel LED Status Config`.
"""
function set_channel_led_config(device::BrickletIndustrialDual020mAV2, channel, config)
    device.deviceInternal.set_channel_led_config(channel, config)
end

export get_channel_led_config
"""
    $(SIGNATURES)

Returns the channel LED configuration as set by :func:`Set Channel LED Config`
"""
function get_channel_led_config(device::BrickletIndustrialDual020mAV2, channel)
    return device.deviceInternal.get_channel_led_config(channel)
end

export set_channel_led_status_config
"""
    $(SIGNATURES)

Sets the channel LED status config. This config is used if the channel LED is
configured as "Channel Status", see :func:`Set Channel LED Config`.

For each channel you can choose between threshold and intensity mode.

In threshold mode you can define a positive or a negative threshold.
For a positive threshold set the "min" parameter to the threshold value in nA
above which the LED should turn on and set the "max" parameter to 0. Example:
If you set a positive threshold of 10mA, the LED will turn on as soon as the
current exceeds 10mA and turn off again if it goes below 10mA.
For a negative threshold set the "max" parameter to the threshold value in nA
below which the LED should turn on and set the "min" parameter to 0. Example:
If you set a negative threshold of 10mA, the LED will turn on as soon as the
current goes below 10mA and the LED will turn off when the current exceeds 10mA.

In intensity mode you can define a range in nA that is used to scale the brightness
of the LED. Example with min=4mA and max=20mA: The LED is off at 4mA and below,
on at 20mA and above and the brightness is linearly scaled between the values
4mA and 20mA. If the min value is greater than the max value, the LED brightness
is scaled the other way around.
"""
function set_channel_led_status_config(device::BrickletIndustrialDual020mAV2, channel, min, max, config)
    device.deviceInternal.set_channel_led_status_config(channel, min, max, config)
end

export get_channel_led_status_config
"""
    $(SIGNATURES)

Returns the channel LED status configuration as set by
:func:`Set Channel LED Status Config`.
"""
function get_channel_led_status_config(device::BrickletIndustrialDual020mAV2, channel)
    return device.deviceInternal.get_channel_led_status_config(channel)
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
function get_spitfp_error_count(device::BrickletIndustrialDual020mAV2)
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
function set_bootloader_mode(device::BrickletIndustrialDual020mAV2, mode)
    return device.deviceInternal.set_bootloader_mode(mode)
end

export get_bootloader_mode
"""
    $(SIGNATURES)

Returns the current bootloader mode, see :func:`Set Bootloader Mode`.
"""
function get_bootloader_mode(device::BrickletIndustrialDual020mAV2)
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
function set_write_firmware_pointer(device::BrickletIndustrialDual020mAV2, pointer)
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
function write_firmware(device::BrickletIndustrialDual020mAV2, data)
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
function set_status_led_config(device::BrickletIndustrialDual020mAV2, config)
    device.deviceInternal.set_status_led_config(config)
end

export get_status_led_config
"""
    $(SIGNATURES)

Returns the configuration as set by :func:`Set Status LED Config`
"""
function get_status_led_config(device::BrickletIndustrialDual020mAV2)
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
function get_chip_temperature(device::BrickletIndustrialDual020mAV2)
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
function reset(device::BrickletIndustrialDual020mAV2)
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
function write_uid(device::BrickletIndustrialDual020mAV2, uid)
    device.deviceInternal.write_uid(uid)
end

export read_uid
"""
    $(SIGNATURES)

Returns the current UID as an integer. Encode as
Base58 to get the usual string version.
"""
function read_uid(device::BrickletIndustrialDual020mAV2)
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
function get_identity(device::BrickletIndustrialDual020mAV2)
    return device.deviceInternal.get_identity()
end

export register_callback
"""
Registers the given *function* with the given *callback_id*.
"""
function register_callback(device::BrickletIndustrialDual020mAV2, callback_id, function_)
    if isnothing(function_)
        device.registered_callbacks.pop(callback_id, None)
    else
        device.registered_callbacks[callback_id] = function_
    end
end
