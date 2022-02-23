


export BrickletIsolatorStatistics
struct BrickletIsolatorStatistics
    messages_from_brick::Integer
    messages_from_bricklet::Integer
    connected_bricklet_device_identifier::Integer
    connected_bricklet_uid::String
end

export BrickletIsolatorSPITFPBaudrateConfig
struct BrickletIsolatorSPITFPBaudrateConfig
    enable_dynamic_baudrate::Bool
    minimum_dynamic_baudrate::Integer
end

export BrickletIsolatorIsolatorSPITFPErrorCount
struct BrickletIsolatorIsolatorSPITFPErrorCount
    error_count_ack_checksum::Integer
    error_count_message_checksum::Integer
    error_count_frame::Integer
    error_count_overflow::Integer
end

export BrickletIsolatorStatisticsCallbackConfiguration
struct BrickletIsolatorStatisticsCallbackConfiguration
    period::Integer
    value_has_to_change::Bool
end

export BrickletIsolatorSPITFPErrorCount
struct BrickletIsolatorSPITFPErrorCount
    error_count_ack_checksum::Integer
    error_count_message_checksum::Integer
    error_count_frame::Integer
    error_count_overflow::Integer
end

export BrickletIsolatorIdentity
struct BrickletIsolatorIdentity
    uid::String
    connected_uid::String
    position::Char
    hardware_version::Vector{Integer}
    firmware_version::Vector{Integer}
    device_identifier::Integer
end

export BrickletIsolator
"""
Galvanically isolates any Bricklet from any Brick
"""
mutable struct BrickletIsolator <: TinkerforgeDevice
    ipcon::IPConnection
    deviceInternal::PyObject

    """
    Creates an object with the unique device ID *uid* and adds it to
    the IP Connection *ipcon*.
    """
    function BrickletIsolator(uid::String, ipcon::IPConnection)
        package = pyimport("tinkerforge.bricklet_isolator")
        deviceInternal = package.BrickletIsolator(uid, ipcon.ipconInternal)

        return new(ipcon, deviceInternal)
    end
end

export get_statistics
"""
    $(SIGNATURES)

Returns statistics for the Isolator Bricklet.
"""
function get_statistics(device::BrickletIsolator)
    return device.deviceInternal.get_statistics()
end

export set_spitfp_baudrate_config
"""
    $(SIGNATURES)

The SPITF protocol can be used with a dynamic baudrate. If the dynamic baudrate is
enabled, the Isolator Bricklet will try to adapt the baudrate for the communication
between Bricks and Bricklets according to the amount of data that is transferred.

The baudrate for communication config between
Brick and Isolator Bricklet can be set through the API of the Brick.

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
"""
function set_spitfp_baudrate_config(device::BrickletIsolator, enable_dynamic_baudrate, minimum_dynamic_baudrate)
    device.deviceInternal.set_spitfp_baudrate_config(enable_dynamic_baudrate, minimum_dynamic_baudrate)
end

export get_spitfp_baudrate_config
"""
    $(SIGNATURES)

Returns the baudrate config, see :func:`Set SPITFP Baudrate Config`.
"""
function get_spitfp_baudrate_config(device::BrickletIsolator)
    return device.deviceInternal.get_spitfp_baudrate_config()
end

export set_spitfp_baudrate
"""
    $(SIGNATURES)

Sets the baudrate for a the communication between Isolator Bricklet
and the connected Bricklet. The baudrate for communication between
Brick and Isolator Bricklet can be set through the API of the Brick.

If you want to increase the throughput of Bricklets you can increase
the baudrate. If you get a high error count because of high
interference (see :func:`Get SPITFP Error Count`) you can decrease the
baudrate.

If the dynamic baudrate feature is enabled, the baudrate set by this
function corresponds to the maximum baudrate (see :func:`Set SPITFP Baudrate Config`).

Regulatory testing is done with the default baudrate. If CE compatibility
or similar is necessary in your applications we recommend to not change
the baudrate.
"""
function set_spitfp_baudrate(device::BrickletIsolator, baudrate)
    device.deviceInternal.set_spitfp_baudrate(baudrate)
end

export get_spitfp_baudrate
"""
    $(SIGNATURES)

Returns the baudrate, see :func:`Set SPITFP Baudrate`.
"""
function get_spitfp_baudrate(device::BrickletIsolator)
    return device.deviceInternal.get_spitfp_baudrate()
end

export get_isolator_spitfp_error_count
"""
    $(SIGNATURES)

Returns the error count for the communication between Isolator Bricklet and
the connected Bricklet. Call :func:`Get SPITFP Error Count` to get the
error count between Isolator Bricklet and Brick.

The errors are divided into

* ACK checksum errors,
* message checksum errors,
* framing errors and
* overflow errors.
"""
function get_isolator_spitfp_error_count(device::BrickletIsolator)
    return device.deviceInternal.get_isolator_spitfp_error_count()
end

export set_statistics_callback_configuration
"""
    $(SIGNATURES)

The period is the period with which the :cb:`Statistics`
callback is triggered periodically. A value of 0 turns the callback off.

If the `value has to change`-parameter is set to true, the callback is only
triggered after the value has changed. If the value didn't change within the
period, the callback is triggered immediately on change.

If it is set to false, the callback is continuously triggered with the period,
independent of the value.

.. versionadded:: 2.0.2\$nbsp;(Plugin)
"""
function set_statistics_callback_configuration(device::BrickletIsolator, period, value_has_to_change)
    device.deviceInternal.set_statistics_callback_configuration(period, value_has_to_change)
end

export get_statistics_callback_configuration
"""
    $(SIGNATURES)

Returns the callback configuration as set by
:func:`Set Statistics Callback Configuration`.

.. versionadded:: 2.0.2\$nbsp;(Plugin)
"""
function get_statistics_callback_configuration(device::BrickletIsolator)
    return device.deviceInternal.get_statistics_callback_configuration()
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
function get_spitfp_error_count(device::BrickletIsolator)
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
function set_bootloader_mode(device::BrickletIsolator, mode)
    return device.deviceInternal.set_bootloader_mode(mode)
end

export get_bootloader_mode
"""
    $(SIGNATURES)

Returns the current bootloader mode, see :func:`Set Bootloader Mode`.
"""
function get_bootloader_mode(device::BrickletIsolator)
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
function set_write_firmware_pointer(device::BrickletIsolator, pointer)
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
function write_firmware(device::BrickletIsolator, data)
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
function set_status_led_config(device::BrickletIsolator, config)
    device.deviceInternal.set_status_led_config(config)
end

export get_status_led_config
"""
    $(SIGNATURES)

Returns the configuration as set by :func:`Set Status LED Config`
"""
function get_status_led_config(device::BrickletIsolator)
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
function get_chip_temperature(device::BrickletIsolator)
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
function reset(device::BrickletIsolator)
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
function write_uid(device::BrickletIsolator, uid)
    device.deviceInternal.write_uid(uid)
end

export read_uid
"""
    $(SIGNATURES)

Returns the current UID as an integer. Encode as
Base58 to get the usual string version.
"""
function read_uid(device::BrickletIsolator)
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
function get_identity(device::BrickletIsolator)
    return device.deviceInternal.get_identity()
end

export register_callback
"""
Registers the given *function* with the given *callback_id*.
"""
function register_callback(device::BrickletIsolator, callback_id, function_)
    if isnothing(function_)
        device.registered_callbacks.pop(callback_id, None)
    else
        device.registered_callbacks[callback_id] = function_
    end
end
