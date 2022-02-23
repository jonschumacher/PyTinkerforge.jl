


export BrickletGPSCoordinates
struct BrickletGPSCoordinates
    latitude::Integer
    ns::Char
    longitude::Integer
    ew::Char
    pdop::Integer
    hdop::Integer
    vdop::Integer
    epe::Integer
end

export BrickletGPSStatus
struct BrickletGPSStatus
    fix::Integer
    satellites_view::Integer
    satellites_used::Integer
end

export BrickletGPSAltitude
struct BrickletGPSAltitude
    altitude::Integer
    geoidal_separation::Integer
end

export BrickletGPSMotion
struct BrickletGPSMotion
    course::Integer
    speed::Integer
end

export BrickletGPSDateTime
struct BrickletGPSDateTime
    date::Integer
    time::Integer
end

export BrickletGPSIdentity
struct BrickletGPSIdentity
    uid::String
    connected_uid::String
    position::Char
    hardware_version::Vector{Integer}
    firmware_version::Vector{Integer}
    device_identifier::Integer
end

export BrickletGPS
"""
Determine position, velocity and altitude using GPS
"""
mutable struct BrickletGPS <: TinkerforgeDevice
    ipcon::IPConnection
    deviceInternal::PyObject

    """
    Creates an object with the unique device ID *uid* and adds it to
    the IP Connection *ipcon*.
    """
    function BrickletGPS(uid::String, ipcon::IPConnection)
        package = pyimport("tinkerforge.bricklet_gps")
        deviceInternal = package.BrickletGPS(uid, ipcon.ipconInternal)

        return new(ipcon, deviceInternal)
    end
end

export get_coordinates
"""
    $(SIGNATURES)

Returns the GPS coordinates. Latitude and longitude are given in the
``DD.dddddd°`` format, the value 57123468 means 57.123468°.
The parameter ``ns`` and ``ew`` are the cardinal directions for
latitude and longitude. Possible values for ``ns`` and ``ew`` are 'N', 'S', 'E'
and 'W' (north, south, east and west).

PDOP, HDOP and VDOP are the dilution of precision (DOP) values. They specify
the additional multiplicative effect of GPS satellite geometry on GPS
precision. See
`here <https://en.wikipedia.org/wiki/Dilution_of_precision_(GPS)>`__
for more information.

EPE is the "Estimated Position Error". This is not the
absolute maximum error, it is the error with a specific confidence. See
`here <https://www.nps.gov/gis/gps/WhatisEPE.html>`__ for more information.

This data is only valid if there is currently a fix as indicated by
:func:`Get Status`.
"""
function get_coordinates(device::BrickletGPS)
    return device.deviceInternal.get_coordinates()
end

export get_status
"""
    $(SIGNATURES)

Returns the current fix status, the number of satellites that are in view and
the number of satellites that are currently used.

Possible fix status values can be:

.. csv-table::
 :header: "Value", "Description"
 :widths: 10, 100

 "1", "No Fix, :func:`Get Coordinates`, :func:`Get Altitude` and :func:`Get Motion` return invalid data"
 "2", "2D Fix, only :func:`Get Coordinates` and :func:`Get Motion` return valid data"
 "3", "3D Fix, :func:`Get Coordinates`, :func:`Get Altitude` and :func:`Get Motion` return valid data"

There is also a :ref:`blue LED <gps_bricklet_fix_led>` on the Bricklet that
indicates the fix status.
"""
function get_status(device::BrickletGPS)
    return device.deviceInternal.get_status()
end

export get_altitude
"""
    $(SIGNATURES)

Returns the current altitude and corresponding geoidal separation.

This data is only valid if there is currently a fix as indicated by
:func:`Get Status`.
"""
function get_altitude(device::BrickletGPS)
    return device.deviceInternal.get_altitude()
end

export get_motion
"""
    $(SIGNATURES)

Returns the current course and speed. A course of 0° means the Bricklet is
traveling north bound and 90° means it is traveling east bound.

Please note that this only returns useful values if an actual movement
is present.

This data is only valid if there is currently a fix as indicated by
:func:`Get Status`.
"""
function get_motion(device::BrickletGPS)
    return device.deviceInternal.get_motion()
end

export get_date_time
"""
    $(SIGNATURES)

Returns the current date and time. The date is
given in the format ``ddmmyy`` and the time is given
in the format ``hhmmss.sss``. For example, 140713 means
14.07.13 as date and 195923568 means 19:59:23.568 as time.
"""
function get_date_time(device::BrickletGPS)
    return device.deviceInternal.get_date_time()
