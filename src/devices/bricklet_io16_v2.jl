


export BrickletIO16V2Configuration
struct BrickletIO16V2Configuration
    direction::Char
    value::Bool
end

export BrickletIO16V2InputValueCallbackConfiguration
struct BrickletIO16V2InputValueCallbackConfiguration
    period::Integer
    value_has_to_change::Bool
end

export BrickletIO16V2AllInputValueCallbackConfiguration
struct BrickletIO16V2AllInputValueCallbackConfiguration
    period::Integer
    value_has_to_change::Bool
end

export BrickletIO16V2Monoflop
struct BrickletIO16V2Monoflop
    value::Bool
    time::Integer
    time_remaining::Integer
end

export BrickletIO16V2EdgeCountConfiguration
struct BrickletIO16V2EdgeCountConfiguration
    edge_type::Integer
    debounce::Integer
end

export BrickletIO16V2SPITFPErrorCount
struct BrickletIO16V2SPITFPErrorCount
    error_count_ack_checksum::Integer
    error_count_message_checksum::Integer
    error_count_frame::Integer
    error_count_overflow::Integer
end

export BrickletIO16V2Identity
struct BrickletIO16V2Identity
    uid::String
    connected_uid::String
    position::Char
    hardware_version::Vector{Integer}
    firmware_version::Vector{Integer}
    device_identifier::Integer
end

export BrickletIO16V2
"""
16-channel digital input/output
"""
mutable struct BrickletIO16V2 <: TinkerforgeDevice
    ipcon::IPConnection
    deviceInternal::PyObject

    """
    Creates an object with the unique device ID *uid* and adds it to
    the IP Connection *ipcon*.
    """
    function BrickletIO16V2(uid::String, ipcon::IPConnection)
        package = pyimport("tinkerforge.bricklet_io16_v2")
        deviceInternal = package.BrickletIO16V2(uid, ipcon.ipconInternal)

        return new(ipcon, deviceInternal)
    end
end

export set_value
"""
    $(SIGNATURES)

Sets the output value of all sixteen channels. A value of *true* or *false* outputs
logic 1 or logic 0 respectively on the corresponding channel.

Use :func:`Set Selected Value` to change only one output channel state.

For example: (True, True, False, False, ..., False) will turn the channels 0-1
high and the channels 2-15 low.

All running monoflop timers will be aborted if this function is called.

.. note::
 This function does nothing for channels that are configured as input. Pull-up
 resistors can be switched on with :func:`Set Configuration`.
"""
function set_value(device::BrickletIO16V2, value)
    device.deviceInternal.set_value(value)
end

export get_value
"""
    $(SIGNATURES)

Returns the logic levels that are currently measured on the channels.
This function works if the channel is configured as input as well as if it is
configured as output.
"""
function get_value(device::BrickletIO16V2)
    return device.deviceInternal.get_value()
end

export set_selected_value
"""
    $(SIGNATURES)

Sets the output value of a specific channel without affecting the other channels.

A running monoflop timer for the specific channel will be aborted if this
function is called.

.. note::
 This function does nothing for channels that are configured as input. Pull-up
 resistors can be switched on with :func:`Set Configuration`.
"""
function set_selected_value(device::BrickletIO16V2, channel, value)
    device.deviceInternal.set_selected_value(channel, value)
end

export set_configuration
"""
    $(SIGNATURES)

Configures the value and direction of a specific channel. Possible directions
are 'i' and 'o' for input and output.

If the direction is configured as output, the value is either high or low
(set as *true* or *false*).

If the direction is configured as input, the value is either pull-up or
default (set as *true* or *false*).

For example:

* (0, 'i', true) will set channel-0 as input pull-up.
* (1, 'i', false) will set channel-1 as input default (floating if nothing is connected).
* (2, 'o', true) will set channel-2 as output high.
* (3, 'o', false) will set channel-3 as output low.

A running monoflop timer for the specific channel will be aborted if this
function is called.
"""
function set_configuration(device::BrickletIO16V2, channel, direction, value)
    device.deviceInternal.set_configuration(channel, direction, value)
end

export get_configuration
"""
    $(SIGNATURES)

Returns the channel configuration as set by :func:`Set Configuration`.
"""
function get_configuration(device::BrickletIO16V2, channel)
    return device.deviceInternal.get_configuration(channel)
end

export set_input_value_callback_configuration
"""
    $(SIGNATURES)

This callback can be configured per channel.

The period is the period with which the :cb:`Input Value`
callback is triggered periodically. A value of 0 turns the callback off.

If the `value has to change`-parameter is set to true, the callback is only
triggered after the value has changed. If the value didn't change within the
period, the callback is triggered immediately on change.

If it is set to false, the callback is continuously triggered with the period,
independent of the value.
"""
function set_input_value_callback_configuration(device::BrickletIO16V2, channel, period, value_has_to_change)
    device.deviceInternal.set_input_value_callback_configuration(channel, period, value_has_to_change)
end

export get_input_value_callback_configuration
"""
    $(SIGNATURES)

Returns the callback configuration as set by
:func:`Set Input Value Callback Configuration`.
"""
function get_input_value_callback_configuration(device::BrickletIO16V2, channel)
    return device.deviceInternal.get_input_value_callback_configuration(channel)
