


export BrickletTemperatureTemperatureCallbackThreshold
struct BrickletTemperatureTemperatureCallbackThreshold
    option::Char
    min::Integer
    max::Integer
end

export BrickletTemperatureIdentity
struct BrickletTemperatureIdentity
    uid::String
    connected_uid::String
    position::Char
    hardware_version::Vector{Integer}
    firmware_version::Vector{Integer}
    device_identifier::Integer
end

export BrickletTemperature
"""
Measures ambient temperature with 0.5°C accuracy
"""
mutable struct BrickletTemperature <: TinkerforgeDevice
    ipcon::IPConnection
    deviceInternal::PyObject

    """
    Creates an object with the unique device ID *uid* and adds it to
    the IP Connection *ipcon*.
    """
    function BrickletTemperature(uid::String, ipcon::IPConnection)
        package = pyimport("tinkerforge.bricklet_temperature")
        deviceInternal = package.BrickletTemperature(uid, ipcon.ipconInternal)

        return new(ipcon, deviceInternal)
    end
end

export get_temperature
"""
    $(SIGNATURES)

Returns the temperature of the sensor.

If you want to get the temperature periodically, it is recommended
to use the :cb:`Temperature` callback and set the period with
:func:`Set Temperature Callback Period`.
"""
function get_temperature(device::BrickletTemperature)
    return device.deviceInternal.get_temperature()
end

export set_temperature_callback_period
"""
    $(SIGNATURES)

Sets the period with which the :cb:`Temperature` callback is triggered
periodically. A value of 0 turns the callback off.

The :cb:`Temperature` callback is only triggered if the temperature has changed
since the last triggering.
"""
function set_temperature_callback_period(device::BrickletTemperature, period)
    device.deviceInternal.set_temperature_callback_period(period)
end

export get_temperature_callback_period
"""
    $(SIGNATURES)

Returns the period as set by :func:`Set Temperature Callback Period`.
"""
function get_temperature_callback_period(device::BrickletTemperature)
    return device.deviceInternal.get_temperature_callback_period()
end

export set_temperature_callback_threshold
"""
    $(SIGNATURES)

Sets the thresholds for the :cb:`Temperature Reached` callback.

The following options are possible:

.. csv-table::
 :header: "Option", "Description"
 :widths: 10, 100

 "'x'",    "Callback is turned off"
 "'o'",    "Callback is triggered when the temperature is *outside* the min and max values"
 "'i'",    "Callback is triggered when the temperature is *inside* the min and max values"
 "'<'",    "Callback is triggered when the temperature is smaller than the min value (max is ignored)"
 "'>'",    "Callback is triggered when the temperature is greater than the min value (max is ignored)"
"""
function set_temperature_callback_threshold(device::BrickletTemperature, option, min, max)
    device.deviceInternal.set_temperature_callback_threshold(option, min, max)
end

export get_temperature_callback_threshold
"""
    $(SIGNATURES)

Returns the threshold as set by :func:`Set Temperature Callback Threshold`.
"""
function get_temperature_callback_threshold(device::BrickletTemperature)
    return device.deviceInternal.get_temperature_callback_threshold()
end

export set_debounce_period
"""
    $(SIGNATURES)

Sets the period with which the threshold callback

* :cb:`Temperature Reached`

is triggered, if the threshold

* :func:`Set Temperature Callback Threshold`

keeps being reached.
"""
function set_debounce_period(device::BrickletTemperature, debounce)
    device.deviceInternal.set_debounce_period(debounce)
end

export get_debounce_period
"""
    $(SIGNATURES)

Returns the debounce period as set by :func:`Set Debounce Period`.
"""
function get_debounce_period(device::BrickletTemperature)
    return device.deviceInternal.get_debounce_period()
end

export set_i2c_mode
"""
    $(SIGNATURES)

Sets the I2C mode. Possible modes are:

* 0: Fast (400kHz)
* 1: Slow (100kHz)

If you have problems with obvious outliers in the
Temperature Bricklet measurements, they may be caused by EMI issues.
In this case it may be helpful to lower the I2C speed.

It is however not recommended to lower the I2C speed in applications where
a high throughput needs to be achieved.

.. versionadded:: 2.0.1\$nbsp;(Plugin)
"""
function set_i2c_mode(device::BrickletTemperature, mode)
    device.deviceInternal.set_i2c_mode(mode)
end

export get_i2c_mode
"""
    $(SIGNATURES)

Returns the I2C mode as set by :func:`Set I2C Mode`.

.. versionadded:: 2.0.1\$nbsp;(Plugin)
"""
function get_i2c_mode(device::BrickletTemperature)
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
function get_identity(device::BrickletTemperature)
    return device.deviceInternal.get_identity()
end

export register_callback
"""
Registers the given *function* with the given *callback_id*.
"""
function register_callback(device::BrickletTemperature, callback_id, function_)
    if isnothing(function_)
        device.registered_callbacks.pop(callback_id, None)
    else
        device.registered_callbacks[callback_id] = function_
    end
end
