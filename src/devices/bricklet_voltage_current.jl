


export BrickletVoltageCurrentConfiguration
struct BrickletVoltageCurrentConfiguration
    averaging::Integer
    voltage_conversion_time::Integer
    current_conversion_time::Integer
end

export BrickletVoltageCurrentCalibration
struct BrickletVoltageCurrentCalibration
    gain_multiplier::Integer
    gain_divisor::Integer
end

export BrickletVoltageCurrentCurrentCallbackThreshold
struct BrickletVoltageCurrentCurrentCallbackThreshold
    option::Char
    min::Integer
    max::Integer
end

export BrickletVoltageCurrentVoltageCallbackThreshold
struct BrickletVoltageCurrentVoltageCallbackThreshold
    option::Char
    min::Integer
    max::Integer
end

export BrickletVoltageCurrentPowerCallbackThreshold
struct BrickletVoltageCurrentPowerCallbackThreshold
    option::Char
    min::Integer
    max::Integer
end

export BrickletVoltageCurrentIdentity
struct BrickletVoltageCurrentIdentity
    uid::String
    connected_uid::String
    position::Char
    hardware_version::Vector{Integer}
    firmware_version::Vector{Integer}
    device_identifier::Integer
end

export BrickletVoltageCurrent
"""
Measures power, DC voltage and DC current up to 720W/36V/20A
"""
mutable struct BrickletVoltageCurrent <: TinkerforgeDevice
    ipcon::IPConnection
    deviceInternal::PyObject

    """
    Creates an object with the unique device ID *uid* and adds it to
    the IP Connection *ipcon*.
    """
    function BrickletVoltageCurrent(uid::String, ipcon::IPConnection)
        package = pyimport("tinkerforge.bricklet_voltage_current")
        deviceInternal = package.BrickletVoltageCurrent(uid, ipcon.ipconInternal)

        return new(ipcon, deviceInternal)
    end
end

export get_current
"""
    $(SIGNATURES)

Returns the current.

If you want to get the current periodically, it is recommended to use the
:cb:`Current` callback and set the period with
:func:`Set Current Callback Period`.
"""
function get_current(device::BrickletVoltageCurrent)
    return device.deviceInternal.get_current()
end

export get_voltage
"""
    $(SIGNATURES)

Returns the voltage.

If you want to get the voltage periodically, it is recommended to use the
:cb:`Voltage` callback and set the period with
:func:`Set Voltage Callback Period`.
"""
function get_voltage(device::BrickletVoltageCurrent)
    return device.deviceInternal.get_voltage()
end

export get_power
"""
    $(SIGNATURES)

Returns the power.

If you want to get the power periodically, it is recommended to use the
:cb:`Power` callback and set the period with
:func:`Set Power Callback Period`.
"""
function get_power(device::BrickletVoltageCurrent)
    return device.deviceInternal.get_power()
end

export set_configuration
"""
    $(SIGNATURES)

Sets the configuration of the Voltage/Current Bricklet. It is
possible to configure number of averages as well as
voltage and current conversion time.
"""
function set_configuration(device::BrickletVoltageCurrent, averaging, voltage_conversion_time, current_conversion_time)
    device.deviceInternal.set_configuration(averaging, voltage_conversion_time, current_conversion_time)
end

export get_configuration
"""
    $(SIGNATURES)

Returns the configuration as set by :func:`Set Configuration`.
"""
function get_configuration(device::BrickletVoltageCurrent)
    return device.deviceInternal.get_configuration()
end

export set_calibration
"""
    $(SIGNATURES)

Since the shunt resistor that is used to measure the current is not
perfectly precise, it needs to be calibrated by a multiplier and
divisor if a very precise reading is needed.

For example, if you are expecting a measurement of 1000mA and you
are measuring 1023mA, you can calibrate the Voltage/Current Bricklet
by setting the multiplier to 1000 and the divisor to 1023.
"""
function set_calibration(device::BrickletVoltageCurrent, gain_multiplier, gain_divisor)
    device.deviceInternal.set_calibration(gain_multiplier, gain_divisor)
end

export get_calibration
"""
    $(SIGNATURES)

Returns the calibration as set by :func:`Set Calibration`.
"""
function get_calibration(device::BrickletVoltageCurrent)
    return device.deviceInternal.get_calibration()
end

export set_current_callback_period
"""
    $(SIGNATURES)

Sets the period with which the :cb:`Current` callback is triggered
periodically. A value of 0 turns the callback off.

The :cb:`Current` callback is only triggered if the current has changed since
the last triggering.
"""
function set_current_callback_period(device::BrickletVoltageCurrent, period)
    device.deviceInternal.set_current_callback_period(period)
end

export get_current_callback_period
"""
    $(SIGNATURES)

Returns the period as set by :func:`Set Current Callback Period`.
"""
function get_current_callback_period(device::BrickletVoltageCurrent)
    return device.deviceInternal.get_current_callback_period()
end