end

export set_all_input_value_callback_configuration
"""
    $(SIGNATURES)

The period is the period with which the :cb:`All Input Value`
callback is triggered periodically. A value of 0 turns the callback off.

If the `value has to change`-parameter is set to true, the callback is only
triggered after the value has changed. If the value didn't change within the
period, the callback is triggered immediately on change.

If it is set to false, the callback is continuously triggered with the period,
independent of the value.
"""
function set_all_input_value_callback_configuration(device::BrickletIO16V2, period, value_has_to_change)
    device.deviceInternal.set_all_input_value_callback_configuration(period, value_has_to_change)
end

export get_all_input_value_callback_configuration
"""
    $(SIGNATURES)

Returns the callback configuration as set by
:func:`Set All Input Value Callback Configuration`.
"""
function get_all_input_value_callback_configuration(device::BrickletIO16V2)
    return device.deviceInternal.get_all_input_value_callback_configuration()
end

export set_monoflop
"""
    $(SIGNATURES)

Configures a monoflop of the specified channel.

The second parameter is the desired value of the specified
channel. A *true* means relay closed and a *false* means relay open.

The third parameter indicates the time that the channels should hold
the value.

If this function is called with the parameters (0, 1, 1500) channel 0 will
close and in 1.5s channel 0 will open again

A monoflop can be used as a fail-safe mechanism. For example: Lets assume you
have a RS485 bus and a IO-16 Bricklet 2.0 connected to one of
the slave stacks. You can now call this function every second, with a time
parameter of two seconds and channel 0 closed. Channel 0 will be closed all the
time. If now the RS485 connection is lost, then channel 0 will be opened in at
most two seconds.
"""
function set_monoflop(device::BrickletIO16V2, channel, value, time)
    device.deviceInternal.set_monoflop(channel, value, time)
end

export get_monoflop
"""
    $(SIGNATURES)

Returns (for the given channel) the current value and the time as set by
:func:`Set Monoflop` as well as the remaining time until the value flips.

If the timer is not running currently, the remaining time will be returned
as 0.
"""
function get_monoflop(device::BrickletIO16V2, channel)
    return device.deviceInternal.get_monoflop(channel)
end

export get_edge_count
"""
    $(SIGNATURES)

Returns the current value of the edge counter for the selected channel. You can
configure the edges that are counted with :func:`Set Edge Count Configuration`.

If you set the reset counter to *true*, the count is set back to 0
directly after it is read.
"""
function get_edge_count(device::BrickletIO16V2, channel, reset_counter)
    return device.deviceInternal.get_edge_count(channel, reset_counter)
end

export set_edge_count_configuration
"""
    $(SIGNATURES)

Configures the edge counter for a specific channel.

The edge type parameter configures if rising edges, falling edges or
both are counted if the channel is configured for input. Possible edge types are:

* 0 = rising
* 1 = falling
* 2 = both

Configuring an edge counter resets its value to 0.

If you don't know what any of this means, just leave it at default. The
default configuration is very likely OK for you.
"""
function set_edge_count_configuration(device::BrickletIO16V2, channel, edge_type, debounce)
    device.deviceInternal.set_edge_count_configuration(channel, edge_type, debounce)
end

export get_edge_count_configuration
"""
    $(SIGNATURES)

Returns the edge type and debounce time for the selected channel as set by
:func:`Set Edge Count Configuration`.
"""
function get_edge_count_configuration(device::BrickletIO16V2, channel)
    return device.deviceInternal.get_edge_count_configuration(channel)
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
function get_spitfp_error_count(device::BrickletIO16V2)
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
function set_bootloader_mode(device::BrickletIO16V2, mode)
    return device.deviceInternal.set_bootloader_mode(mode)
end

export get_bootloader_mode
"""
    $(SIGNATURES)

Returns the current bootloader mode, see :func:`Set Bootloader Mode`.
"""
function get_bootloader_mode(device::BrickletIO16V2)
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
function set_write_firmware_pointer(device::BrickletIO16V2, pointer)
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
function write_firmware(device::BrickletIO16V2, data)
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
function set_status_led_config(device::BrickletIO16V2, config)
    device.deviceInternal.set_status_led_config(config)
end

export get_status_led_config
"""
    $(SIGNATURES)

Returns the configuration as set by :func:`Set Status LED Config`
"""
function get_status_led_config(device::BrickletIO16V2)
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
function get_chip_temperature(device::BrickletIO16V2)
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
function reset(device::BrickletIO16V2)
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
function write_uid(device::BrickletIO16V2, uid)
    device.deviceInternal.write_uid(uid)
end

export read_uid
"""
    $(SIGNATURES)

Returns the current UID as an integer. Encode as
Base58 to get the usual string version.
"""
function read_uid(device::BrickletIO16V2)
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
function get_identity(device::BrickletIO16V2)
    return device.deviceInternal.get_identity()
end

export register_callback
"""
Registers the given *function* with the given *callback_id*.
"""
function register_callback(device::BrickletIO16V2, callback_id, function_)
    if isnothing(function_)
        device.registered_callbacks.pop(callback_id, None)
    else
        device.registered_callbacks[callback_id] = function_
    end
end
