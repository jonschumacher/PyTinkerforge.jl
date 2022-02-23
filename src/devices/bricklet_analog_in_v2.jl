


export BrickletAnalogInV2VoltageCallbackThreshold
struct BrickletAnalogInV2VoltageCallbackThreshold
    option::Char
    min::Integer
    max::Integer
end

export BrickletAnalogInV2AnalogValueCallbackThreshold
struct BrickletAnalogInV2AnalogValueCallbackThreshold
    option::Char
    min::Integer
    max::Integer
end

export BrickletAnalogInV2Identity
struct BrickletAnalogInV2Identity
    uid::String
    connected_uid::String
    position::Char
    hardware_version::Vector{Integer}
    firmware_version::Vector{Integer}
    device_identifier::Integer
end

export BrickletAnalogInV2
"""
Measures DC voltage between 0V and 42V
"""
mutable struct BrickletAnalogInV2 <: TinkerforgeDevice
    ipcon::IPConnection
    deviceInternal::PyObject

    """
    Creates an object with the unique device ID *uid* and adds it to
    the IP Connection *ipcon*.
    """
    function BrickletAnalogInV2(uid::String, ipcon::IPConnection)
        package = pyimport("tinkerforge.bricklet_analog_in_v2")
        deviceInternal = package.BrickletAnalogInV2(uid, ipcon.ipconInternal)

        return new(ipcon, deviceInternal)
    end
end

export get_voltage
"""
    $(SIGNATURES)

Returns the measured voltage. The resolution is approximately 10mV.

If you want to get the voltage periodically, it is recommended to use the
:cb:`Voltage` callback and set the period with
:func:`Set Voltage Callback Period`.
"""
function get_voltage(device::BrickletAnalogInV2)
    return device.deviceInternal.get_voltage()
end

export get_analog_value
"""
    $(SIGNATURES)

Returns the value as read by a 12-bit analog-to-digital converter.

If you want the analog value periodically, it is recommended to use the
:cb:`Analog Value` callback and set the period with
:func:`Set Analog Value Callback Period`.
"""
function get_analog_value(device::BrickletAnalogInV2)
    return device.deviceInternal.get_analog_value()
end

export set_voltage_callback_period
"""
    $(SIGNATURES)

Sets the period with which the :cb:`Voltage` callback is triggered
periodically. A value of 0 turns the callback off.

The :cb:`Voltage` callback is only triggered if the voltage has changed since
the last triggering.
"""
function set_voltage_callback_period(device::BrickletAnalogInV2, period)
    device.deviceInternal.set_voltage_callback_period(period)
end

export get_voltage_callback_period
"""
    $(SIGNATURES)

Returns the period as set by :func:`Set Voltage Callback Period`.
"""
function get_voltage_callback_period(device::BrickletAnalogInV2)
    return device.deviceInternal.get_voltage_callback_period()
end

export set_analog_value_callback_period
"""
    $(SIGNATURES)

Sets the period with which the :cb:`Analog Value` callback is triggered
periodically. A value of 0 turns the callback off.

The :cb:`Analog Value` callback is only triggered if the analog value has
changed since the last triggering.
"""
function set_analog_value_callback_period(device::BrickletAnalogInV2, period)
    device.deviceInternal.set_analog_value_callback_period(period)
end

export get_analog_value_callback_period
"""
    $(SIGNATURES)

Returns the period as set by :func:`Set Analog Value Callback Period`.
"""
function get_analog_value_callback_period(device::BrickletAnalogInV2)
    return device.deviceInternal.get_analog_value_callback_period()
end

export set_voltage_callback_threshold
"""
    $(SIGNATURES)

Sets the thresholds for the :cb:`Voltage Reached` callback.

The following options are possible:

.. csv-table::
 :header: "Option", "Description"
 :widths: 10, 100

 "'x'",    "Callback is turned off"
 "'o'",    "Callback is triggered when the voltage is *outside* the min and max values"
 "'i'",    "Callback is triggered when the voltage is *inside* the min and max values"
 "'<'",    "Callback is triggered when the voltage is smaller than the min value (max is ignored)"
 "'>'",    "Callback is triggered when the voltage is greater than the min value (max is ignored)"
"""
function set_voltage_callback_threshold(device::BrickletAnalogInV2, option, min, max)
    device.deviceInternal.set_voltage_callback_threshold(option, min, max)
end

export get_voltage_callback_threshold
"""
    $(SIGNATURES)

Returns the threshold as set by :func:`Set Voltage Callback Threshold`.
"""
function get_voltage_callback_threshold(device::BrickletAnalogInV2)
    return device.deviceInternal.get_voltage_callback_threshold()
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
function set_analog_value_callback_threshold(device::BrickletAnalogInV2, option, min, max)
    device.deviceInternal.set_analog_value_callback_threshold(option, min, max)
end

export get_analog_value_callback_threshold
"""
    $(SIGNATURES)

Returns the threshold as set by :func:`Set Analog Value Callback Threshold`.
"""
function get_analog_value_callback_threshold(device::BrickletAnalogInV2)
    return device.deviceInternal.get_analog_value_callback_threshold()
end

export set_debounce_period
"""
    $(SIGNATURES)

Sets the period with which the threshold callbacks

* :cb:`Voltage Reached`,
* :cb:`Analog Value Reached`

are triggered, if the thresholds

* :func:`Set Voltage Callback Threshold`,
* :func:`Set Analog Value Callback Threshold`

keep being reached.
"""
function set_debounce_period(device::BrickletAnalogInV2, debounce)
    device.deviceInternal.set_debounce_period(debounce)
end

export get_debounce_period
"""
    $(SIGNATURES)

Returns the debounce period as set by :func:`Set Debounce Period`.
"""
function get_debounce_period(device::BrickletAnalogInV2)
    return device.deviceInternal.get_debounce_period()
end

export set_moving_average
"""
    $(SIGNATURES)

Sets the length of a `moving averaging <https://en.wikipedia.org/wiki/Moving_average>`__
for the voltage.

Setting the length to 1 will turn the averaging off. With less
averaging, there is more noise on the data.
"""
function set_moving_average(device::BrickletAnalogInV2, average)
    device.deviceInternal.set_moving_average(average)
end

export get_moving_average
"""
    $(SIGNATURES)

Returns the length of the moving average as set by :func:`Set Moving Average`.
"""
function get_moving_average(device::BrickletAnalogInV2)
    return device.deviceInternal.get_moving_average()
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
function get_identity(device::BrickletAnalogInV2)
    return device.deviceInternal.get_identity()
end

export register_callback
"""
Registers the given *function* with the given *callback_id*.
"""
function register_callback(device::BrickletAnalogInV2, callback_id, function_)
    if isnothing(function_)
        device.registered_callbacks.pop(callback_id, None)
    else
        device.registered_callbacks[callback_id] = function_
    end
end
