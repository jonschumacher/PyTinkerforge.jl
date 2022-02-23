


export BrickletIndustrialDigitalIn4V2ValueCallbackConfiguration
struct BrickletIndustrialDigitalIn4V2ValueCallbackConfiguration
    period::Integer
    value_has_to_change::Bool
end

export BrickletIndustrialDigitalIn4V2AllValueCallbackConfiguration
struct BrickletIndustrialDigitalIn4V2AllValueCallbackConfiguration
    period::Integer
    value_has_to_change::Bool
end

export BrickletIndustrialDigitalIn4V2EdgeCountConfiguration
struct BrickletIndustrialDigitalIn4V2EdgeCountConfiguration
    edge_type::Integer
    debounce::Integer
end

export BrickletIndustrialDigitalIn4V2SPITFPErrorCount
struct BrickletIndustrialDigitalIn4V2SPITFPErrorCount
    error_count_ack_checksum::Integer
    error_count_message_checksum::Integer
    error_count_frame::Integer
    error_count_overflow::Integer
end

export BrickletIndustrialDigitalIn4V2Identity
struct BrickletIndustrialDigitalIn4V2Identity
    uid::String
    connected_uid::String
    position::Char
    hardware_version::Vector{Integer}
    firmware_version::Vector{Integer}
    device_identifier::Integer
end

export BrickletIndustrialDigitalIn4V2
"""
4 galvanically isolated digital inputs
"""
mutable struct BrickletIndustrialDigitalIn4V2 <: TinkerforgeDevice
    ipcon::IPConnection
    deviceInternal::PyObject

    """
    Creates an object with the unique device ID *uid* and adds it to
    the IP Connection *ipcon*.
    """
    function BrickletIndustrialDigitalIn4V2(uid::String, ipcon::IPConnection)
        package = pyimport("tinkerforge.bricklet_industrial_digital_in_4_v2")
        deviceInternal = package.BrickletIndustrialDigitalIn4V2(uid, ipcon.ipconInternal)

        return new(ipcon, deviceInternal)
    end
end

export get_value
"""
    $(SIGNATURES)

Returns the input value as bools, *true* refers to high and *false* refers to low.
"""
function get_value(device::BrickletIndustrialDigitalIn4V2)
    return device.deviceInternal.get_value()
end

export set_value_callback_configuration
"""
    $(SIGNATURES)

This callback can be configured per channel.

The period is the period with which the :cb:`Value`
callback is triggered periodically. A value of 0 turns the callback off.

If the `value has to change`-parameter is set to true, the callback is only
triggered after the value has changed. If the value didn't change within the
period, the callback is triggered immediately on change.

If it is set to false, the callback is continuously triggered with the period,
independent of the value.
"""
function set_value_callback_configuration(device::BrickletIndustrialDigitalIn4V2, channel, period, value_has_to_change)
    device.deviceInternal.set_value_callback_configuration(channel, period, value_has_to_change)
end

export get_value_callback_configuration
"""
    $(SIGNATURES)

Returns the callback configuration for the given channel as set by
:func:`Set Value Callback Configuration`.
"""
function get_value_callback_configuration(device::BrickletIndustrialDigitalIn4V2, channel)
    return device.deviceInternal.get_value_callback_configuration(channel)
end

export set_all_value_callback_configuration
"""
    $(SIGNATURES)

The period is the period with which the :cb:`All Value`
callback is triggered periodically. A value of 0 turns the callback off.

If the `value has to change`-parameter is set to true, the callback is only
triggered after the value has changed. If the value didn't change within the
period, the callback is triggered immediately on change.

If it is set to false, the callback is continuously triggered with the period,
independent of the value.
"""
function set_all_value_callback_configuration(device::BrickletIndustrialDigitalIn4V2, period, value_has_to_change)
    device.deviceInternal.set_all_value_callback_configuration(period, value_has_to_change)
end

export get_all_value_callback_configuration
"""
    $(SIGNATURES)

Returns the callback configuration as set by
:func:`Set All Value Callback Configuration`.
"""
function get_all_value_callback_configuration(device::BrickletIndustrialDigitalIn4V2)
    return device.deviceInternal.get_all_value_callback_configuration()
