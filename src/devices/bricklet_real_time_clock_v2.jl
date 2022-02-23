


export BrickletRealTimeClockV2DateTime
struct BrickletRealTimeClockV2DateTime
    year::Integer
    month::Integer
    day::Integer
    hour::Integer
    minute::Integer
    second::Integer
    centisecond::Integer
    weekday::Integer
    timestamp::Integer
end

export BrickletRealTimeClockV2Alarm
struct BrickletRealTimeClockV2Alarm
    month::Integer
    day::Integer
    hour::Integer
    minute::Integer
    second::Integer
    weekday::Integer
    interval::Integer
end

export BrickletRealTimeClockV2SPITFPErrorCount
struct BrickletRealTimeClockV2SPITFPErrorCount
    error_count_ack_checksum::Integer
    error_count_message_checksum::Integer
    error_count_frame::Integer
    error_count_overflow::Integer
end

export BrickletRealTimeClockV2Identity
struct BrickletRealTimeClockV2Identity
    uid::String
    connected_uid::String
    position::Char
    hardware_version::Vector{Integer}
    firmware_version::Vector{Integer}
    device_identifier::Integer
end

export BrickletRealTimeClockV2
"""
Battery-backed real-time clock
"""
mutable struct BrickletRealTimeClockV2 <: TinkerforgeDevice
    ipcon::IPConnection
    deviceInternal::PyObject

    """
    Creates an object with the unique device ID *uid* and adds it to
    the IP Connection *ipcon*.
    """
    function BrickletRealTimeClockV2(uid::String, ipcon::IPConnection)
        package = pyimport("tinkerforge.bricklet_real_time_clock_v2")
        deviceInternal = package.BrickletRealTimeClockV2(uid, ipcon.ipconInternal)

        return new(ipcon, deviceInternal)
    end
end

export set_date_time
"""
    $(SIGNATURES)

Sets the current date (including weekday) and the current time.

If the backup battery is installed then the real-time clock keeps date and
time even if the Bricklet is not powered by a Brick.

The real-time clock handles leap year and inserts the 29th of February
accordingly. But leap seconds, time zones and daylight saving time are not
handled.
"""
function set_date_time(device::BrickletRealTimeClockV2, year, month, day, hour, minute, second, centisecond, weekday)
    device.deviceInternal.set_date_time(year, month, day, hour, minute, second, centisecond, weekday)
end

export get_date_time
"""
    $(SIGNATURES)

Returns the current date (including weekday) and the current time of the
real-time.

The timestamp represents the current date and the the current time of the
real-time clock converted to milliseconds and is an offset to 2000-01-01 00:00:00.0000.
"""
function get_date_time(device::BrickletRealTimeClockV2)
    return device.deviceInternal.get_date_time()
end

export get_timestamp
"""
    $(SIGNATURES)

Returns the current date and the time of the real-time clock converted to
milliseconds. The timestamp has an effective resolution of hundredths of a
second and is an offset to 2000-01-01 00:00:00.0000.
"""
function get_timestamp(device::BrickletRealTimeClockV2)
    return device.deviceInternal.get_timestamp()
end

export set_offset
"""
    $(SIGNATURES)

Sets the offset the real-time clock should compensate for in 2.17 ppm steps
between -277.76 ppm (-128) and +275.59 ppm (127).

The real-time clock time can deviate from the actual time due to the frequency
deviation of its 32.768 kHz crystal. Even without compensation (factory
default) the resulting time deviation should be at most ±20 ppm (±52.6
seconds per month).

This deviation can be calculated by comparing the same duration measured by the
real-time clock (``rtc_duration``) an accurate reference clock
(``ref_duration``).

For best results the configured offset should be set to 0 ppm first and then a
duration of at least 6 hours should be measured.

The new offset (``new_offset``) can be calculated from the currently configured
offset (``current_offset``) and the measured durations as follow::

  new_offset = current_offset - round(1000000 * (rtc_duration - ref_duration) / rtc_duration / 2.17)

If you want to calculate the offset, then we recommend using the calibration
dialog in Brick Viewer, instead of doing it manually.

The offset is saved in the EEPROM of the Bricklet and only needs to be
configured once.
"""
function set_offset(device::BrickletRealTimeClockV2, offset)
    device.deviceInternal.set_offset(offset)
end

