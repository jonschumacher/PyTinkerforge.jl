


export BrickletGPSV2Coordinates
struct BrickletGPSV2Coordinates
    latitude::Integer
    ns::Char
    longitude::Integer
    ew::Char
end

export BrickletGPSV2Status
struct BrickletGPSV2Status
    has_fix::Bool
    satellites_view::Integer
end

export BrickletGPSV2Altitude
struct BrickletGPSV2Altitude
    altitude::Integer
    geoidal_separation::Integer
end

export BrickletGPSV2Motion
struct BrickletGPSV2Motion
    course::Integer
    speed::Integer
end

export BrickletGPSV2DateTime
struct BrickletGPSV2DateTime
    date::Integer
    time::Integer
end

export BrickletGPSV2SatelliteSystemStatusLowLevel
struct BrickletGPSV2SatelliteSystemStatusLowLevel
    satellite_numbers_length::Integer
    satellite_numbers_data::Vector{Integer}
    fix::Integer
    pdop::Integer
    hdop::Integer
    vdop::Integer
end

export BrickletGPSV2SatelliteStatus
struct BrickletGPSV2SatelliteStatus
    elevation::Integer
    azimuth::Integer
    snr::Integer
end

export BrickletGPSV2SPITFPErrorCount
struct BrickletGPSV2SPITFPErrorCount
    error_count_ack_checksum::Integer
    error_count_message_checksum::Integer
    error_count_frame::Integer
    error_count_overflow::Integer
end

export BrickletGPSV2Identity
struct BrickletGPSV2Identity
    uid::String
    connected_uid::String
    position::Char
    hardware_version::Vector{Integer}
    firmware_version::Vector{Integer}
    device_identifier::Integer
end

export BrickletGPSV2SatelliteSystemStatus
struct BrickletGPSV2SatelliteSystemStatus
    satellite_numbers::Vector{Integer}
    fix::Integer
    pdop::Integer
    hdop::Integer
    vdop::Integer
end

export BrickletGPSV2
"""
Determine position, velocity and altitude using GPS
"""
mutable struct BrickletGPSV2 <: TinkerforgeDevice
    ipcon::IPConnection
    deviceInternal::PyObject

    """
    Creates an object with the unique device ID *uid* and adds it to
    the IP Connection *ipcon*.
    """
    function BrickletGPSV2(uid::String, ipcon::IPConnection)
        package = pyimport("tinkerforge.bricklet_gps_v2")
        deviceInternal = package.BrickletGPSV2(uid, ipcon.ipconInternal)

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

This data is only valid if there is currently a fix as indicated by
:func:`Get Status`.
"""
function get_coordinates(device::BrickletGPSV2)
    return device.deviceInternal.get_coordinates()
end

export get_status
"""
    $(SIGNATURES)

Returns if a fix is currently available as well as the, the number of
satellites that are in view.

There is also a :ref:`green LED <gps_v2_bricklet_fix_led>` on the Bricklet that
indicates the fix status.
"""
function get_status(device::BrickletGPSV2)
    return device.deviceInternal.get_status()
end

export get_altitude
"""
    $(SIGNATURES)

Returns the current altitude and corresponding geoidal separation.

This data is only valid if there is currently a fix as indicated by
:func:`Get Status`.
"""
function get_altitude(device::BrickletGPSV2)
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
function get_motion(device::BrickletGPSV2)
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
function get_date_time(device::BrickletGPSV2)
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
function restart(device::BrickletGPSV2, restart_type)
    device.deviceInternal.restart(restart_type)
end

export get_satellite_system_status_low_level
"""
    $(SIGNATURES)

Returns the

* satellite numbers list (up to 12 items)
* fix value,
* PDOP value,
* HDOP value and
* VDOP value

for a given satellite system. Currently GPS and GLONASS are supported, Galileo
is not yet supported.

The GPS and GLONASS satellites have unique numbers and the satellite list gives
the numbers of the satellites that are currently utilized. The number 0 is not
a valid satellite number and can be ignored in the list.
"""
function get_satellite_system_status_low_level(device::BrickletGPSV2, satellite_system)
    return device.deviceInternal.get_satellite_system_status_low_level(satellite_system)
end

export get_satellite_status
"""
    $(SIGNATURES)

Returns the current elevation, azimuth and SNR
for a given satellite and satellite system.

The satellite number here always goes from 1 to 32. For GLONASS it corresponds to
the satellites 65-96.

Galileo is not yet supported.
"""
function get_satellite_status(device::BrickletGPSV2, satellite_system, satellite_number)
    return device.deviceInternal.get_satellite_status(satellite_system, satellite_number)
end

export set_fix_led_config
"""
    $(SIGNATURES)

Sets the fix LED configuration. By default the LED shows if
the Bricklet got a GPS fix yet. If a fix is established the LED turns on.
If there is no fix then the LED is turned off.

You can also turn the LED permanently on/off, show a heartbeat or let it blink
in sync with the PPS (pulse per second) output of the GPS module.

If the Bricklet is in bootloader mode, the LED is off.
"""
function set_fix_led_config(device::BrickletGPSV2, config)
    device.deviceInternal.set_fix_led_config(config)
end

export get_fix_led_config
"""
    $(SIGNATURES)

Returns the configuration as set by :func:`Set Fix LED Config`
"""
function get_fix_led_config(device::BrickletGPSV2)
    return device.deviceInternal.get_fix_led_config()
end

export set_coordinates_callback_period
"""
    $(SIGNATURES)

Sets the period with which the :cb:`Coordinates` callback is triggered
periodically. A value of 0 turns the callback off.

