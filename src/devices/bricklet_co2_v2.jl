


export BrickletCO2V2AllValues
struct BrickletCO2V2AllValues
    co2_concentration::Integer
    temperature::Integer
    humidity::Integer
end

export BrickletCO2V2AllValuesCallbackConfiguration
struct BrickletCO2V2AllValuesCallbackConfiguration
    period::Integer
    value_has_to_change::Bool
end

export BrickletCO2V2CO2ConcentrationCallbackConfiguration
struct BrickletCO2V2CO2ConcentrationCallbackConfiguration
    period::Integer
    value_has_to_change::Bool
    option::Char
    min::Integer
    max::Integer
end

export BrickletCO2V2TemperatureCallbackConfiguration
struct BrickletCO2V2TemperatureCallbackConfiguration
    period::Integer
    value_has_to_change::Bool
    option::Char
    min::Integer
    max::Integer
end

export BrickletCO2V2HumidityCallbackConfiguration
struct BrickletCO2V2HumidityCallbackConfiguration
    period::Integer
    value_has_to_change::Bool
    option::Char
    min::Integer
    max::Integer
end

export BrickletCO2V2SPITFPErrorCount
struct BrickletCO2V2SPITFPErrorCount
    error_count_ack_checksum::Integer
    error_count_message_checksum::Integer
    error_count_frame::Integer
    error_count_overflow::Integer
end

export BrickletCO2V2Identity
struct BrickletCO2V2Identity
    uid::String
    connected_uid::String
    position::Char
    hardware_version::Vector{Integer}
    firmware_version::Vector{Integer}
    device_identifier::Integer
end

export BrickletCO2V2
"""
Measures CO2 concentration, temperature and humidity
"""
mutable struct BrickletCO2V2 <: TinkerforgeDevice
    ipcon::IPConnection
    deviceInternal::PyObject

    """
    Creates an object with the unique device ID *uid* and adds it to
    the IP Connection *ipcon*.
    """
    function BrickletCO2V2(uid::String, ipcon::IPConnection)
        package = pyimport("tinkerforge.bricklet_co2_v2")
        deviceInternal = package.BrickletCO2V2(uid, ipcon.ipconInternal)

        return new(ipcon, deviceInternal)
    end
end

export get_all_values
"""
    $(SIGNATURES)

Returns all values measured by the CO2 Bricklet 2.0.

If you want to get the values periodically, it is recommended to use the
:cb:`All Values` callback. You can set the callback configuration
with :func:`Set All Values Callback Configuration`.

.. note::
 The sensor is able to messure up to 120 °C. However it is only specified up to 70 °C.
 Exposing the Bricklet to higher temperatures might result in permanent damage.
"""
function get_all_values(device::BrickletCO2V2)
    return device.deviceInternal.get_all_values()
end

export set_air_pressure
"""
    $(SIGNATURES)

The CO2 concentration depends (among other things) on the ambient air pressure.

To increase the accuracy of the CO2 Bricklet 2.0 you can set the current air pressure.
You use the :ref:`Barometer Bricklet 2.0 <barometer_v2_bricklet>` or the
:ref:`Air Quality Bricklet <air_quality_bricklet>` to get the current air pressure.

By default air pressure compensation is disabled. Once you set a value it
will be used for compensation. You can turn the compensation off again by
setting the value to 0.

It is sufficient to update the value every few minutes.
"""
function set_air_pressure(device::BrickletCO2V2, air_pressure)
    device.deviceInternal.set_air_pressure(air_pressure)
end

export get_air_pressure
"""
    $(SIGNATURES)

Returns the ambient air pressure as set by :func:`Set Air Pressure`.
"""
function get_air_pressure(device::BrickletCO2V2)
    return device.deviceInternal.get_air_pressure()
end

export set_temperature_offset
"""
    $(SIGNATURES)

Sets a temperature offset. A offset of 10 will decrease
the measured temperature by 0.1 °C.

If you install this Bricklet into an enclosure and you want to measure the ambient
temperature, you may have to decrease the measured temperature by some value to
compensate for the error because of the heating inside of the enclosure.

We recommend that you leave the parts in the enclosure running for at least
24 hours such that a temperature equilibrium can be reached. After that you can measure
the temperature directly outside of enclosure and set the difference as offset.

This temperature offset is used to calculate the relative humidity and
CO2 concentration. In case the Bricklet is installed in an enclosure, we
recommend to measure and set the temperature offset to improve the accuracy of
the measurements.

It is sufficient to set the temperature offset once. The offset is saved in
non-volatile memory and is applied again after a power loss.
"""
function set_temperature_offset(device::BrickletCO2V2, offset)
    device.deviceInternal.set_temperature_offset(offset)
end

export get_temperature_offset
"""
    $(SIGNATURES)

Returns the temperature offset as set by
:func:`Set Temperature Offset`.
"""
function get_temperature_offset(device::BrickletCO2V2)
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
function set_all_values_callback_configuration(device::BrickletCO2V2, period, value_has_to_change)
    device.deviceInternal.set_all_values_callback_configuration(period, value_has_to_change)
