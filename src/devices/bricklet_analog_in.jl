


export BrickletAnalogInVoltageCallbackThreshold
struct BrickletAnalogInVoltageCallbackThreshold
    option::Char
    min::Integer
    max::Integer
end

export BrickletAnalogInAnalogValueCallbackThreshold
struct BrickletAnalogInAnalogValueCallbackThreshold
    option::Char
    min::Integer
    max::Integer
end

export BrickletAnalogInIdentity
struct BrickletAnalogInIdentity
    uid::String
    connected_uid::String
    position::Char
    hardware_version::Vector{Integer}
    firmware_version::Vector{Integer}
    device_identifier::Integer
end

export BrickletAnalogIn
"""
Measures DC voltage between 0V and 45V
"""
mutable struct BrickletAnalogIn <: TinkerforgeDevice
    ipcon::IPConnection
    deviceInternal::PyObject

    """
    Creates an object with the unique device ID *uid* and adds it to
    the IP Connection *ipcon*.
    """
    function BrickletAnalogIn(uid::String, ipcon::IPConnection)
        package = pyimport("tinkerforge.bricklet_analog_in")
        deviceInternal = package.BrickletAnalogIn(uid, ipcon.ipconInternal)

        return new(ipcon, deviceInternal)
    end
end

export get_voltage
"""
    $(SIGNATURES)

Returns the voltage of the sensor. The resolution between 0 and 6V is about 2mV.
Between 6 and 45V the resolution is about 10mV.

If you want to get the voltage periodically, it is recommended to use the
:cb:`Voltage` callback and set the period with
:func:`Set Voltage Callback Period`.
"""
function get_voltage(device::BrickletAnalogIn)
    return device.deviceInternal.get_voltage()
end

export get_analog_value
"""
    $(SIGNATURES)

Returns the value as read by a 12-bit analog-to-digital converter.

.. note::
 The value returned by :func:`Get Voltage` is averaged over several samples
 to yield less noise, while :func:`Get Analog Value` gives back raw
 unfiltered analog values. The only reason to use :func:`Get Analog Value` is,
 if you need the full resolution of the analog-to-digital converter.

If you want the analog value periodically, it is recommended to use the
:cb:`Analog Value` callback and set the period with
:func:`Set Analog Value Callback Period`.
"""
function get_analog_value(device::BrickletAnalogIn)
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
function set_voltage_callback_period(device::BrickletAnalogIn, period)
    device.deviceInternal.set_voltage_callback_period(period)
end

export get_voltage_callback_period
"""
    $(SIGNATURES)

Returns the period as set by :func:`Set Voltage Callback Period`.
"""
function get_voltage_callback_period(device::BrickletAnalogIn)
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
function set_analog_value_callback_period(device::BrickletAnalogIn, period)
    device.deviceInternal.set_analog_value_callback_period(period)
end

export get_analog_value_callback_period
"""
    $(SIGNATURES)

Returns the period as set by :func:`Set Analog Value Callback Period`.
"""
function get_analog_value_callback_period(device::BrickletAnalogIn)
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
function set_voltage_callback_threshold(device::BrickletAnalogIn, option, min, max)
    device.deviceInternal.set_voltage_callback_threshold(option, min, max)
end

export get_voltage_callback_threshold
"""
    $(SIGNATURES)

Returns the threshold as set by :func:`Set Voltage Callback Threshold`.
"""
function get_voltage_callback_threshold(device::BrickletAnalogIn)
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
function set_analog_value_callback_threshold(device::BrickletAnalogIn, option, min, max)
    device.deviceInternal.set_analog_value_callback_threshold(option, min, max)
end

export get_analog_value_callback_threshold
"""
    $(SIGNATURES)

Returns the threshold as set by :func:`Set Analog Value Callback Threshold`.
"""
function get_analog_value_callback_threshold(device::BrickletAnalogIn)
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
function set_debounce_period(device::BrickletAnalogIn, debounce)
    device.deviceInternal.set_debounce_period(debounce)
end

export get_debounce_period
"""
    $(SIGNATURES)

Returns the debounce period as set by :func:`Set Debounce Period`.
"""
function get_debounce_period(device::BrickletAnalogIn)
    return device.deviceInternal.get_debounce_period()
end

export set_range
"""
    $(SIGNATURES)

Sets the measurement range. Possible ranges:

* 0: Automatically switched
* 1: 0V - 6.05V, ~1.48mV resolution
* 2: 0V - 10.32V, ~2.52mV resolution
* 3: 0V - 36.30V, ~8.86mV resolution
* 4: 0V - 45.00V, ~11.25mV resolution
* 5: 0V - 3.3V, ~0.81mV resolution, new in version 2.0.3\$nbsp;(Plugin)

.. versionadded:: 2.0.1\$nbsp;(Plugin)
"""
function set_range(device::BrickletAnalogIn, range)
    device.deviceInternal.set_range(range)
end

export get_range
"""
    $(SIGNATURES)

Returns the measurement range as set by :func:`Set Range`.

.. versionadded:: 2.0.1\$nbsp;(Plugin)
"""
function get_range(device::BrickletAnalogIn)
    return device.deviceInternal.get_range()
end

export set_averaging
"""
    $(SIGNATURES)

Set the length of a averaging for the voltage value.

Setting the length to 0 will turn the averaging completely off. If the
averaging is off, there is more noise on the data, but the data is without
delay.

.. versionadded:: 2.0.3\$nbsp;(Plugin)
"""
function set_averaging(device::BrickletAnalogIn, average)
    device.deviceInternal.set_averaging(average)
end

export get_averaging
"""
    $(SIGNATURES)

Returns the averaging configuration as set by :func:`Set Averaging`.

.. versionadded:: 2.0.3\$nbsp;(Plugin)
"""
function get_averaging(device::BrickletAnalogIn)
    return device.deviceInternal.get_averaging()
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
function get_identity(device::BrickletAnalogIn)
    return device.deviceInternal.get_identity()
end

export register_callback
"""
Registers the given *function* with the given *callback_id*.
"""
function register_callback(device::BrickletAnalogIn, callback_id, function_)
    if isnothing(function_)
        device.registered_callbacks.pop(callback_id, None)
    else
        device.registered_callbacks[callback_id] = function_
    end
end
