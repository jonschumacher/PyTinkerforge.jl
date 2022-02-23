


export BrickletOutdoorWeatherStationIdentifiersLowLevel
struct BrickletOutdoorWeatherStationIdentifiersLowLevel
    identifiers_length::Integer
    identifiers_chunk_offset::Integer
    identifiers_chunk_data::Vector{Integer}
end

export BrickletOutdoorWeatherSensorIdentifiersLowLevel
struct BrickletOutdoorWeatherSensorIdentifiersLowLevel
    identifiers_length::Integer
    identifiers_chunk_offset::Integer
    identifiers_chunk_data::Vector{Integer}
end

export BrickletOutdoorWeatherStationData
struct BrickletOutdoorWeatherStationData
    temperature::Integer
    humidity::Integer
    wind_speed::Integer
    gust_speed::Integer
    rain::Integer
    wind_direction::Integer
    battery_low::Bool
    last_change::Integer
end

export BrickletOutdoorWeatherSensorData
struct BrickletOutdoorWeatherSensorData
    temperature::Integer
    humidity::Integer
    last_change::Integer
end

export BrickletOutdoorWeatherSPITFPErrorCount
struct BrickletOutdoorWeatherSPITFPErrorCount
    error_count_ack_checksum::Integer
    error_count_message_checksum::Integer
    error_count_frame::Integer
    error_count_overflow::Integer
end

export BrickletOutdoorWeatherIdentity
struct BrickletOutdoorWeatherIdentity
    uid::String
    connected_uid::String
    position::Char
    hardware_version::Vector{Integer}
    firmware_version::Vector{Integer}
    device_identifier::Integer
end

export BrickletOutdoorWeather
"""
433MHz receiver for outdoor weather station
"""
mutable struct BrickletOutdoorWeather <: TinkerforgeDevice
    ipcon::IPConnection
    deviceInternal::PyObject

    """
    Creates an object with the unique device ID *uid* and adds it to
    the IP Connection *ipcon*.
    """
    function BrickletOutdoorWeather(uid::String, ipcon::IPConnection)
        package = pyimport("tinkerforge.bricklet_outdoor_weather")
        deviceInternal = package.BrickletOutdoorWeather(uid, ipcon.ipconInternal)

        return new(ipcon, deviceInternal)
    end
end

export get_station_identifiers_low_level
"""
    $(SIGNATURES)

Returns the identifiers (number between 0 and 255) of all `stations
<https://www.tinkerforge.com/en/shop/accessories/sensors/outdoor-weather-station-ws-6147.html>`__
that have been seen since the startup of the Bricklet.

Each station gives itself a random identifier on first startup.

Since firmware version 2.0.2 a station is removed from the list if no data was received for
12 hours.
"""
function get_station_identifiers_low_level(device::BrickletOutdoorWeather)
    return device.deviceInternal.get_station_identifiers_low_level()
end

export get_sensor_identifiers_low_level
"""
    $(SIGNATURES)

Returns the identifiers (number between 0 and 255) of all `sensors
<https://www.tinkerforge.com/en/shop/accessories/sensors/temperature-humidity-sensor-th-6148.html>`__
that have been seen since the startup of the Bricklet.

Each sensor gives itself a random identifier on first startup.

Since firmware version 2.0.2 a sensor is removed from the list if no data was received for
12 hours.
"""
function get_sensor_identifiers_low_level(device::BrickletOutdoorWeather)
    return device.deviceInternal.get_sensor_identifiers_low_level()
end

export get_station_data
"""
    $(SIGNATURES)

Returns the last received data for a station with the given identifier.
Call :func:`Get Station Identifiers` for a list of all available identifiers.

The return values are:

* Temperature,
* Humidity,
* Wind Speed,
* Gust Speed,
* Rain Fall (accumulated since station power-up),
* Wind Direction,
* Battery Low (true if battery is low) and
* Last Change (seconds since the reception of this data).
"""
function get_station_data(device::BrickletOutdoorWeather, identifier)
    return device.deviceInternal.get_station_data(identifier)
end

export get_sensor_data
"""
    $(SIGNATURES)

Returns the last measured data for a sensor with the given identifier.
Call :func:`Get Sensor Identifiers` for a list of all available identifiers.

The return values are:

* Temperature,
* Humidity and
* Last Change (seconds since the last reception of data).
"""
function get_sensor_data(device::BrickletOutdoorWeather, identifier)
    return device.deviceInternal.get_sensor_data(identifier)
end

export set_station_callback_configuration
"""
    $(SIGNATURES)

Turns callback for station data on or off.
"""
function set_station_callback_configuration(device::BrickletOutdoorWeather, enable_callback)
    device.deviceInternal.set_station_callback_configuration(enable_callback)
end

export get_station_callback_configuration
"""
    $(SIGNATURES)

Returns the configuration as set by :func:`Set Station Callback Configuration`.
"""
function get_station_callback_configuration(device::BrickletOutdoorWeather)
    return device.deviceInternal.get_station_callback_configuration()
end

export set_sensor_callback_configuration
"""
    $(SIGNATURES)

Turns callback for sensor data on or off.
"""
function set_sensor_callback_configuration(device::BrickletOutdoorWeather, enable_callback)
    device.deviceInternal.set_sensor_callback_configuration(enable_callback)
