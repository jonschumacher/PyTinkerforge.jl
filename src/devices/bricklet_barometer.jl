


export BrickletBarometerAirPressureCallbackThreshold
struct BrickletBarometerAirPressureCallbackThreshold
    option::Char
    min::Integer
    max::Integer
end

export BrickletBarometerAltitudeCallbackThreshold
struct BrickletBarometerAltitudeCallbackThreshold
    option::Char
    min::Integer
    max::Integer
end

export BrickletBarometerAveraging
struct BrickletBarometerAveraging
    moving_average_pressure::Integer
    average_pressure::Integer
    average_temperature::Integer
end

export BrickletBarometerIdentity
struct BrickletBarometerIdentity
    uid::String
    connected_uid::String
    position::Char
    hardware_version::Vector{Integer}
    firmware_version::Vector{Integer}
    device_identifier::Integer
end

export BrickletBarometer
"""
Measures air pressure and altitude changes
"""
mutable struct BrickletBarometer <: TinkerforgeDevice
    ipcon::IPConnection
    deviceInternal::PyObject

    """
    Creates an object with the unique device ID *uid* and adds it to
    the IP Connection *ipcon*.
    """
    function BrickletBarometer(uid::String, ipcon::IPConnection)
        package = pyimport("tinkerforge.bricklet_barometer")
        deviceInternal = package.BrickletBarometer(uid, ipcon.ipconInternal)

        return new(ipcon, deviceInternal)
    end
end

export get_air_pressure
"""
    $(SIGNATURES)

Returns the air pressure of the air pressure sensor.

If you want to get the air pressure periodically, it is recommended to use the
:cb:`Air Pressure` callback and set the period with
:func:`Set Air Pressure Callback Period`.
"""
function get_air_pressure(device::BrickletBarometer)
    return device.deviceInternal.get_air_pressure()
end

export get_altitude
"""
    $(SIGNATURES)

Returns the relative altitude of the air pressure sensor. The value is
calculated based on the difference between the current air pressure
and the reference air pressure that can be set with :func:`Set Reference Air Pressure`.

If you want to get the altitude periodically, it is recommended to use the
:cb:`Altitude` callback and set the period with
:func:`Set Altitude Callback Period`.
"""
function get_altitude(device::BrickletBarometer)
    return device.deviceInternal.get_altitude()
end

export set_air_pressure_callback_period
"""
    $(SIGNATURES)

Sets the period with which the :cb:`Air Pressure` callback is triggered
periodically. A value of 0 turns the callback off.

The :cb:`Air Pressure` callback is only triggered if the air pressure has
changed since the last triggering.
"""
function set_air_pressure_callback_period(device::BrickletBarometer, period)
    device.deviceInternal.set_air_pressure_callback_period(period)
end

export get_air_pressure_callback_period
"""
    $(SIGNATURES)

Returns the period as set by :func:`Set Air Pressure Callback Period`.
"""
function get_air_pressure_callback_period(device::BrickletBarometer)
    return device.deviceInternal.get_air_pressure_callback_period()
end

export set_altitude_callback_period
"""
    $(SIGNATURES)

Sets the period with which the :cb:`Altitude` callback is triggered
periodically. A value of 0 turns the callback off.

The :cb:`Altitude` callback is only triggered if the altitude has changed since
the last triggering.
"""
function set_altitude_callback_period(device::BrickletBarometer, period)
    device.deviceInternal.set_altitude_callback_period(period)
end

export get_altitude_callback_period
"""
    $(SIGNATURES)

Returns the period as set by :func:`Set Altitude Callback Period`.
"""
function get_altitude_callback_period(device::BrickletBarometer)
    return device.deviceInternal.get_altitude_callback_period()
end

export set_air_pressure_callback_threshold
"""
    $(SIGNATURES)

Sets the thresholds for the :cb:`Air Pressure Reached` callback.

The following options are possible:

.. csv-table::
 :header: "Option", "Description"
 :widths: 10, 100

 "'x'",    "Callback is turned off"
 "'o'",    "Callback is triggered when the air pressure is *outside* the min and max values"
 "'i'",    "Callback is triggered when the air pressure is *inside* the min and max values"
 "'<'",    "Callback is triggered when the air pressure is smaller than the min value (max is ignored)"
 "'>'",    "Callback is triggered when the air pressure is greater than the min value (max is ignored)"
"""
function set_air_pressure_callback_threshold(device::BrickletBarometer, option, min, max)
    device.deviceInternal.set_air_pressure_callback_threshold(option, min, max)
end

export get_air_pressure_callback_threshold
"""
    $(SIGNATURES)

Returns the threshold as set by :func:`Set Air Pressure Callback Threshold`.
"""
function get_air_pressure_callback_threshold(device::BrickletBarometer)
    return device.deviceInternal.get_air_pressure_callback_threshold()
end

export set_altitude_callback_threshold
"""
    $(SIGNATURES)

Sets the thresholds for the :cb:`Altitude Reached` callback.

The following options are possible:

.. csv-table::
 :header: "Option", "Description"
 :widths: 10, 100

 "'x'",    "Callback is turned off"
 "'o'",    "Callback is triggered when the altitude is *outside* the min and max values"
 "'i'",    "Callback is triggered when the altitude is *inside* the min and max values"
 "'<'",    "Callback is triggered when the altitude is smaller than the min value (max is ignored)"
 "'>'",    "Callback is triggered when the altitude is greater than the min value (max is ignored)"
"""
function set_altitude_callback_threshold(device::BrickletBarometer, option, min, max)
    device.deviceInternal.set_altitude_callback_threshold(option, min, max)
