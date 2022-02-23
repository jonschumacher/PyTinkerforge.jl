


export BrickletBarometerV2AirPressureCallbackConfiguration
struct BrickletBarometerV2AirPressureCallbackConfiguration
    period::Integer
    value_has_to_change::Bool
    option::Char
    min::Integer
    max::Integer
end

export BrickletBarometerV2AltitudeCallbackConfiguration
struct BrickletBarometerV2AltitudeCallbackConfiguration
    period::Integer
    value_has_to_change::Bool
    option::Char
    min::Integer
    max::Integer
end

export BrickletBarometerV2TemperatureCallbackConfiguration
struct BrickletBarometerV2TemperatureCallbackConfiguration
    period::Integer
    value_has_to_change::Bool
    option::Char
    min::Integer
    max::Integer
end

export BrickletBarometerV2MovingAverageConfiguration
struct BrickletBarometerV2MovingAverageConfiguration
    moving_average_length_air_pressure::Integer
    moving_average_length_temperature::Integer
end

export BrickletBarometerV2Calibration
struct BrickletBarometerV2Calibration
    measured_air_pressure::Integer
    actual_air_pressure::Integer
end

export BrickletBarometerV2SensorConfiguration
struct BrickletBarometerV2SensorConfiguration
    data_rate::Integer
    air_pressure_low_pass_filter::Integer
end

export BrickletBarometerV2SPITFPErrorCount
struct BrickletBarometerV2SPITFPErrorCount
    error_count_ack_checksum::Integer
    error_count_message_checksum::Integer
    error_count_frame::Integer
    error_count_overflow::Integer
end

export BrickletBarometerV2Identity
struct BrickletBarometerV2Identity
    uid::String
    connected_uid::String
    position::Char
    hardware_version::Vector{Integer}
    firmware_version::Vector{Integer}
    device_identifier::Integer
end

export BrickletBarometerV2
"""
Measures air pressure and altitude changes
"""
mutable struct BrickletBarometerV2 <: TinkerforgeDevice
    ipcon::IPConnection
    deviceInternal::PyObject

    """
    Creates an object with the unique device ID *uid* and adds it to
    the IP Connection *ipcon*.
    """
    function BrickletBarometerV2(uid::String, ipcon::IPConnection)
        package = pyimport("tinkerforge.bricklet_barometer_v2")
        deviceInternal = package.BrickletBarometerV2(uid, ipcon.ipconInternal)

        return new(ipcon, deviceInternal)
    end
end

export get_air_pressure
"""
    $(SIGNATURES)

Returns the measured air pressure.


If you want to get the value periodically, it is recommended to use the
:cb:`Air Pressure` callback. You can set the callback configuration
with :func:`Set Air Pressure Callback Configuration`.
"""
function get_air_pressure(device::BrickletBarometerV2)
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
function set_air_pressure_callback_configuration(device::BrickletBarometerV2, period, value_has_to_change, option, min, max)
    device.deviceInternal.set_air_pressure_callback_configuration(period, value_has_to_change, option, min, max)
end

export get_air_pressure_callback_configuration
"""
    $(SIGNATURES)

Returns the callback configuration as set by :func:`Set Air Pressure Callback Configuration`.
"""
function get_air_pressure_callback_configuration(device::BrickletBarometerV2)
    return device.deviceInternal.get_air_pressure_callback_configuration()
end

export get_altitude
"""
    $(SIGNATURES)

Returns the relative altitude of the air pressure sensor. The value
is calculated based on the difference between the
current air pressure and the reference air pressure that can be set
with :func:`Set Reference Air Pressure`.


If you want to get the value periodically, it is recommended to use the
:cb:`Altitude` callback. You can set the callback configuration
with :func:`Set Altitude Callback Configuration`.
"""
function get_altitude(device::BrickletBarometerV2)
    return device.deviceInternal.get_altitude()
end

export set_altitude_callback_configuration
"""
    $(SIGNATURES)

The period is the period with which the :cb:`Altitude` callback is triggered
periodically. A value of 0 turns the callback off.

If the `value has to change`-parameter is set to true, the callback is only
triggered after the value has changed. If the value didn't change
within the period, the callback is triggered immediately on change.

If it is set to false, the callback is continuously triggered with the period,
independent of the value.

It is furthermore possible to constrain the callback with thresholds.

The `option`-parameter together with min/max sets a threshold for the :cb:`Altitude` callback.

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
function set_altitude_callback_configuration(device::BrickletBarometerV2, period, value_has_to_change, option, min, max)
    device.deviceInternal.set_altitude_callback_configuration(period, value_has_to_change, option, min, max)
end

export get_altitude_callback_configuration
"""
    $(SIGNATURES)

Returns the callback configuration as set by :func:`Set Altitude Callback Configuration`.
"""
function get_altitude_callback_configuration(device::BrickletBarometerV2)
    return device.deviceInternal.get_altitude_callback_configuration()
end

export get_temperature
"""
    $(SIGNATURES)

Returns the temperature of the air pressure sensor.

This temperature is used internally for temperature compensation
of the air pressure measurement. It is not as accurate as the
temperature measured by the :ref:`temperature_v2_bricklet` or the
:ref:`temperature_ir_v2_bricklet`.


If you want to get the value periodically, it is recommended to use the
:cb:`Temperature` callback. You can set the callback configuration
with :func:`Set Temperature Callback Configuration`.
"""
function get_temperature(device::BrickletBarometerV2)
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
function set_temperature_callback_configuration(device::BrickletBarometerV2, period, value_has_to_change, option, min, max)
    device.deviceInternal.set_temperature_callback_configuration(period, value_has_to_change, option, min, max)
end

export get_temperature_callback_configuration
"""
    $(SIGNATURES)