end

export restart
"""
    $(SIGNATURES)

Restarts the GPS Bricklet, the following restart types are available:

.. csv-table::
 :header: "Value", "Description"
 :widths: 10, 100

 "0", "Hot start (use all available data in the NV store)"
 "1", "Warm start (don't use ephemeris at restart)"
 "2", "Cold start (don't use time, position, almanacs and ephemeris at restart)"
 "3", "Factory reset (clear all system/user configurations at restart)"
"""
function restart(device::BrickletGPS, restart_type)
    device.deviceInternal.restart(restart_type)
end

export set_coordinates_callback_period
"""
    $(SIGNATURES)

Sets the period with which the :cb:`Coordinates` callback is triggered
periodically. A value of 0 turns the callback off.

The :cb:`Coordinates` callback is only triggered if the coordinates changed
since the last triggering.
"""
function set_coordinates_callback_period(device::BrickletGPS, period)
    device.deviceInternal.set_coordinates_callback_period(period)
end

export get_coordinates_callback_period
"""
    $(SIGNATURES)

Returns the period as set by :func:`Set Coordinates Callback Period`.
"""
function get_coordinates_callback_period(device::BrickletGPS)
    return device.deviceInternal.get_coordinates_callback_period()
end

export set_status_callback_period
"""
    $(SIGNATURES)

Sets the period with which the :cb:`Status` callback is triggered
periodically. A value of 0 turns the callback off.

The :cb:`Status` callback is only triggered if the status changed since the
last triggering.
"""
function set_status_callback_period(device::BrickletGPS, period)
    device.deviceInternal.set_status_callback_period(period)
end

export get_status_callback_period
"""
    $(SIGNATURES)

Returns the period as set by :func:`Set Status Callback Period`.
"""
function get_status_callback_period(device::BrickletGPS)
    return device.deviceInternal.get_status_callback_period()
end

export set_altitude_callback_period
"""
    $(SIGNATURES)

Sets the period with which the :cb:`Altitude` callback is triggered
periodically. A value of 0 turns the callback off.

The :cb:`Altitude` callback is only triggered if the altitude changed since
the last triggering.
"""
function set_altitude_callback_period(device::BrickletGPS, period)
    device.deviceInternal.set_altitude_callback_period(period)
end

export get_altitude_callback_period
"""
    $(SIGNATURES)

Returns the period as set by :func:`Set Altitude Callback Period`.
"""
function get_altitude_callback_period(device::BrickletGPS)
    return device.deviceInternal.get_altitude_callback_period()
end

export set_motion_callback_period
"""
    $(SIGNATURES)

Sets the period with which the :cb:`Motion` callback is triggered
periodically. A value of 0 turns the callback off.

The :cb:`Motion` callback is only triggered if the motion changed since the
last triggering.
"""
function set_motion_callback_period(device::BrickletGPS, period)
    device.deviceInternal.set_motion_callback_period(period)
end

export get_motion_callback_period
"""
    $(SIGNATURES)

Returns the period as set by :func:`Set Motion Callback Period`.
"""
function get_motion_callback_period(device::BrickletGPS)
    return device.deviceInternal.get_motion_callback_period()
end

export set_date_time_callback_period
"""
    $(SIGNATURES)

Sets the period with which the :cb:`Date Time` callback is triggered
periodically. A value of 0 turns the callback off.

The :cb:`Date Time` callback is only triggered if the date or time changed
since the last triggering.
"""
function set_date_time_callback_period(device::BrickletGPS, period)
    device.deviceInternal.set_date_time_callback_period(period)
end

export get_date_time_callback_period
"""
    $(SIGNATURES)

Returns the period as set by :func:`Set Date Time Callback Period`.
"""
function get_date_time_callback_period(device::BrickletGPS)
    return device.deviceInternal.get_date_time_callback_period()
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
function get_identity(device::BrickletGPS)
    return device.deviceInternal.get_identity()
end

export register_callback
"""
Registers the given *function* with the given *callback_id*.
"""
function register_callback(device::BrickletGPS, callback_id, function_)
    if isnothing(function_)
        device.registered_callbacks.pop(callback_id, None)
    else
        device.registered_callbacks[callback_id] = function_
    end
end