end

export get_altitude_callback_threshold
"""
    $(SIGNATURES)

Returns the threshold as set by :func:`Set Altitude Callback Threshold`.
"""
function get_altitude_callback_threshold(device::BrickletBarometer)
    return device.deviceInternal.get_altitude_callback_threshold()
end

export set_debounce_period
"""
    $(SIGNATURES)

Sets the period with which the threshold callbacks

* :cb:`Air Pressure Reached`,
* :cb:`Altitude Reached`

are triggered, if the thresholds

* :func:`Set Air Pressure Callback Threshold`,
* :func:`Set Altitude Callback Threshold`

keep being reached.
"""
function set_debounce_period(device::BrickletBarometer, debounce)
    device.deviceInternal.set_debounce_period(debounce)
end

export get_debounce_period
"""
    $(SIGNATURES)

Returns the debounce period as set by :func:`Set Debounce Period`.
"""
function get_debounce_period(device::BrickletBarometer)
    return device.deviceInternal.get_debounce_period()
end

export set_reference_air_pressure
"""
    $(SIGNATURES)

Sets the reference air pressure for the altitude calculation.
Setting the reference to the current air pressure results in a calculated
altitude of 0cm. Passing 0 is a shortcut for passing the current air pressure as
reference.

Well known reference values are the Q codes
`QNH <https://en.wikipedia.org/wiki/QNH>`__ and
`QFE <https://en.wikipedia.org/wiki/Mean_sea_level_pressure#Mean_sea_level_pressure>`__
used in aviation.
"""
function set_reference_air_pressure(device::BrickletBarometer, air_pressure)
    device.deviceInternal.set_reference_air_pressure(air_pressure)
end

export get_chip_temperature
"""
    $(SIGNATURES)

Returns the temperature of the air pressure sensor.

This temperature is used internally for temperature compensation of the air
pressure measurement. It is not as accurate as the temperature measured by the
:ref:`temperature_bricklet` or the :ref:`temperature_ir_bricklet`.
"""
function get_chip_temperature(device::BrickletBarometer)
    return device.deviceInternal.get_chip_temperature()
end

export get_reference_air_pressure
"""
    $(SIGNATURES)

Returns the reference air pressure as set by :func:`Set Reference Air Pressure`.
"""
function get_reference_air_pressure(device::BrickletBarometer)
    return device.deviceInternal.get_reference_air_pressure()
end

export set_averaging
"""
    $(SIGNATURES)

Sets the different averaging parameters. It is possible to set
the length of a normal averaging for the temperature and pressure,
as well as an additional length of a
`moving average <https://en.wikipedia.org/wiki/Moving_average>`__
for the pressure. The moving average is calculated from the normal
averages.  There is no moving average for the temperature.

Setting the all three parameters to 0 will turn the averaging
completely off. If the averaging is off, there is lots of noise
on the data, but the data is without delay. Thus we recommend
to turn the averaging off if the Barometer Bricklet data is
to be used for sensor fusion with other sensors.

.. versionadded:: 2.0.1\$nbsp;(Plugin)
"""
function set_averaging(device::BrickletBarometer, moving_average_pressure, average_pressure, average_temperature)
    device.deviceInternal.set_averaging(moving_average_pressure, average_pressure, average_temperature)
end

export get_averaging
"""
    $(SIGNATURES)

Returns the averaging configuration as set by :func:`Set Averaging`.

.. versionadded:: 2.0.1\$nbsp;(Plugin)
"""
function get_averaging(device::BrickletBarometer)
    return device.deviceInternal.get_averaging()
end

export set_i2c_mode
"""
    $(SIGNATURES)

Sets the I2C mode. Possible modes are:

* 0: Fast (400kHz)
* 1: Slow (100kHz)

If you have problems with obvious outliers in the
Barometer Bricklet measurements, they may be caused by EMI issues.
In this case it may be helpful to lower the I2C speed.

It is however not recommended to lower the I2C speed in applications where
a high throughput needs to be achieved.

.. versionadded:: 2.0.3\$nbsp;(Plugin)
"""
function set_i2c_mode(device::BrickletBarometer, mode)
    device.deviceInternal.set_i2c_mode(mode)
end

export get_i2c_mode
"""
    $(SIGNATURES)

Returns the I2C mode as set by :func:`Set I2C Mode`.

.. versionadded:: 2.0.3\$nbsp;(Plugin)
"""
function get_i2c_mode(device::BrickletBarometer)
    return device.deviceInternal.get_i2c_mode()
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
function get_identity(device::BrickletBarometer)
    return device.deviceInternal.get_identity()
end

export register_callback
"""
Registers the given *function* with the given *callback_id*.
"""
function register_callback(device::BrickletBarometer, callback_id, function_)
    if isnothing(function_)
        device.registered_callbacks.pop(callback_id, None)
    else
        device.registered_callbacks[callback_id] = function_
    end
end
