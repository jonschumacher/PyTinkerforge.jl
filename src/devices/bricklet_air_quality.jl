


export BrickletAirQualityAllValues
struct BrickletAirQualityAllValues
    iaq_index::Integer
    iaq_index_accuracy::Integer
    temperature::Integer
    humidity::Integer
    air_pressure::Integer
end

export BrickletAirQualityAllValuesCallbackConfiguration
struct BrickletAirQualityAllValuesCallbackConfiguration
    period::Integer
    value_has_to_change::Bool
end

export BrickletAirQualityIAQIndex
struct BrickletAirQualityIAQIndex
    iaq_index::Integer
    iaq_index_accuracy::Integer
end

export BrickletAirQualityIAQIndexCallbackConfiguration
struct BrickletAirQualityIAQIndexCallbackConfiguration
    period::Integer
    value_has_to_change::Bool
end

export BrickletAirQualityTemperatureCallbackConfiguration
struct BrickletAirQualityTemperatureCallbackConfiguration
    period::Integer
    value_has_to_change::Bool
    option::Char
    min::Integer
    max::Integer
end

export BrickletAirQualityHumidityCallbackConfiguration
struct BrickletAirQualityHumidityCallbackConfiguration
    period::Integer
    value_has_to_change::Bool
    option::Char
    min::Integer
    max::Integer
end

export BrickletAirQualityAirPressureCallbackConfiguration
struct BrickletAirQualityAirPressureCallbackConfiguration
    period::Integer
    value_has_to_change::Bool
    option::Char
    min::Integer
    max::Integer
end

export BrickletAirQualitySPITFPErrorCount
struct BrickletAirQualitySPITFPErrorCount
    error_count_ack_checksum::Integer
    error_count_message_checksum::Integer
    error_count_frame::Integer
    error_count_overflow::Integer
end

export BrickletAirQualityIdentity
struct BrickletAirQualityIdentity
    uid::String
    connected_uid::String
    position::Char
    hardware_version::Vector{Integer}
    firmware_version::Vector{Integer}
    device_identifier::Integer
end

export BrickletAirQuality
"""
Measures IAQ index, temperature, humidity and air pressure
"""
mutable struct BrickletAirQuality <: TinkerforgeDevice
    ipcon::IPConnection
    deviceInternal::PyObject

    """
    Creates an object with the unique device ID *uid* and adds it to
    the IP Connection *ipcon*.
    """
    function BrickletAirQuality(uid::String, ipcon::IPConnection)
        package = pyimport("tinkerforge.bricklet_air_quality")
        deviceInternal = package.BrickletAirQuality(uid, ipcon.ipconInternal)

        return new(ipcon, deviceInternal)
    end
end

export get_all_values
"""
    $(SIGNATURES)

Returns all values measured by the Air Quality Bricklet. The values are
IAQ (Indoor Air Quality) Index (higher value means greater level of air pollution), IAQ Index Accuracy, Temperature, Humidity and
Air Pressure.

.. image:: /Images/Misc/bricklet_air_quality_iaq_index.png
   :scale: 100 %
   :alt: Air Quality Index description
   :align: center
   :target: ../../_images/Misc/bricklet_air_quality_iaq_index.png
"""
function get_all_values(device::BrickletAirQuality)
    return device.deviceInternal.get_all_values()
end

export set_temperature_offset
"""
    $(SIGNATURES)

Sets a temperature offset. A offset of 10 will decrease the measured temperature by 0.1 °C.

If you install this Bricklet into an enclosure and you want to measure the ambient
temperature, you may have to decrease the measured temperature by some value to
compensate for the error because of the heating inside of the enclosure.

We recommend that you leave the parts in the enclosure running for at least
24 hours such that a temperature equilibrium can be reached. After that you can measure
the temperature directly outside of enclosure and set the difference as offset.

This temperature offset is used to calculate the relative humidity and
IAQ index measurements. In case the Bricklet is installed in an enclosure, we
recommend to measure and set the temperature offset to improve the accuracy of
the measurements.
"""
function set_temperature_offset(device::BrickletAirQuality, offset)
    device.deviceInternal.set_temperature_offset(offset)
end

export get_temperature_offset
"""
    $(SIGNATURES)

Returns the temperature offset as set by
:func:`Set Temperature Offset`.
"""
function get_temperature_offset(device::BrickletAirQuality)
    return device.deviceInternal.get_temperature_offset()
end

