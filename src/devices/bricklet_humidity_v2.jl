


export BrickletHumidityV2HumidityCallbackConfiguration
struct BrickletHumidityV2HumidityCallbackConfiguration
    period::Integer
    value_has_to_change::Bool
    option::Char
    min::Integer
    max::Integer
end

export BrickletHumidityV2TemperatureCallbackConfiguration
struct BrickletHumidityV2TemperatureCallbackConfiguration
    period::Integer
    value_has_to_change::Bool
    option::Char
    min::Integer
    max::Integer
end

export BrickletHumidityV2MovingAverageConfiguration
struct BrickletHumidityV2MovingAverageConfiguration
    moving_average_length_humidity::Integer
    moving_average_length_temperature::Integer
end

export BrickletHumidityV2SPITFPErrorCount
struct BrickletHumidityV2SPITFPErrorCount
    error_count_ack_checksum::Integer
    error_count_message_checksum::Integer
    error_count_frame::Integer
    error_count_overflow::Integer
end

export BrickletHumidityV2Identity
struct BrickletHumidityV2Identity
    uid::String
    connected_uid::String
    position::Char
    hardware_version::Vector{Integer}
    firmware_version::Vector{Integer}
    device_identifier::Integer
end

export BrickletHumidityV2
"""
Measures relative humidity
"""
mutable struct BrickletHumidityV2 <: TinkerforgeDevice
    ipcon::IPConnection
    deviceInternal::PyObject

    """
    Creates an object with the unique device ID *uid* and adds it to
    the IP Connection *ipcon*.
    """
    function BrickletHumidityV2(uid::String, ipcon::IPConnection)
        package = pyimport("tinkerforge.bricklet_humidity_v2")
        deviceInternal = package.BrickletHumidityV2(uid, ipcon.ipconInternal)

        return new(ipcon, deviceInternal)
    end
end

export get_humidity
"""
    $(SIGNATURES)

Returns the humidity measured by the sensor.


If you want to get the value periodically, it is recommended to use the
:cb:`Humidity` callback. You can set the callback configuration
with :func:`Set Humidity Callback Configuration`.
"""
function get_humidity(device::BrickletHumidityV2)
    return device.deviceInternal.get_humidity()
end

export set_humidity_callback_configuration
"""
    $(SIGNATURES)

The period is the period with which the :cb:`Humidity` callback is triggered
periodically. A value of 0 turns the callback off.

If the `value has to change`-parameter is set to true, the callback is only
triggered after the value has changed. If the value didn't change
within the period, the callback is triggered immediately on change.

If it is set to false, the callback is continuously triggered with the period,
independent of the value.

It is furthermore possible to constrain the callback with thresholds.

The `option`-parameter together with min/max sets a threshold for the :cb:`Humidity` callback.

The following options are possible:

.. csv-table::
 :header: "Option", "Description"
 :widths: 10, 100

 "'x'",    "Threshold is turned off"
 "'o'",    "Threshold is triggered when the value is *outside* the min and max values"
 "'i'",    "Threshold is triggered when the value is *inside* or equal to the min and max values"
 "'<'",    "Threshold is triggered when the value is smaller than the min value (max is ignored)"
 "'>'",    "Threshold is triggered when the value is greater than the min value (max is ignored)"

If the option is set to 'x' (threshold turned off) the callback is triggered with the fixed period.
"""
function set_humidity_callback_configuration(device::BrickletHumidityV2, period, value_has_to_change, option, min, max)
    device.deviceInternal.set_humidity_callback_configuration(period, value_has_to_change, option, min, max)
end

export get_humidity_callback_configuration
"""
    $(SIGNATURES)

Returns the callback configuration as set by :func:`Set Humidity Callback Configuration`.
"""
function get_humidity_callback_configuration(device::BrickletHumidityV2)
    return device.deviceInternal.get_humidity_callback_configuration()
end

export get_temperature
"""
    $(SIGNATURES)

Returns the temperature measured by the sensor.


If you want to get the value periodically, it is recommended to use the
:cb:`Temperature` callback. You can set the callback configuration
with :func:`Set Temperature Callback Configuration`.
"""
function get_temperature(device::BrickletHumidityV2)
    return device.deviceInternal.get_temperature()
end

export set_temperature_callback_configuration
"""
    $(SIGNATURES)

The period is the period with which the :cb:`Temperature` callback is triggered
periodically. A value of 0 turns the callback off.

If the `value has to change`-parameter is set to true, the callback is only
triggered after the value has changed. If the value didn't change
within the period, the callback is triggered immediately on change.

If it is set to false, the callback is continuously triggered with the period,
independent of the value.

It is furthermore possible to constrain the callback with thresholds.

The `option`-parameter together with min/max sets a threshold for the :cb:`Temperature` callback.

The following options are possible:

.. csv-table::
 :header: "Option", "Description"
 :widths: 10, 100

 "'x'",    "Threshold is turned off"
 "'o'",    "Threshold is triggered when the value is *outside* the min and max values"
 "'i'",    "Threshold is triggered when the value is *inside* or equal to the min and max values"
 "'<'",    "Threshold is triggered when the value is smaller than the min value (max is ignored)"
 "'>'",    "Threshold is triggered when the value is greater than the min value (max is ignored)"

If the option is set to 'x' (threshold turned off) the callback is triggered with the fixed period.
"""
function set_temperature_callback_configuration(device::BrickletHumidityV2, period, value_has_to_change, option, min, max)
    device.deviceInternal.set_temperature_callback_configuration(period, value_has_to_change, option, min, max)
