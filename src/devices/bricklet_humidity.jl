


export BrickletHumidityHumidityCallbackThreshold
struct BrickletHumidityHumidityCallbackThreshold
    option::Char
    min::Integer
    max::Integer
end

export BrickletHumidityAnalogValueCallbackThreshold
struct BrickletHumidityAnalogValueCallbackThreshold
    option::Char
    min::Integer
    max::Integer
end

export BrickletHumidityIdentity
struct BrickletHumidityIdentity
    uid::String
    connected_uid::String
    position::Char
    hardware_version::Vector{Integer}
    firmware_version::Vector{Integer}
    device_identifier::Integer
end

export BrickletHumidity
"""
Measures relative humidity
"""
mutable struct BrickletHumidity <: TinkerforgeDevice
    ipcon::IPConnection
    deviceInternal::PyObject

    """
    Creates an object with the unique device ID *uid* and adds it to
    the IP Connection *ipcon*.
    """
    function BrickletHumidity(uid::String, ipcon::IPConnection)
        package = pyimport("tinkerforge.bricklet_humidity")
        deviceInternal = package.BrickletHumidity(uid, ipcon.ipconInternal)

        return new(ipcon, deviceInternal)
    end
end

export get_humidity
"""
    $(SIGNATURES)

Returns the humidity of the sensor.

If you want to get the humidity periodically, it is recommended to use the
:cb:`Humidity` callback and set the period with
:func:`Set Humidity Callback Period`.
"""
function get_humidity(device::BrickletHumidity)
    return device.deviceInternal.get_humidity()
end

export get_analog_value
"""
    $(SIGNATURES)

Returns the value as read by a 12-bit analog-to-digital converter.

.. note::
 The value returned by :func:`Get Humidity` is averaged over several samples
 to yield less noise, while :func:`Get Analog Value` gives back raw
 unfiltered analog values. The returned humidity value is calibrated for
 room temperatures, if you use the sensor in extreme cold or extreme
 warm environments, you might want to calculate the humidity from
 the analog value yourself. See the `HIH 5030 datasheet
 <https://github.com/Tinkerforge/humidity-bricklet/raw/master/datasheets/hih-5030.pdf>`__.

If you want the analog value periodically, it is recommended to use the
:cb:`Analog Value` callback and set the period with
:func:`Set Analog Value Callback Period`.
"""
function get_analog_value(device::BrickletHumidity)
    return device.deviceInternal.get_analog_value()
end

export set_humidity_callback_period
"""
    $(SIGNATURES)

Sets the period with which the :cb:`Humidity` callback is triggered
periodically. A value of 0 turns the callback off.

The :cb:`Humidity` callback is only triggered if the humidity has changed
since the last triggering.
"""
function set_humidity_callback_period(device::BrickletHumidity, period)
    device.deviceInternal.set_humidity_callback_period(period)
end

export get_humidity_callback_period
"""
    $(SIGNATURES)

Returns the period as set by :func:`Set Humidity Callback Period`.
"""
function get_humidity_callback_period(device::BrickletHumidity)
    return device.deviceInternal.get_humidity_callback_period()
end

export set_analog_value_callback_period
"""
    $(SIGNATURES)

Sets the period with which the :cb:`Analog Value` callback is triggered
periodically. A value of 0 turns the callback off.

The :cb:`Analog Value` callback is only triggered if the analog value has
changed since the last triggering.
"""
function set_analog_value_callback_period(device::BrickletHumidity, period)
    device.deviceInternal.set_analog_value_callback_period(period)
end

export get_analog_value_callback_period
"""
    $(SIGNATURES)

Returns the period as set by :func:`Set Analog Value Callback Period`.
"""
function get_analog_value_callback_period(device::BrickletHumidity)
    return device.deviceInternal.get_analog_value_callback_period()
end

export set_humidity_callback_threshold
"""
    $(SIGNATURES)

Sets the thresholds for the :cb:`Humidity Reached` callback.

The following options are possible:

.. csv-table::
 :header: "Option", "Description"
 :widths: 10, 100

 "'x'",    "Callback is turned off"
 "'o'",    "Callback is triggered when the humidity is *outside* the min and max values"
 "'i'",    "Callback is triggered when the humidity is *inside* the min and max values"
 "'<'",    "Callback is triggered when the humidity is smaller than the min value (max is ignored)"
 "'>'",    "Callback is triggered when the humidity is greater than the min value (max is ignored)"
"""
function set_humidity_callback_threshold(device::BrickletHumidity, option, min, max)
    device.deviceInternal.set_humidity_callback_threshold(option, min, max)
end

export get_humidity_callback_threshold
"""
    $(SIGNATURES)

Returns the threshold as set by :func:`Set Humidity Callback Threshold`.
"""
function get_humidity_callback_threshold(device::BrickletHumidity)
    return device.deviceInternal.get_humidity_callback_threshold()
end

export set_analog_value_callback_threshold
"""
    $(SIGNATURES)

Sets the thresholds for the :cb:`Analog Value Reached` callback.

The following options are possible:

.. csv-table::
 :header: "Option", "Description"
 :widths: 10, 100

 "'x'",    "Callback is turned off"
 "'o'",    "Callback is triggered when the analog value is *outside* the min and max values"
 "'i'",    "Callback is triggered when the analog value is *inside* the min and max values"
 "'<'",    "Callback is triggered when the analog value is smaller than the min value (max is ignored)"
 "'>'",    "Callback is triggered when the analog value is greater than the min value (max is ignored)"
"""
function set_analog_value_callback_threshold(device::BrickletHumidity, option, min, max)
    device.deviceInternal.set_analog_value_callback_threshold(option, min, max)
end

export get_analog_value_callback_threshold
"""
    $(SIGNATURES)

Returns the threshold as set by :func:`Set Analog Value Callback Threshold`.
"""
function get_analog_value_callback_threshold(device::BrickletHumidity)
    return device.deviceInternal.get_analog_value_callback_threshold()
end

export set_debounce_period
"""
    $(SIGNATURES)

Sets the period with which the threshold callbacks

* :cb:`Humidity Reached`,
* :cb:`Analog Value Reached`

are triggered, if the thresholds

* :func:`Set Humidity Callback Threshold`,
* :func:`Set Analog Value Callback Threshold`

keep being reached.
"""
function set_debounce_period(device::BrickletHumidity, debounce)
    device.deviceInternal.set_debounce_period(debounce)
end

export get_debounce_period
"""
    $(SIGNATURES)

Returns the debounce period as set by :func:`Set Debounce Period`.
"""
function get_debounce_period(device::BrickletHumidity)
    return device.deviceInternal.get_debounce_period()
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
function get_identity(device::BrickletHumidity)
    return device.deviceInternal.get_identity()
end

export register_callback
"""
Registers the given *function* with the given *callback_id*.
"""
function register_callback(device::BrickletHumidity, callback_id, function_)
    if isnothing(function_)
        device.registered_callbacks.pop(callback_id, None)
    else
        device.registered_callbacks[callback_id] = function_
    end
end