export get_offset
"""
    $(SIGNATURES)

Returns the offset as set by :func:`Set Offset`.
"""
function get_offset(device::BrickletRealTimeClockV2)
    return device.deviceInternal.get_offset()
end

export set_date_time_callback_configuration
"""
    $(SIGNATURES)

Sets the period with which the :cb:`Date Time` callback is triggered
periodically. A value of 0 turns the callback off.
"""
function set_date_time_callback_configuration(device::BrickletRealTimeClockV2, period)
    device.deviceInternal.set_date_time_callback_configuration(period)
end

export get_date_time_callback_configuration
"""
    $(SIGNATURES)

Returns the period as set by :func:`Set Date Time Callback Configuration`.
"""
function get_date_time_callback_configuration(device::BrickletRealTimeClockV2)
    return device.deviceInternal.get_date_time_callback_configuration()
end

export set_alarm
"""
    $(SIGNATURES)

Configures a repeatable alarm. The :cb:`Alarm` callback is triggered if the
current date and time matches the configured alarm.

Setting a parameter to -1 means that it should be disabled and doesn't take part
in the match. Setting all parameters to -1 disables the alarm completely.

For example, to make the alarm trigger every day at 7:30 AM it can be
configured as (-1, -1, 7, 30, -1, -1, -1). The hour is set to match 7 and the
minute is set to match 30. The alarm is triggered if all enabled parameters
match.

The interval has a special role. It allows to make the alarm reconfigure itself.
This is useful if you need a repeated alarm that cannot be expressed by matching
the current date and time. For example, to make the alarm trigger every 23
seconds it can be configured as (-1, -1, -1, -1, -1, -1, 23). Internally the
Bricklet will take the current date and time, add 23 seconds to it and set the
result as its alarm. The first alarm will be triggered 23 seconds after the
call. Because the interval is not -1, the Bricklet will do the same again
internally, take the current date and time, add 23 seconds to it and set that
as its alarm. This results in a repeated alarm that triggers every 23 seconds.

The interval can also be used in combination with the other parameters. For
example, configuring the alarm as (-1, -1, 7, 30, -1, -1, 300) results in an
alarm that triggers every day at 7:30 AM and is then repeated every 5 minutes.
"""
function set_alarm(device::BrickletRealTimeClockV2, month, day, hour, minute, second, weekday, interval)
    device.deviceInternal.set_alarm(month, day, hour, minute, second, weekday, interval)
end

export get_alarm
"""
    $(SIGNATURES)

Returns the alarm configuration as set by :func:`Set Alarm`.
"""
function get_alarm(device::BrickletRealTimeClockV2)
    return device.deviceInternal.get_alarm()
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
function get_spitfp_error_count(device::BrickletRealTimeClockV2)
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
function set_bootloader_mode(device::BrickletRealTimeClockV2, mode)
    return device.deviceInternal.set_bootloader_mode(mode)
end

export get_bootloader_mode
"""
    $(SIGNATURES)

Returns the current bootloader mode, see :func:`Set Bootloader Mode`.
"""
function get_bootloader_mode(device::BrickletRealTimeClockV2)
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
function set_write_firmware_pointer(device::BrickletRealTimeClockV2, pointer)
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
function write_firmware(device::BrickletRealTimeClockV2, data)
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
function set_status_led_config(device::BrickletRealTimeClockV2, config)
    device.deviceInternal.set_status_led_config(config)
end

export get_status_led_config
"""
    $(SIGNATURES)

Returns the configuration as set by :func:`Set Status LED Config`
"""
function get_status_led_config(device::BrickletRealTimeClockV2)
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
function get_chip_temperature(device::BrickletRealTimeClockV2)
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
function reset(device::BrickletRealTimeClockV2)
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
function write_uid(device::BrickletRealTimeClockV2, uid)
    device.deviceInternal.write_uid(uid)
end

export read_uid
"""
    $(SIGNATURES)

Returns the current UID as an integer. Encode as
Base58 to get the usual string version.
"""
function read_uid(device::BrickletRealTimeClockV2)
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
function get_identity(device::BrickletRealTimeClockV2)
    return device.deviceInternal.get_identity()
end

export register_callback
"""
Registers the given *function* with the given *callback_id*.
"""
function register_callback(device::BrickletRealTimeClockV2, callback_id, function_)
    if isnothing(function_)
        device.registered_callbacks.pop(callback_id, None)
    else
        device.registered_callbacks[callback_id] = function_
    end
end