Returns the callback configuration as set by :func:`Set Temperature Callback Configuration`.
"""
function get_temperature_callback_configuration(device::BrickletBarometerV2)
    return device.deviceInternal.get_temperature_callback_configuration()
end

export set_moving_average_configuration
"""
    $(SIGNATURES)

Sets the length of a `moving averaging <https://en.wikipedia.org/wiki/Moving_average>`__
for the air pressure and temperature measurements.

Setting the length to 1 will turn the averaging off. With less
averaging, there is more noise on the data.

If you want to do long term measurements the longest moving average will give
the cleanest results.
"""
function set_moving_average_configuration(device::BrickletBarometerV2, moving_average_length_air_pressure, moving_average_length_temperature)
    device.deviceInternal.set_moving_average_configuration(moving_average_length_air_pressure, moving_average_length_temperature)
end

export get_moving_average_configuration
"""
    $(SIGNATURES)

Returns the moving average configuration as set by
:func:`Set Moving Average Configuration`.
"""
function get_moving_average_configuration(device::BrickletBarometerV2)
    return device.deviceInternal.get_moving_average_configuration()
end

export set_reference_air_pressure
"""
    $(SIGNATURES)

Sets the reference air pressure for the altitude calculation.
Setting the reference to the
current air pressure results in a calculated altitude of 0mm. Passing 0 is
a shortcut for passing the current air pressure as reference.

Well known reference values are the Q codes
`QNH <https://en.wikipedia.org/wiki/QNH>`__ and
`QFE <https://en.wikipedia.org/wiki/Mean_sea_level_pressure#Mean_sea_level_pressure>`__
used in aviation.
"""
function set_reference_air_pressure(device::BrickletBarometerV2, air_pressure)
    device.deviceInternal.set_reference_air_pressure(air_pressure)
end

export get_reference_air_pressure
"""
    $(SIGNATURES)

Returns the reference air pressure as set by :func:`Set Reference Air Pressure`.
"""
function get_reference_air_pressure(device::BrickletBarometerV2)
    return device.deviceInternal.get_reference_air_pressure()
end

export set_calibration
"""
    $(SIGNATURES)

Sets the one point calibration (OPC) values for the air pressure measurement.

Before the Bricklet can be calibrated any previous calibration has to be removed
by setting ``measured air pressure`` and ``actual air pressure`` to 0.

Then the current air pressure has to be measured using the Bricklet
(``measured air pressure``) and with an accurate reference barometer
(``actual air pressure``) at the same time and passed to this function.

After proper calibration the air pressure measurement can achieve an accuracy
up to 0.2 hPa.

The calibration is saved in the EEPROM of the Bricklet and only needs to be
configured once.
"""
function set_calibration(device::BrickletBarometerV2, measured_air_pressure, actual_air_pressure)
    device.deviceInternal.set_calibration(measured_air_pressure, actual_air_pressure)
end

export get_calibration
"""
    $(SIGNATURES)

Returns the air pressure one point calibration values as set by
:func:`Set Calibration`.
"""
function get_calibration(device::BrickletBarometerV2)
    return device.deviceInternal.get_calibration()
end

export set_sensor_configuration
"""
    $(SIGNATURES)

Configures the data rate and air pressure low pass filter. The low pass filter
cut-off frequency (if enabled) can be set to 1/9th or 1/20th of the configure
data rate to decrease the noise on the air pressure data.

The low pass filter configuration only applies to the air pressure measurement.
There is no low pass filter for the temperature measurement.

A higher data rate will result in a less precise temperature because of
self-heating of the sensor. If the accuracy of the temperature reading is
important to you, we would recommend the 1Hz data rate.
"""
function set_sensor_configuration(device::BrickletBarometerV2, data_rate, air_pressure_low_pass_filter)
    device.deviceInternal.set_sensor_configuration(data_rate, air_pressure_low_pass_filter)
end

export get_sensor_configuration
"""
    $(SIGNATURES)

Returns the sensor configuration as set by :func:`Set Sensor Configuration`.
"""
function get_sensor_configuration(device::BrickletBarometerV2)
    return device.deviceInternal.get_sensor_configuration()
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
function get_spitfp_error_count(device::BrickletBarometerV2)
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
function set_bootloader_mode(device::BrickletBarometerV2, mode)
    return device.deviceInternal.set_bootloader_mode(mode)
end

export get_bootloader_mode
"""
    $(SIGNATURES)

Returns the current bootloader mode, see :func:`Set Bootloader Mode`.
"""
function get_bootloader_mode(device::BrickletBarometerV2)
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
function set_write_firmware_pointer(device::BrickletBarometerV2, pointer)
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
function write_firmware(device::BrickletBarometerV2, data)
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
function set_status_led_config(device::BrickletBarometerV2, config)
    device.deviceInternal.set_status_led_config(config)
end

export get_status_led_config
"""
    $(SIGNATURES)

Returns the configuration as set by :func:`Set Status LED Config`
"""
function get_status_led_config(device::BrickletBarometerV2)
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
function get_chip_temperature(device::BrickletBarometerV2)
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
function reset(device::BrickletBarometerV2)
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
function write_uid(device::BrickletBarometerV2, uid)
    device.deviceInternal.write_uid(uid)
end

export read_uid
"""
    $(SIGNATURES)

Returns the current UID as an integer. Encode as
Base58 to get the usual string version.
"""
function read_uid(device::BrickletBarometerV2)
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
function get_identity(device::BrickletBarometerV2)
    return device.deviceInternal.get_identity()
end

export register_callback
"""
Registers the given *function* with the given *callback_id*.
"""
function register_callback(device::BrickletBarometerV2, callback_id, function_)
    if isnothing(function_)
        device.registered_callbacks.pop(callback_id, None)
    else
        device.registered_callbacks[callback_id] = function_
    end
end