export set_voltage_callback_period
"""
    $(SIGNATURES)

Sets the period with which the :cb:`Voltage` callback is triggered
periodically. A value of 0 turns the callback off.

The :cb:`Voltage` callback is only triggered if the voltage has changed since
the last triggering.
"""
function set_voltage_callback_period(device::BrickletVoltageCurrent, period)
    device.deviceInternal.set_voltage_callback_period(period)
end

export get_voltage_callback_period
"""
    $(SIGNATURES)

Returns the period as set by :func:`Set Voltage Callback Period`.
"""
function get_voltage_callback_period(device::BrickletVoltageCurrent)
    return device.deviceInternal.get_voltage_callback_period()
end

export set_power_callback_period
"""
    $(SIGNATURES)

Sets the period with which the :cb:`Power` callback is triggered
periodically. A value of 0 turns the callback off.

The :cb:`Power` callback is only triggered if the power has changed since the
last triggering.
"""
function set_power_callback_period(device::BrickletVoltageCurrent, period)
    device.deviceInternal.set_power_callback_period(period)
end

export get_power_callback_period
"""
    $(SIGNATURES)

Returns the period as set by :func:`Get Power Callback Period`.
"""
function get_power_callback_period(device::BrickletVoltageCurrent)
    return device.deviceInternal.get_power_callback_period()
end

export set_current_callback_threshold
"""
    $(SIGNATURES)

Sets the thresholds for the :cb:`Current Reached` callback.

The following options are possible:

.. csv-table::
 :header: "Option", "Description"
 :widths: 10, 100

 "'x'",    "Callback is turned off"
 "'o'",    "Callback is triggered when the current is *outside* the min and max values"
 "'i'",    "Callback is triggered when the current is *inside* the min and max values"
 "'<'",    "Callback is triggered when the current is smaller than the min value (max is ignored)"
 "'>'",    "Callback is triggered when the current is greater than the min value (max is ignored)"
"""
function set_current_callback_threshold(device::BrickletVoltageCurrent, option, min, max)
    device.deviceInternal.set_current_callback_threshold(option, min, max)
end

export get_current_callback_threshold
"""
    $(SIGNATURES)

Returns the threshold as set by :func:`Set Current Callback Threshold`.
"""
function get_current_callback_threshold(device::BrickletVoltageCurrent)
    return device.deviceInternal.get_current_callback_threshold()
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
function set_voltage_callback_threshold(device::BrickletVoltageCurrent, option, min, max)
    device.deviceInternal.set_voltage_callback_threshold(option, min, max)
end

export get_voltage_callback_threshold
"""
    $(SIGNATURES)

Returns the threshold as set by :func:`Set Voltage Callback Threshold`.
"""
function get_voltage_callback_threshold(device::BrickletVoltageCurrent)
    return device.deviceInternal.get_voltage_callback_threshold()
end

export set_power_callback_threshold
"""
    $(SIGNATURES)

Sets the thresholds for the :cb:`Power Reached` callback.

The following options are possible:

.. csv-table::
 :header: "Option", "Description"
 :widths: 10, 100

 "'x'",    "Callback is turned off"
 "'o'",    "Callback is triggered when the power is *outside* the min and max values"
 "'i'",    "Callback is triggered when the power is *inside* the min and max values"
 "'<'",    "Callback is triggered when the power is smaller than the min value (max is ignored)"
 "'>'",    "Callback is triggered when the power is greater than the min value (max is ignored)"
"""
function set_power_callback_threshold(device::BrickletVoltageCurrent, option, min, max)
    device.deviceInternal.set_power_callback_threshold(option, min, max)
end

export get_power_callback_threshold
"""
    $(SIGNATURES)

Returns the threshold as set by :func:`Set Power Callback Threshold`.
"""
function get_power_callback_threshold(device::BrickletVoltageCurrent)
    return device.deviceInternal.get_power_callback_threshold()
end

export set_debounce_period
"""
    $(SIGNATURES)

Sets the period with which the threshold callbacks

* :cb:`Current Reached`,
* :cb:`Voltage Reached`,
* :cb:`Power Reached`

are triggered, if the thresholds

* :func:`Set Current Callback Threshold`,
* :func:`Set Voltage Callback Threshold`,
* :func:`Set Power Callback Threshold`

keep being reached.
"""
function set_debounce_period(device::BrickletVoltageCurrent, debounce)
    device.deviceInternal.set_debounce_period(debounce)
end

export get_debounce_period
"""
    $(SIGNATURES)

Returns the debounce period as set by :func:`Set Debounce Period`.
"""
function get_debounce_period(device::BrickletVoltageCurrent)
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
function get_identity(device::BrickletVoltageCurrent)
    return device.deviceInternal.get_identity()
end

export register_callback
"""
Registers the given *function* with the given *callback_id*.
"""
function register_callback(device::BrickletVoltageCurrent, callback_id, function_)
    if isnothing(function_)
        device.registered_callbacks.pop(callback_id, None)
    else
        device.registered_callbacks[callback_id] = function_
    end
end
