


export BrickletIndustrialDigitalOut4V2Monoflop
struct BrickletIndustrialDigitalOut4V2Monoflop
    value::Bool
    time::Integer
    time_remaining::Integer
end

export BrickletIndustrialDigitalOut4V2PWMConfiguration
struct BrickletIndustrialDigitalOut4V2PWMConfiguration
    frequency::Integer
    duty_cycle::Integer
end

export BrickletIndustrialDigitalOut4V2SPITFPErrorCount
struct BrickletIndustrialDigitalOut4V2SPITFPErrorCount
    error_count_ack_checksum::Integer
    error_count_message_checksum::Integer
    error_count_frame::Integer
    error_count_overflow::Integer
end

export BrickletIndustrialDigitalOut4V2Identity
struct BrickletIndustrialDigitalOut4V2Identity
    uid::String
    connected_uid::String
    position::Char
    hardware_version::Vector{Integer}
    firmware_version::Vector{Integer}
    device_identifier::Integer
end

export BrickletIndustrialDigitalOut4V2
"""
4 galvanically isolated digital outputs
"""
mutable struct BrickletIndustrialDigitalOut4V2 <: TinkerforgeDevice
    ipcon::IPConnection
    deviceInternal::PyObject

    """
    Creates an object with the unique device ID *uid* and adds it to
    the IP Connection *ipcon*.
    """
    function BrickletIndustrialDigitalOut4V2(uid::String, ipcon::IPConnection)
        package = pyimport("tinkerforge.bricklet_industrial_digital_out_4_v2")
        deviceInternal = package.BrickletIndustrialDigitalOut4V2(uid, ipcon.ipconInternal)

        return new(ipcon, deviceInternal)
    end
end

export set_value
"""
    $(SIGNATURES)

Sets the output value of all four channels. A value of *true* or *false* outputs
logic 1 or logic 0 respectively on the corresponding channel.

Use :func:`Set Selected Value` to change only one output channel state.

All running monoflop timers and PWMs will be aborted if this function is called.

For example: (True, True, False, False) will turn the channels 0-1 high and the
channels 2-3 low.
"""
function set_value(device::BrickletIndustrialDigitalOut4V2, value)
    device.deviceInternal.set_value(value)
end

export get_value
"""
    $(SIGNATURES)

Returns the logic levels that are currently output on the channels.
"""
function get_value(device::BrickletIndustrialDigitalOut4V2)
    return device.deviceInternal.get_value()
end

export set_selected_value
"""
    $(SIGNATURES)

Sets the output value of a specific channel without affecting the other channels.

A running monoflop timer or PWM for the specified channel will be aborted if this
function is called.
"""
function set_selected_value(device::BrickletIndustrialDigitalOut4V2, channel, value)
    device.deviceInternal.set_selected_value(channel, value)
end

export set_monoflop
"""
    $(SIGNATURES)

The first parameter is the desired state of the channel (*true* means output *high*
and *false* means output *low*). The second parameter indicates the time that
the channel should hold the state.

If this function is called with the parameters (true, 1500):
The channel will turn on and in 1.5s it will turn off again.

A PWM for the selected channel will be aborted if this function is called.

A monoflop can be used as a failsafe mechanism. For example: Lets assume you
have a RS485 bus and a IO-4 Bricklet is connected to one of the slave
stacks. You can now call this function every second, with a time parameter
of two seconds. The channel will be *high* all the time. If now the RS485
connection is lost, the channel will turn *low* in at most two seconds.
"""
function set_monoflop(device::BrickletIndustrialDigitalOut4V2, channel, value, time)
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
function get_monoflop(device::BrickletIndustrialDigitalOut4V2, channel)
    return device.deviceInternal.get_monoflop(channel)
end

export set_channel_led_config
"""
    $(SIGNATURES)

Each channel has a corresponding LED. You can turn the LED off, on or show a
heartbeat. You can also set the LED to "Channel Status". In this mode the
LED is on if the channel is high and off otherwise.

By default all channel LEDs are configured as "Channel Status".
"""
function set_channel_led_config(device::BrickletIndustrialDigitalOut4V2, channel, config)
    device.deviceInternal.set_channel_led_config(channel, config)
end

export get_channel_led_config
"""
    $(SIGNATURES)

Returns the channel LED configuration as set by :func:`Set Channel LED Config`
"""
function get_channel_led_config(device::BrickletIndustrialDigitalOut4V2, channel)
    return device.deviceInternal.get_channel_led_config(channel)
end

export set_pwm_configuration
"""
    $(SIGNATURES)

Activates a PWM for the given channel.

To turn the PWM off again, you can set the frequency to 0 or any other
function that changes a value of the channel (e.g. :func:`Set Selected Value`).

The optocoupler of the Industrial Digital
Out 4 Bricklet 2.0 has a rise time and fall time of 11.5us (each) at 24V. So the maximum
useful frequency value is about 400000 (40kHz).

A running monoflop timer for the given channel will be aborted if this function
is called.
"""
function set_pwm_configuration(device::BrickletIndustrialDigitalOut4V2, channel, frequency, duty_cycle)
    device.deviceInternal.set_pwm_configuration(channel, frequency, duty_cycle)
end

export get_pwm_configuration
"""
    $(SIGNATURES)

Returns the PWM configuration as set by :func:`Set PWM Configuration`.
"""
function get_pwm_configuration(device::BrickletIndustrialDigitalOut4V2, channel)
    return device.deviceInternal.get_pwm_configuration(channel)
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
function get_spitfp_error_count(device::BrickletIndustrialDigitalOut4V2)
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
function set_bootloader_mode(device::BrickletIndustrialDigitalOut4V2, mode)
    return device.deviceInternal.set_bootloader_mode(mode)
end

export get_bootloader_mode
"""
    $(SIGNATURES)

Returns the current bootloader mode, see :func:`Set Bootloader Mode`.
"""
function get_bootloader_mode(device::BrickletIndustrialDigitalOut4V2)
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
function set_write_firmware_pointer(device::BrickletIndustrialDigitalOut4V2, pointer)
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
function write_firmware(device::BrickletIndustrialDigitalOut4V2, data)
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
function set_status_led_config(device::BrickletIndustrialDigitalOut4V2, config)
    device.deviceInternal.set_status_led_config(config)
end

export get_status_led_config
"""
    $(SIGNATURES)

Returns the configuration as set by :func:`Set Status LED Config`
"""
function get_status_led_config(device::BrickletIndustrialDigitalOut4V2)
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
function get_chip_temperature(device::BrickletIndustrialDigitalOut4V2)
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
function reset(device::BrickletIndustrialDigitalOut4V2)
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
function write_uid(device::BrickletIndustrialDigitalOut4V2, uid)
    device.deviceInternal.write_uid(uid)
end

export read_uid
"""
    $(SIGNATURES)

Returns the current UID as an integer. Encode as
Base58 to get the usual string version.
"""
function read_uid(device::BrickletIndustrialDigitalOut4V2)
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
function get_identity(device::BrickletIndustrialDigitalOut4V2)
    return device.deviceInternal.get_identity()
end

export register_callback
"""
Registers the given *function* with the given *callback_id*.
"""
function register_callback(device::BrickletIndustrialDigitalOut4V2, callback_id, function_)
    if isnothing(function_)
        device.registered_callbacks.pop(callback_id, None)
    else
        device.registered_callbacks[callback_id] = function_
    end
end
