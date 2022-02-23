


export BrickletRealTimeClockDateTime
struct BrickletRealTimeClockDateTime
    year::Integer
    month::Integer
    day::Integer
    hour::Integer
    minute::Integer
    second::Integer
    centisecond::Integer
    weekday::Integer
end

export BrickletRealTimeClockAlarm
struct BrickletRealTimeClockAlarm
    month::Integer
    day::Integer
    hour::Integer
    minute::Integer
    second::Integer
    weekday::Integer
    interval::Integer
end

export BrickletRealTimeClockIdentity
struct BrickletRealTimeClockIdentity
    uid::String
    connected_uid::String
    position::Char
    hardware_version::Vector{Integer}
    firmware_version::Vector{Integer}
    device_identifier::Integer
end

export BrickletRealTimeClock
"""
Battery-backed real-time clock
"""
mutable struct BrickletRealTimeClock <: TinkerforgeDevice
    ipcon::IPConnection
    deviceInternal::PyObject

    """
    Creates an object with the unique device ID *uid* and adds it to
    the IP Connection *ipcon*.
    """
    function BrickletRealTimeClock(uid::String, ipcon::IPConnection)
        package = pyimport("tinkerforge.bricklet_real_time_clock")
        deviceInternal = package.BrickletRealTimeClock(uid, ipcon.ipconInternal)

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
function set_date_time(device::BrickletRealTimeClock, year, month, day, hour, minute, second, centisecond, weekday)
    device.deviceInternal.set_date_time(year, month, day, hour, minute, second, centisecond, weekday)
end

export get_date_time
"""
    $(SIGNATURES)

Returns the current date (including weekday) and the current time of the
real-time clock.
"""
function get_date_time(device::BrickletRealTimeClock)
    return device.deviceInternal.get_date_time()
end

export get_timestamp
"""
    $(SIGNATURES)

Returns the current date and the time of the real-time clock.
The timestamp has an effective resolution of hundredths of a
second and is an offset to 2000-01-01 00:00:00.000.
"""
function get_timestamp(device::BrickletRealTimeClock)
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
function set_offset(device::BrickletRealTimeClock, offset)
    device.deviceInternal.set_offset(offset)
end

export get_offset
"""
    $(SIGNATURES)

Returns the offset as set by :func:`Set Offset`.
"""
function get_offset(device::BrickletRealTimeClock)
    return device.deviceInternal.get_offset()
end

export set_date_time_callback_period
"""
    $(SIGNATURES)

Sets the period with which the :cb:`Date Time` callback is triggered
periodically. A value of 0 turns the callback off.

The :cb:`Date Time` Callback is only triggered if the date or time changed
since the last triggering.

.. versionadded:: 2.0.1\$nbsp;(Plugin)
"""
function set_date_time_callback_period(device::BrickletRealTimeClock, period)
    device.deviceInternal.set_date_time_callback_period(period)
end

export get_date_time_callback_period
"""
    $(SIGNATURES)

Returns the period as set by :func:`Set Date Time Callback Period`.

.. versionadded:: 2.0.1\$nbsp;(Plugin)
"""
function get_date_time_callback_period(device::BrickletRealTimeClock)
    return device.deviceInternal.get_date_time_callback_period()
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

.. versionadded:: 2.0.1\$nbsp;(Plugin)
"""
function set_alarm(device::BrickletRealTimeClock, month, day, hour, minute, second, weekday, interval)
    device.deviceInternal.set_alarm(month, day, hour, minute, second, weekday, interval)
end

export get_alarm
"""
    $(SIGNATURES)

Returns the alarm configuration as set by :func:`Set Alarm`.

.. versionadded:: 2.0.1\$nbsp;(Plugin)
"""
function get_alarm(device::BrickletRealTimeClock)
    return device.deviceInternal.get_alarm()
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
function get_identity(device::BrickletRealTimeClock)
    return device.deviceInternal.get_identity()
end

export register_callback
"""
Registers the given *function* with the given *callback_id*.
"""
function register_callback(device::BrickletRealTimeClock, callback_id, function_)
    if isnothing(function_)
        device.registered_callbacks.pop(callback_id, None)
    else
        device.registered_callbacks[callback_id] = function_
    end
end