end

export get_all_values_callback_configuration
"""
    $(SIGNATURES)

Returns the callback configuration as set by
:func:`Set All Values Callback Configuration`.
"""
function get_all_values_callback_configuration(device::BrickletCO2V2)
    return device.deviceInternal.get_all_values_callback_configuration()
end

export get_co2_concentration
"""
    $(SIGNATURES)

Returns CO2 concentration.


If you want to get the value periodically, it is recommended to use the
:cb:`CO2 Concentration` callback. You can set the callback configuration
with :func:`Set CO2 Concentration Callback Configuration`.
"""
function get_co2_concentration(device::BrickletCO2V2)
    return device.deviceInternal.get_co2_concentration()
end

export set_co2_concentration_callback_configuration
"""
    $(SIGNATURES)

The period is the period with which the :cb:`CO2 Concentration` callback is triggered
periodically. A value of 0 turns the callback off.

If the `value has to change`-parameter is set to true, the callback is only
triggered after the value has changed. If the value didn't change
within the period, the callback is triggered immediately on change.

If it is set to false, the callback is continuously triggered with the period,
independent of the value.

It is furthermore possible to constrain the callback with thresholds.

The `option`-parameter together with min/max sets a threshold for the :cb:`CO2 Concentration` callback.

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
function set_co2_concentration_callback_configuration(device::BrickletCO2V2, period, value_has_to_change, option, min, max)
    device.deviceInternal.set_co2_concentration_callback_configuration(period, value_has_to_change, option, min, max)
end

export get_co2_concentration_callback_configuration
"""
    $(SIGNATURES)

Returns the callback configuration as set by :func:`Set CO2 Concentration Callback Configuration`.
"""
function get_co2_concentration_callback_configuration(device::BrickletCO2V2)
    return device.deviceInternal.get_co2_concentration_callback_configuration()
end

export get_temperature
"""
    $(SIGNATURES)

Returns temperature.

.. note::
 The sensor is able to messure up to 120 °C. However it is only specified up to 70 °C.
 Exposing the Bricklet to higher temperatures might result in permanent damage.


If you want to get the value periodically, it is recommended to use the
:cb:`Temperature` callback. You can set the callback configuration
with :func:`Set Temperature Callback Configuration`.
"""
function get_temperature(device::BrickletCO2V2)
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
function set_temperature_callback_configuration(device::BrickletCO2V2, period, value_has_to_change, option, min, max)
    device.deviceInternal.set_temperature_callback_configuration(period, value_has_to_change, option, min, max)
end

export get_temperature_callback_configuration
"""
    $(SIGNATURES)

Returns the callback configuration as set by :func:`Set Temperature Callback Configuration`.
"""
function get_temperature_callback_configuration(device::BrickletCO2V2)
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
function get_humidity(device::BrickletCO2V2)
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
function set_humidity_callback_configuration(device::BrickletCO2V2, period, value_has_to_change, option, min, max)
    device.deviceInternal.set_humidity_callback_configuration(period, value_has_to_change, option, min, max)
end

export get_humidity_callback_configuration
"""
    $(SIGNATURES)

Returns the callback configuration as set by :func:`Set Humidity Callback Configuration`.
"""
function get_humidity_callback_configuration(device::BrickletCO2V2)
    return device.deviceInternal.get_humidity_callback_configuration()
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
function get_spitfp_error_count(device::BrickletCO2V2)
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
function set_bootloader_mode(device::BrickletCO2V2, mode)
    return device.deviceInternal.set_bootloader_mode(mode)
end

export get_bootloader_mode
"""
    $(SIGNATURES)

Returns the current bootloader mode, see :func:`Set Bootloader Mode`.
"""
function get_bootloader_mode(device::BrickletCO2V2)
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
function set_write_firmware_pointer(device::BrickletCO2V2, pointer)
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
function write_firmware(device::BrickletCO2V2, data)
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
function set_status_led_config(device::BrickletCO2V2, config)
    device.deviceInternal.set_status_led_config(config)
end

export get_status_led_config
"""
    $(SIGNATURES)

Returns the configuration as set by :func:`Set Status LED Config`
"""
function get_status_led_config(device::BrickletCO2V2)
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
function get_chip_temperature(device::BrickletCO2V2)
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
function reset(device::BrickletCO2V2)
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
function write_uid(device::BrickletCO2V2, uid)
    device.deviceInternal.write_uid(uid)
end

export read_uid
"""
    $(SIGNATURES)

Returns the current UID as an integer. Encode as
Base58 to get the usual string version.
"""
function read_uid(device::BrickletCO2V2)
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
function get_identity(device::BrickletCO2V2)
    return device.deviceInternal.get_identity()
end

export register_callback
"""
Registers the given *function* with the given *callback_id*.
"""
function register_callback(device::BrickletCO2V2, callback_id, function_)
    if isnothing(function_)
        device.registered_callbacks.pop(callback_id, None)
    else
        device.registered_callbacks[callback_id] = function_
    end
end