end

export get_edge_count
"""
    $(SIGNATURES)

Returns the current value of the edge counter for the selected channel. You can
configure the edges that are counted with :func:`Set Edge Count Configuration`.

If you set the reset counter to *true*, the count is set back to 0
directly after it is read.
"""
function get_edge_count(device::BrickletIndustrialDigitalIn4V2, channel, reset_counter)
    return device.deviceInternal.get_edge_count(channel, reset_counter)
end

export set_edge_count_configuration
"""
    $(SIGNATURES)

Configures the edge counter for a specific channel.

The edge type parameter configures if rising edges, falling edges or both are
counted. Possible edge types are:

* 0 = rising
* 1 = falling
* 2 = both

Configuring an edge counter resets its value to 0.

If you don't know what any of this means, just leave it at default. The
default configuration is very likely OK for you.
"""
function set_edge_count_configuration(device::BrickletIndustrialDigitalIn4V2, channel, edge_type, debounce)
    device.deviceInternal.set_edge_count_configuration(channel, edge_type, debounce)
end

export get_edge_count_configuration
"""
    $(SIGNATURES)

Returns the edge type and debounce time for the selected channel as set by
:func:`Set Edge Count Configuration`.
"""
function get_edge_count_configuration(device::BrickletIndustrialDigitalIn4V2, channel)
    return device.deviceInternal.get_edge_count_configuration(channel)
end

export set_channel_led_config
"""
    $(SIGNATURES)

Each channel has a corresponding LED. You can turn the LED off, on or show a
heartbeat. You can also set the LED to "Channel Status". In this mode the
LED is on if the channel is high and off otherwise.

By default all channel LEDs are configured as "Channel Status".
"""
function set_channel_led_config(device::BrickletIndustrialDigitalIn4V2, channel, config)
    device.deviceInternal.set_channel_led_config(channel, config)
end

export get_channel_led_config
"""
    $(SIGNATURES)

Returns the channel LED configuration as set by :func:`Set Channel LED Config`
"""
function get_channel_led_config(device::BrickletIndustrialDigitalIn4V2, channel)
    return device.deviceInternal.get_channel_led_config(channel)
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
function get_spitfp_error_count(device::BrickletIndustrialDigitalIn4V2)
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
function set_bootloader_mode(device::BrickletIndustrialDigitalIn4V2, mode)
    return device.deviceInternal.set_bootloader_mode(mode)
end

export get_bootloader_mode
"""
    $(SIGNATURES)

Returns the current bootloader mode, see :func:`Set Bootloader Mode`.
"""
function get_bootloader_mode(device::BrickletIndustrialDigitalIn4V2)
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
function set_write_firmware_pointer(device::BrickletIndustrialDigitalIn4V2, pointer)
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
function write_firmware(device::BrickletIndustrialDigitalIn4V2, data)
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
function set_status_led_config(device::BrickletIndustrialDigitalIn4V2, config)
    device.deviceInternal.set_status_led_config(config)
end

export get_status_led_config
"""
    $(SIGNATURES)

Returns the configuration as set by :func:`Set Status LED Config`
"""
function get_status_led_config(device::BrickletIndustrialDigitalIn4V2)
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
function get_chip_temperature(device::BrickletIndustrialDigitalIn4V2)
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
function reset(device::BrickletIndustrialDigitalIn4V2)
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
function write_uid(device::BrickletIndustrialDigitalIn4V2, uid)
    device.deviceInternal.write_uid(uid)
end

export read_uid
"""
    $(SIGNATURES)

Returns the current UID as an integer. Encode as
Base58 to get the usual string version.
"""
function read_uid(device::BrickletIndustrialDigitalIn4V2)
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
function get_identity(device::BrickletIndustrialDigitalIn4V2)
    return device.deviceInternal.get_identity()
end

export register_callback
"""
Registers the given *function* with the given *callback_id*.
"""
function register_callback(device::BrickletIndustrialDigitalIn4V2, callback_id, function_)
    if isnothing(function_)
        device.registered_callbacks.pop(callback_id, None)
    else
        device.registered_callbacks[callback_id] = function_
    end
end
