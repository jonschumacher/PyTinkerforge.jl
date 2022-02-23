


export BrickletIndustrialCounterSignalData
struct BrickletIndustrialCounterSignalData
    duty_cycle::Integer
    period::Integer
    frequency::Integer
    value::Bool
end

export BrickletIndustrialCounterAllSignalData
struct BrickletIndustrialCounterAllSignalData
    duty_cycle::Vector{Integer}
    period::Vector{Integer}
    frequency::Vector{Integer}
    value::Vector{Bool}
end

export BrickletIndustrialCounterCounterConfiguration
struct BrickletIndustrialCounterCounterConfiguration
    count_edge::Integer
    count_direction::Integer
    duty_cycle_prescaler::Integer
    frequency_integration_time::Integer
end

export BrickletIndustrialCounterAllCounterCallbackConfiguration
struct BrickletIndustrialCounterAllCounterCallbackConfiguration
    period::Integer
    value_has_to_change::Bool
end

export BrickletIndustrialCounterAllSignalDataCallbackConfiguration
struct BrickletIndustrialCounterAllSignalDataCallbackConfiguration
    period::Integer
    value_has_to_change::Bool
end

export BrickletIndustrialCounterSPITFPErrorCount
struct BrickletIndustrialCounterSPITFPErrorCount
    error_count_ack_checksum::Integer
    error_count_message_checksum::Integer
    error_count_frame::Integer
    error_count_overflow::Integer
end

export BrickletIndustrialCounterIdentity
struct BrickletIndustrialCounterIdentity
    uid::String
    connected_uid::String
    position::Char
    hardware_version::Vector{Integer}
    firmware_version::Vector{Integer}
    device_identifier::Integer
end

export BrickletIndustrialCounter
"""
4 channel counter up to 4MHz
"""
mutable struct BrickletIndustrialCounter <: TinkerforgeDevice
    ipcon::IPConnection
    deviceInternal::PyObject

    """
    Creates an object with the unique device ID *uid* and adds it to
    the IP Connection *ipcon*.
    """
    function BrickletIndustrialCounter(uid::String, ipcon::IPConnection)
        package = pyimport("tinkerforge.bricklet_industrial_counter")
        deviceInternal = package.BrickletIndustrialCounter(uid, ipcon.ipconInternal)

        return new(ipcon, deviceInternal)
    end
end

export get_counter
"""
    $(SIGNATURES)

Returns the current counter value for the given channel.
"""
function get_counter(device::BrickletIndustrialCounter, channel)
    return device.deviceInternal.get_counter(channel)
end

export get_all_counter
"""
    $(SIGNATURES)

Returns the current counter values for all four channels.
"""
function get_all_counter(device::BrickletIndustrialCounter)
    return device.deviceInternal.get_all_counter()
end

export set_counter
"""
    $(SIGNATURES)

Sets the counter value for the given channel.

The default value for the counters on startup is 0.
"""
function set_counter(device::BrickletIndustrialCounter, channel, counter)
    device.deviceInternal.set_counter(channel, counter)
end

export set_all_counter
"""
    $(SIGNATURES)

Sets the counter values for all four channels.

The default value for the counters on startup is 0.
"""
function set_all_counter(device::BrickletIndustrialCounter, counter)
    device.deviceInternal.set_all_counter(counter)
end

export get_signal_data
"""
    $(SIGNATURES)

Returns the signal data (duty cycle, period, frequency and value) for the
given channel.
"""
function get_signal_data(device::BrickletIndustrialCounter, channel)
    return device.deviceInternal.get_signal_data(channel)
end

export get_all_signal_data
"""
    $(SIGNATURES)

Returns the signal data (duty cycle, period, frequency and value) for all four
channels.
"""
function get_all_signal_data(device::BrickletIndustrialCounter)
    return device.deviceInternal.get_all_signal_data()
end

export set_counter_active
"""
    $(SIGNATURES)

Activates/deactivates the counter of the given channel.

true = activate, false = deactivate.

By default all channels are activated.
"""
function set_counter_active(device::BrickletIndustrialCounter, channel, active)
    device.deviceInternal.set_counter_active(channel, active)
end

export set_all_counter_active
"""
    $(SIGNATURES)

Activates/deactivates the counter of all four channels.

true = activate, false = deactivate.

By default all channels are activated.
"""
function set_all_counter_active(device::BrickletIndustrialCounter, active)
    device.deviceInternal.set_all_counter_active(active)
end

export get_counter_active
"""
    $(SIGNATURES)

Returns the activation state of the given channel.

true = activated, false = deactivated.
"""
function get_counter_active(device::BrickletIndustrialCounter, channel)
    return device.deviceInternal.get_counter_active(channel)
end

export get_all_counter_active
"""
    $(SIGNATURES)

Returns the activation state of all four channels.

true = activated, false = deactivated.
"""
function get_all_counter_active(device::BrickletIndustrialCounter)
    return device.deviceInternal.get_all_counter_active()
end