The :cb:`Coordinates` callback is only triggered if the coordinates changed
since the last triggering.
"""
function set_coordinates_callback_period(device::BrickletGPSV2, period)
    device.deviceInternal.set_coordinates_callback_period(period)
end

export get_coordinates_callback_period
"""
    $(SIGNATURES)

Returns the period as set by :func:`Set Coordinates Callback Period`.
"""
function get_coordinates_callback_period(device::BrickletGPSV2)
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
function set_status_callback_period(device::BrickletGPSV2, period)
    device.deviceInternal.set_status_callback_period(period)
end

export get_status_callback_period
"""
    $(SIGNATURES)

Returns the period as set by :func:`Set Status Callback Period`.
"""
function get_status_callback_period(device::BrickletGPSV2)
    return device.deviceInternal.get_status_callback_period()
end

export set_altitude_callback_period
"""
    $(SIGNATURES)

Sets the period with which the :cb:`Altitude` callback is triggered
periodically. A value of 0 turns the callback off.

The :cb:`Altitude` callback is only triggered if the altitude changed since the
last triggering.
"""
function set_altitude_callback_period(device::BrickletGPSV2, period)
    device.deviceInternal.set_altitude_callback_period(period)
end

export get_altitude_callback_period
"""
    $(SIGNATURES)

Returns the period as set by :func:`Set Altitude Callback Period`.
"""
function get_altitude_callback_period(device::BrickletGPSV2)
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
function set_motion_callback_period(device::BrickletGPSV2, period)
    device.deviceInternal.set_motion_callback_period(period)
end

export get_motion_callback_period
"""
    $(SIGNATURES)

Returns the period as set by :func:`Set Motion Callback Period`.
"""
function get_motion_callback_period(device::BrickletGPSV2)
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
function set_date_time_callback_period(device::BrickletGPSV2, period)
    device.deviceInternal.set_date_time_callback_period(period)
end

export get_date_time_callback_period
"""
    $(SIGNATURES)

Returns the period as set by :func:`Set Date Time Callback Period`.
"""
function get_date_time_callback_period(device::BrickletGPSV2)
    return device.deviceInternal.get_date_time_callback_period()
end

export set_sbas_config
"""
    $(SIGNATURES)

If `SBAS <https://en.wikipedia.org/wiki/GNSS_augmentation#Satellite-based_augmentation_system>`__ is enabled,
the position accuracy increases (if SBAS satellites are in view),
but the update rate is limited to 5Hz. With SBAS disabled the update rate is increased to 10Hz.

.. versionadded:: 2.0.2\$nbsp;(Plugin)
"""
function set_sbas_config(device::BrickletGPSV2, sbas_config)
    device.deviceInternal.set_sbas_config(sbas_config)
end

export get_sbas_config
"""
    $(SIGNATURES)

Returns the SBAS configuration as set by :func:`Set SBAS Config`

.. versionadded:: 2.0.2\$nbsp;(Plugin)
"""
function get_sbas_config(device::BrickletGPSV2)
    return device.deviceInternal.get_sbas_config()
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
function get_spitfp_error_count(device::BrickletGPSV2)
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
function set_bootloader_mode(device::BrickletGPSV2, mode)
    return device.deviceInternal.set_bootloader_mode(mode)
end

export get_bootloader_mode
"""
    $(SIGNATURES)

Returns the current bootloader mode, see :func:`Set Bootloader Mode`.
"""
function get_bootloader_mode(device::BrickletGPSV2)
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
function set_write_firmware_pointer(device::BrickletGPSV2, pointer)
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
function write_firmware(device::BrickletGPSV2, data)
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
function set_status_led_config(device::BrickletGPSV2, config)
    device.deviceInternal.set_status_led_config(config)
end

export get_status_led_config
"""
    $(SIGNATURES)

Returns the configuration as set by :func:`Set Status LED Config`
"""
function get_status_led_config(device::BrickletGPSV2)
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
function get_chip_temperature(device::BrickletGPSV2)
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
function reset(device::BrickletGPSV2)
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
function write_uid(device::BrickletGPSV2, uid)
    device.deviceInternal.write_uid(uid)
end

export read_uid
"""
    $(SIGNATURES)

Returns the current UID as an integer. Encode as
Base58 to get the usual string version.
"""
function read_uid(device::BrickletGPSV2)
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
function get_identity(device::BrickletGPSV2)
    return device.deviceInternal.get_identity()
end

export get_satellite_system_status
"""
Returns the

* satellite numbers list (up to 12 items)
* fix value,
* PDOP value,
* HDOP value and
* VDOP value

for a given satellite system. Currently GPS and GLONASS are supported, Galileo
is not yet supported.

The GPS and GLONASS satellites have unique numbers and the satellite list gives
the numbers of the satellites that are currently utilized. The number 0 is not
a valid satellite number and can be ignored in the list.
"""
function get_satellite_system_status(device::BrickletGPSV2, satellite_system)

        satellite_system = UInt8(satellite_system)

    ret = get_satellite_system_status_low_level(device, satellite_system)

        return GetSatelliteSystemStatus(ret.satellite_numbers_data[:ret.satellite_numbers_length], ret.fix, ret.pdop, ret.hdop, ret.vdop)
end

export register_callback
"""
Registers the given *function* with the given *callback_id*.
"""
function register_callback(device::BrickletGPSV2, callback_id, function_)
    if isnothing(function_)
        device.registered_callbacks.pop(callback_id, None)
    else
        device.registered_callbacks[callback_id] = function_
    end
end