export set_all_values_callback_configuration
"""
    $(SIGNATURES)

The period is the period with which the :cb:`All Values`
callback is triggered periodically. A value of 0 turns the callback off.

If the `value has to change`-parameter is set to true, the callback is only
triggered after at least one of the values has changed. If the values didn't
change within the period, the callback is triggered immediately on change.

If it is set to false, the callback is continuously triggered with the period,
independent of the value.
"""
function set_all_values_callback_configuration(device::BrickletAirQuality, period, value_has_to_change)
    device.deviceInternal.set_all_values_callback_configuration(period, value_has_to_change)
end

export get_all_values_callback_configuration
"""
    $(SIGNATURES)

Returns the callback configuration as set by
:func:`Set All Values Callback Configuration`.
"""
function get_all_values_callback_configuration(device::BrickletAirQuality)
    return device.deviceInternal.get_all_values_callback_configuration()
end

export get_iaq_index
"""
    $(SIGNATURES)

Returns the IAQ index and accuracy. The higher the IAQ index, the greater the level of air pollution.

.. image:: /Images/Misc/bricklet_air_quality_iaq_index.png
   :scale: 100 %
   :alt: IAQ index description
   :align: center
   :target: ../../_images/Misc/bricklet_air_quality_iaq_index.png

If you want to get the value periodically, it is recommended to use the
:cb:`IAQ Index` callback. You can set the callback configuration
with :func:`Set IAQ Index Callback Configuration`.
"""
function get_iaq_index(device::BrickletAirQuality)
    return device.deviceInternal.get_iaq_index()
end

export set_iaq_index_callback_configuration
"""
    $(SIGNATURES)

The period is the period with which the :cb:`IAQ Index`
callback is triggered periodically. A value of 0 turns the callback off.

If the `value has to change`-parameter is set to true, the callback is only
triggered after at least one of the values has changed. If the values didn't
change within the period, the callback is triggered immediately on change.

If it is set to false, the callback is continuously triggered with the period,
independent of the value.
"""
function set_iaq_index_callback_configuration(device::BrickletAirQuality, period, value_has_to_change)
    device.deviceInternal.set_iaq_index_callback_configuration(period, value_has_to_change)
end

export get_iaq_index_callback_configuration
"""
    $(SIGNATURES)

Returns the callback configuration as set by
:func:`Set IAQ Index Callback Configuration`.
"""
function get_iaq_index_callback_configuration(device::BrickletAirQuality)
    return device.deviceInternal.get_iaq_index_callback_configuration()
end

export get_temperature
"""
    $(SIGNATURES)

Returns temperature.


If you want to get the value periodically, it is recommended to use the
:cb:`Temperature` callback. You can set the callback configuration
with :func:`Set Temperature Callback Configuration`.
"""
function get_temperature(device::BrickletAirQuality)
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
function set_temperature_callback_configuration(device::BrickletAirQuality, period, value_has_to_change, option, min, max)
    device.deviceInternal.set_temperature_callback_configuration(period, value_has_to_change, option, min, max)
end

export get_temperature_callback_configuration
"""
    $(SIGNATURES)

Returns the callback configuration as set by :func:`Set Temperature Callback Configuration`.
"""
function get_temperature_callback_configuration(device::BrickletAirQuality)
    return device.deviceInternal.get_temperature_callback_configuration()
end

export get_humidity
"""
    $(SIGNATURES)

Returns relative humidity.


If you want to get the value periodically, it is recommended to use the
:cb:`Humidity` callback. You can set the callback configuration
with :func:`Set Humidity Callback Configuration`.
"""
function get_humidity(device::BrickletAirQuality)
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
function set_humidity_callback_configuration(device::BrickletAirQuality, period, value_has_to_change, option, min, max)
    device.deviceInternal.set_humidity_callback_configuration(period, value_has_to_change, option, min, max)
end

export get_humidity_callback_configuration
"""
    $(SIGNATURES)

Returns the callback configuration as set by :func:`Set Humidity Callback Configuration`.
"""
function get_humidity_callback_configuration(device::BrickletAirQuality)
    return device.deviceInternal.get_humidity_callback_configuration()
end

export get_air_pressure
"""
    $(SIGNATURES)

Returns air pressure.


If you want to get the value periodically, it is recommended to use the
:cb:`Air Pressure` callback. You can set the callback configuration
with :func:`Set Air Pressure Callback Configuration`.
"""
function get_air_pressure(device::BrickletAirQuality)
    return device.deviceInternal.get_air_pressure()
end