end

export get_sensor_callback_configuration
"""
    $(SIGNATURES)

Returns the configuration as set by :func:`Set Sensor Callback Configuration`.
"""
function get_sensor_callback_configuration(device::BrickletOutdoorWeather)
    return device.deviceInternal.get_sensor_callback_configuration()
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
function get_spitfp_error_count(device::BrickletOutdoorWeather)
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
function set_bootloader_mode(device::BrickletOutdoorWeather, mode)
    return device.deviceInternal.set_bootloader_mode(mode)
end

export get_bootloader_mode
"""
    $(SIGNATURES)

Returns the current bootloader mode, see :func:`Set Bootloader Mode`.
"""
function get_bootloader_mode(device::BrickletOutdoorWeather)
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
function set_write_firmware_pointer(device::BrickletOutdoorWeather, pointer)
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
function write_firmware(device::BrickletOutdoorWeather, data)
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
function set_status_led_config(device::BrickletOutdoorWeather, config)
    device.deviceInternal.set_status_led_config(config)
end

export get_status_led_config
"""
    $(SIGNATURES)

Returns the configuration as set by :func:`Set Status LED Config`
"""
function get_status_led_config(device::BrickletOutdoorWeather)
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
function get_chip_temperature(device::BrickletOutdoorWeather)
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
function reset(device::BrickletOutdoorWeather)
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
function write_uid(device::BrickletOutdoorWeather, uid)
    device.deviceInternal.write_uid(uid)
end

export read_uid
"""
    $(SIGNATURES)

Returns the current UID as an integer. Encode as
Base58 to get the usual string version.
"""
function read_uid(device::BrickletOutdoorWeather)
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
function get_identity(device::BrickletOutdoorWeather)
    return device.deviceInternal.get_identity()
end

export get_station_identifiers
"""
Returns the identifiers (number between 0 and 255) of all `stations
<https://www.tinkerforge.com/en/shop/accessories/sensors/outdoor-weather-station-ws-6147.html>`__
that have been seen since the startup of the Bricklet.

Each station gives itself a random identifier on first startup.

Since firmware version 2.0.2 a station is removed from the list if no data was received for
12 hours.
"""
function get_station_identifiers(device::BrickletOutdoorWeather)

    lock(device.stream_lock) do
        ret = get_station_identifiers_low_level(device, )
            identifiers_length = ret.identifiers_length
        identifiers_out_of_sync = ret.identifiers_chunk_offset != 0

        identifiers_data = ret.identifiers_chunk_data

        while !identifiers_out_of_sync && length(identifiers_data) < identifiers_length
            ret = get_station_identifiers_low_level(device, )
                identifiers_length = ret.identifiers_length
            identifiers_out_of_sync = ret.identifiers_chunk_offset != length(identifiers_data)
            identifiers_data += ret.identifiers_chunk_data
        end

        if identifiers_out_of_sync # discard remaining stream to bring it back in-sync
            while ret.identifiers_chunk_offset + 60 < identifiers_length
                ret = get_station_identifiers_low_level(device, )
                    identifiers_length = ret.identifiers_length
            end

            throw(TinkerforgeStreamOutOfSyncError("Identifiers stream is out-of-sync"))
        end
    end

        return identifiers_data[:identifiers_length]
end

export get_sensor_identifiers
"""
Returns the identifiers (number between 0 and 255) of all `sensors
<https://www.tinkerforge.com/en/shop/accessories/sensors/temperature-humidity-sensor-th-6148.html>`__
that have been seen since the startup of the Bricklet.

Each sensor gives itself a random identifier on first startup.

Since firmware version 2.0.2 a sensor is removed from the list if no data was received for
12 hours.
"""
function get_sensor_identifiers(device::BrickletOutdoorWeather)

    lock(device.stream_lock) do
        ret = get_sensor_identifiers_low_level(device, )
            identifiers_length = ret.identifiers_length
        identifiers_out_of_sync = ret.identifiers_chunk_offset != 0

        identifiers_data = ret.identifiers_chunk_data

        while !identifiers_out_of_sync && length(identifiers_data) < identifiers_length
            ret = get_sensor_identifiers_low_level(device, )
                identifiers_length = ret.identifiers_length
            identifiers_out_of_sync = ret.identifiers_chunk_offset != length(identifiers_data)
            identifiers_data += ret.identifiers_chunk_data
        end

        if identifiers_out_of_sync # discard remaining stream to bring it back in-sync
            while ret.identifiers_chunk_offset + 60 < identifiers_length
                ret = get_sensor_identifiers_low_level(device, )
                    identifiers_length = ret.identifiers_length
            end

            throw(TinkerforgeStreamOutOfSyncError("Identifiers stream is out-of-sync"))
        end
    end

        return identifiers_data[:identifiers_length]
end

export register_callback
"""
Registers the given *function* with the given *callback_id*.
"""
function register_callback(device::BrickletOutdoorWeather, callback_id, function_)
    if isnothing(function_)
        device.registered_callbacks.pop(callback_id, None)
    else
        device.registered_callbacks[callback_id] = function_
    end
end