export set_counter_configuration
"""
    $(SIGNATURES)

Sets the counter configuration for the given channel.

* Count Edge: Counter can count on rising, falling or both edges.
* Count Direction: Counter can count up or down. You can also use
  another channel as direction input, see
  `here <https://www.tinkerforge.com/en/doc/Hardware/Bricklets/Industrial_Counter.html#external-count-direction>`__
  for details.
* Duty Cycle Prescaler: Sets a divider for the internal clock. See
  `here <https://www.tinkerforge.com/en/doc/Hardware/Bricklets/Industrial_Counter.html#duty-cycle-prescaler-and-frequency-integration-time>`__
  for details.
* Frequency Integration Time: Sets the integration time for the
  frequency measurement. See
  `here <https://www.tinkerforge.com/en/doc/Hardware/Bricklets/Industrial_Counter.html#duty-cycle-prescaler-and-frequency-integration-time>`__
  for details.
"""
function set_counter_configuration(device::BrickletIndustrialCounter, channel, count_edge, count_direction, duty_cycle_prescaler, frequency_integration_time)
    device.deviceInternal.set_counter_configuration(channel, count_edge, count_direction, duty_cycle_prescaler, frequency_integration_time)
end

export get_counter_configuration
"""
    $(SIGNATURES)

Returns the counter configuration as set by :func:`Set Counter Configuration`.
"""
function get_counter_configuration(device::BrickletIndustrialCounter, channel)
    return device.deviceInternal.get_counter_configuration(channel)
end

export set_all_counter_callback_configuration
"""
    $(SIGNATURES)

The period is the period with which the :cb:`All Counter`
callback is triggered periodically. A value of 0 turns the callback off.

If the `value has to change`-parameter is set to true, the callback is only
triggered after the value has changed. If the value didn't change within the
period, the callback is triggered immediately on change.

If it is set to false, the callback is continuously triggered with the period,
independent of the value.
"""
function set_all_counter_callback_configuration(device::BrickletIndustrialCounter, period, value_has_to_change)
    device.deviceInternal.set_all_counter_callback_configuration(period, value_has_to_change)
end

export get_all_counter_callback_configuration
"""
    $(SIGNATURES)

Returns the callback configuration as set by
:func:`Set All Counter Callback Configuration`.
"""
function get_all_counter_callback_configuration(device::BrickletIndustrialCounter)
    return device.deviceInternal.get_all_counter_callback_configuration()
end

export set_all_signal_data_callback_configuration
"""
    $(SIGNATURES)

The period is the period with which the :cb:`All Signal Data`
callback is triggered periodically. A value of 0 turns the callback off.

If the `value has to change`-parameter is set to true, the callback is only
triggered after the value has changed. If the value didn't change within the
period, the callback is triggered immediately on change.

If it is set to false, the callback is continuously triggered with the period,
independent of the value.
"""
function set_all_signal_data_callback_configuration(device::BrickletIndustrialCounter, period, value_has_to_change)
    device.deviceInternal.set_all_signal_data_callback_configuration(period, value_has_to_change)
end

export get_all_signal_data_callback_configuration
"""
    $(SIGNATURES)

Returns the callback configuration as set by
:func:`Set All Signal Data Callback Configuration`.
"""
function get_all_signal_data_callback_configuration(device::BrickletIndustrialCounter)
    return device.deviceInternal.get_all_signal_data_callback_configuration()
end

export set_channel_led_config
"""
    $(SIGNATURES)

Each channel has a corresponding LED. You can turn the LED off, on or show a
heartbeat. You can also set the LED to "Channel Status". In this mode the
LED is on if the channel is high and off otherwise.
"""
function set_channel_led_config(device::BrickletIndustrialCounter, channel, config)
    device.deviceInternal.set_channel_led_config(channel, config)
end

export get_channel_led_config
"""
    $(SIGNATURES)

Returns the channel LED configuration as set by :func:`Set Channel LED Config`
"""
function get_channel_led_config(device::BrickletIndustrialCounter, channel)
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
function get_spitfp_error_count(device::BrickletIndustrialCounter)
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
function set_bootloader_mode(device::BrickletIndustrialCounter, mode)
    return device.deviceInternal.set_bootloader_mode(mode)
end

export get_bootloader_mode
"""
    $(SIGNATURES)

Returns the current bootloader mode, see :func:`Set Bootloader Mode`.
"""
function get_bootloader_mode(device::BrickletIndustrialCounter)
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
function set_write_firmware_pointer(device::BrickletIndustrialCounter, pointer)
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
function write_firmware(device::BrickletIndustrialCounter, data)
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
function set_status_led_config(device::BrickletIndustrialCounter, config)
    device.deviceInternal.set_status_led_config(config)
end

export get_status_led_config
"""
    $(SIGNATURES)

Returns the configuration as set by :func:`Set Status LED Config`
"""
function get_status_led_config(device::BrickletIndustrialCounter)
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
function get_chip_temperature(device::BrickletIndustrialCounter)
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
function reset(device::BrickletIndustrialCounter)
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
function write_uid(device::BrickletIndustrialCounter, uid)
    device.deviceInternal.write_uid(uid)
end

export read_uid
"""
    $(SIGNATURES)

Returns the current UID as an integer. Encode as
Base58 to get the usual string version.
"""
function read_uid(device::BrickletIndustrialCounter)
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
function get_identity(device::BrickletIndustrialCounter)
    return device.deviceInternal.get_identity()
end

export register_callback
"""
Registers the given *function* with the given *callback_id*.
"""
function register_callback(device::BrickletIndustrialCounter, callback_id, function_)
    if isnothing(function_)
        device.registered_callbacks.pop(callback_id, None)
    else
        device.registered_callbacks[callback_id] = function_
    end
end