export set_air_pressure_callback_configuration
"""
    $(SIGNATURES)

The period is the period with which the :cb:`Air Pressure` callback is triggered
periodically. A value of 0 turns the callback off.

If the `value has to change`-parameter is set to true, the callback is only
triggered after the value has changed. If the value didn't change
within the period, the callback is triggered immediately on change.

If it is set to false, the callback is continuously triggered with the period,
independent of the value.

It is furthermore possible to constrain the callback with thresholds.

The `option`-parameter together with min/max sets a threshold for the :cb:`Air Pressure` callback.

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
function set_air_pressure_callback_configuration(device::BrickletAirQuality, period, value_has_to_change, option, min, max)
    device.deviceInternal.set_air_pressure_callback_configuration(period, value_has_to_change, option, min, max)
end

export get_air_pressure_callback_configuration
"""
    $(SIGNATURES)

Returns the callback configuration as set by :func:`Set Air Pressure Callback Configuration`.
"""
function get_air_pressure_callback_configuration(device::BrickletAirQuality)
    return device.deviceInternal.get_air_pressure_callback_configuration()
end

export remove_calibration
"""
    $(SIGNATURES)

Deletes the calibration from flash. After you call this function,
you need to power cycle the Air Quality Bricklet.

On the next power up the Bricklet will start a new calibration, as
if it was started for the very first time.

The calibration is based on the data of the last four days, so it takes
four days until a full calibration is re-established.

.. versionadded:: 2.0.3\$nbsp;(Plugin)
"""
function remove_calibration(device::BrickletAirQuality)
    device.deviceInternal.remove_calibration()
end

export set_background_calibration_duration
"""
    $(SIGNATURES)

The Air Quality Bricklet uses an automatic background calibration mechanism to
calculate the IAQ Index. This calibration mechanism considers a history of
measured data. The duration of this history can be configured to either be
4 days or 28 days.

If you keep the Bricklet mostly at one place and it does not get moved around
to different environments, we recommend that you use a duration of 28 days.

If you change the duration, the current calibration will be discarded and
the calibration will start from beginning again. The configuration of the
duration is saved in flash, so you should only have to call this function
once in the lifetime of the Bricklet.

The Bricklet has to be power cycled after this function is called
for a duration change to take effect.

Before firmware version 2.0.3 this was not configurable and the duration was
4 days.

The default value (since firmware version 2.0.3) is 28 days.

.. versionadded:: 2.0.3\$nbsp;(Plugin)
"""
function set_background_calibration_duration(device::BrickletAirQuality, duration)
    device.deviceInternal.set_background_calibration_duration(duration)
end

export get_background_calibration_duration
"""
    $(SIGNATURES)

Returns the background calibration duration as set by
:func:`Set Background Calibration Duration`.

.. versionadded:: 2.0.3\$nbsp;(Plugin)
"""
function get_background_calibration_duration(device::BrickletAirQuality)
    return device.deviceInternal.get_background_calibration_duration()
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
function get_spitfp_error_count(device::BrickletAirQuality)
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
function set_bootloader_mode(device::BrickletAirQuality, mode)
    return device.deviceInternal.set_bootloader_mode(mode)
end

export get_bootloader_mode
"""
    $(SIGNATURES)

Returns the current bootloader mode, see :func:`Set Bootloader Mode`.
"""
function get_bootloader_mode(device::BrickletAirQuality)
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
function set_write_firmware_pointer(device::BrickletAirQuality, pointer)
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
function write_firmware(device::BrickletAirQuality, data)
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
function set_status_led_config(device::BrickletAirQuality, config)
    device.deviceInternal.set_status_led_config(config)
end

export get_status_led_config
"""
    $(SIGNATURES)

Returns the configuration as set by :func:`Set Status LED Config`
"""
function get_status_led_config(device::BrickletAirQuality)
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
function get_chip_temperature(device::BrickletAirQuality)
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
function reset(device::BrickletAirQuality)
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
function write_uid(device::BrickletAirQuality, uid)
    device.deviceInternal.write_uid(uid)
end

export read_uid
"""
    $(SIGNATURES)

Returns the current UID as an integer. Encode as
Base58 to get the usual string version.
"""
function read_uid(device::BrickletAirQuality)
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
function get_identity(device::BrickletAirQuality)
    return device.deviceInternal.get_identity()
end

export register_callback
"""
Registers the given *function* with the given *callback_id*.
"""
function register_callback(device::BrickletAirQuality, callback_id, function_)
    if isnothing(function_)
        device.registered_callbacks.pop(callback_id, None)
    else
        device.registered_callbacks[callback_id] = function_
    end
end