end

export get_temperature_callback_configuration
"""
    $(SIGNATURES)

Returns the callback configuration as set by :func:`Set Temperature Callback Configuration`.
"""
function get_temperature_callback_configuration(device::BrickletHumidityV2)
    return device.deviceInternal.get_temperature_callback_configuration()
end

export set_heater_configuration
"""
    $(SIGNATURES)

Enables/disables the heater. The heater can be used to dry the sensor in
extremely wet conditions.
"""
function set_heater_configuration(device::BrickletHumidityV2, heater_config)
    device.deviceInternal.set_heater_configuration(heater_config)
end

export get_heater_configuration
"""
    $(SIGNATURES)

Returns the heater configuration as set by :func:`Set Heater Configuration`.
"""
function get_heater_configuration(device::BrickletHumidityV2)
    return device.deviceInternal.get_heater_configuration()
end

export set_moving_average_configuration
"""
    $(SIGNATURES)

Sets the length of a `moving averaging <https://en.wikipedia.org/wiki/Moving_average>`__
for the humidity and temperature.

Setting the length to 1 will turn the averaging off. With less
averaging, there is more noise on the data.

New data is gathered every 50ms*. With a moving average of length 1000 the resulting
averaging window has a length of 50s. If you want to do long term measurements the longest
moving average will give the cleanest results.

\\* In firmware version 2.0.3 we added the :func:`Set Samples Per Second` function. It
configures the measurement frequency. Since high frequencies can result in self-heating
of th IC, changed the default value from 20 samples per second to 1. With 1 sample per second
a moving average length of 1000 would result in an averaging window of 1000 seconds!
"""
function set_moving_average_configuration(device::BrickletHumidityV2, moving_average_length_humidity, moving_average_length_temperature)
    device.deviceInternal.set_moving_average_configuration(moving_average_length_humidity, moving_average_length_temperature)
end

export get_moving_average_configuration
"""
    $(SIGNATURES)

Returns the moving average configuration as set by :func:`Set Moving Average Configuration`.
"""
function get_moving_average_configuration(device::BrickletHumidityV2)
    return device.deviceInternal.get_moving_average_configuration()
end

export set_samples_per_second
"""
    $(SIGNATURES)

Sets the samples per second that are gathered by the humidity/temperature sensor HDC1080.

We added this function since we found out that a high measurement frequency can lead to
self-heating of the sensor. Which can distort the temperature measurement.

If you don't need a lot of measurements, you can use the lowest available measurement
frequency of 0.1 samples per second for the least amount of self-heating.

Before version 2.0.3 the default was 20 samples per second. The new default is 1 sample per second.

.. versionadded:: 2.0.3\$nbsp;(Plugin)
"""
function set_samples_per_second(device::BrickletHumidityV2, sps)
    device.deviceInternal.set_samples_per_second(sps)
end

export get_samples_per_second
"""
    $(SIGNATURES)

Returnes the samples per second, as set by :func:`Set Samples Per Second`.

.. versionadded:: 2.0.3\$nbsp;(Plugin)
"""
function get_samples_per_second(device::BrickletHumidityV2)
    return device.deviceInternal.get_samples_per_second()
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
function get_spitfp_error_count(device::BrickletHumidityV2)
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
function set_bootloader_mode(device::BrickletHumidityV2, mode)
    return device.deviceInternal.set_bootloader_mode(mode)
end

export get_bootloader_mode
"""
    $(SIGNATURES)

Returns the current bootloader mode, see :func:`Set Bootloader Mode`.
"""
function get_bootloader_mode(device::BrickletHumidityV2)
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
function set_write_firmware_pointer(device::BrickletHumidityV2, pointer)
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
function write_firmware(device::BrickletHumidityV2, data)
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
function set_status_led_config(device::BrickletHumidityV2, config)
    device.deviceInternal.set_status_led_config(config)
end

export get_status_led_config
"""
    $(SIGNATURES)

Returns the configuration as set by :func:`Set Status LED Config`
"""
function get_status_led_config(device::BrickletHumidityV2)
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
function get_chip_temperature(device::BrickletHumidityV2)
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
function reset(device::BrickletHumidityV2)
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
function write_uid(device::BrickletHumidityV2, uid)
    device.deviceInternal.write_uid(uid)
end

export read_uid
"""
    $(SIGNATURES)

Returns the current UID as an integer. Encode as
Base58 to get the usual string version.
"""
function read_uid(device::BrickletHumidityV2)
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
function get_identity(device::BrickletHumidityV2)
    return device.deviceInternal.get_identity()
end

export register_callback
"""
Registers the given *function* with the given *callback_id*.
"""
function register_callback(device::BrickletHumidityV2, callback_id, function_)
    if isnothing(function_)
        device.registered_callbacks.pop(callback_id, None)
    else
        device.registered_callbacks[callback_id] = function_
    end
end
