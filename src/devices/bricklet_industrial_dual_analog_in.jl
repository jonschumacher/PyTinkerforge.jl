


export BrickletIndustrialDualAnalogInVoltageCallbackThreshold
struct BrickletIndustrialDualAnalogInVoltageCallbackThreshold
    option::Char
    min::Integer
    max::Integer
end

export BrickletIndustrialDualAnalogInCalibration
struct BrickletIndustrialDualAnalogInCalibration
    offset::Vector{Integer}
    gain::Vector{Integer}
end

export BrickletIndustrialDualAnalogInIdentity
struct BrickletIndustrialDualAnalogInIdentity
    uid::String
    connected_uid::String
    position::Char
    hardware_version::Vector{Integer}
    firmware_version::Vector{Integer}
    device_identifier::Integer
end

export BrickletIndustrialDualAnalogIn
"""
Measures two DC voltages between -35V and +35V with 24bit resolution each
"""
mutable struct BrickletIndustrialDualAnalogIn <: TinkerforgeDevice
    ipcon::IPConnection
    deviceInternal::PyObject

    """
    Creates an object with the unique device ID *uid* and adds it to
    the IP Connection *ipcon*.
    """
    function BrickletIndustrialDualAnalogIn(uid::String, ipcon::IPConnection)
        package = pyimport("tinkerforge.bricklet_industrial_dual_analog_in")
        deviceInternal = package.BrickletIndustrialDualAnalogIn(uid, ipcon.ipconInternal)

        return new(ipcon, deviceInternal)
    end
end

export get_voltage
"""
    $(SIGNATURES)

Returns the voltage for the given channel.

If you want to get the voltage periodically, it is recommended to use the
:cb:`Voltage` callback and set the period with
:func:`Set Voltage Callback Period`.
"""
function get_voltage(device::BrickletIndustrialDualAnalogIn, channel)
    return device.deviceInternal.get_voltage(channel)
end

export set_voltage_callback_period
"""
    $(SIGNATURES)

Sets the period with which the :cb:`Voltage` callback is triggered
periodically for the given channel. A value of 0 turns the callback off.

The :cb:`Voltage` callback is only triggered if the voltage has changed since the
last triggering.
"""
function set_voltage_callback_period(device::BrickletIndustrialDualAnalogIn, channel, period)
    device.deviceInternal.set_voltage_callback_period(channel, period)
end

export get_voltage_callback_period
"""
    $(SIGNATURES)

Returns the period as set by :func:`Set Voltage Callback Period`.
"""
function get_voltage_callback_period(device::BrickletIndustrialDualAnalogIn, channel)
    return device.deviceInternal.get_voltage_callback_period(channel)
end

export set_voltage_callback_threshold
"""
    $(SIGNATURES)

Sets the thresholds for the :cb:`Voltage Reached` callback for the given
channel.

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
function set_voltage_callback_threshold(device::BrickletIndustrialDualAnalogIn, channel, option, min, max)
    device.deviceInternal.set_voltage_callback_threshold(channel, option, min, max)
end

export get_voltage_callback_threshold
"""
    $(SIGNATURES)

Returns the threshold as set by :func:`Set Voltage Callback Threshold`.
"""
function get_voltage_callback_threshold(device::BrickletIndustrialDualAnalogIn, channel)
    return device.deviceInternal.get_voltage_callback_threshold(channel)
end

export set_debounce_period
"""
    $(SIGNATURES)

Sets the period with which the threshold callback

* :cb:`Voltage Reached`

is triggered, if the threshold

* :func:`Set Voltage Callback Threshold`

keeps being reached.
"""
function set_debounce_period(device::BrickletIndustrialDualAnalogIn, debounce)
    device.deviceInternal.set_debounce_period(debounce)
end

export get_debounce_period
"""
    $(SIGNATURES)

Returns the debounce period as set by :func:`Set Debounce Period`.
"""
function get_debounce_period(device::BrickletIndustrialDualAnalogIn)
    return device.deviceInternal.get_debounce_period()
end

export set_sample_rate
"""
    $(SIGNATURES)

Sets the sample rate. The sample rate can be between 1 sample per second
and 976 samples per second. Decreasing the sample rate will also decrease the
noise on the data.
"""
function set_sample_rate(device::BrickletIndustrialDualAnalogIn, rate)
    device.deviceInternal.set_sample_rate(rate)
end

export get_sample_rate
"""
    $(SIGNATURES)

Returns the sample rate as set by :func:`Set Sample Rate`.
"""
function get_sample_rate(device::BrickletIndustrialDualAnalogIn)
    return device.deviceInternal.get_sample_rate()
end

export set_calibration
"""
    $(SIGNATURES)

Sets offset and gain of MCP3911 internal calibration registers.

See MCP3911 datasheet 7.7 and 7.8. The Industrial Dual Analog In Bricklet
is already factory calibrated by Tinkerforge. It should not be necessary
for you to use this function
"""
function set_calibration(device::BrickletIndustrialDualAnalogIn, offset, gain)
    device.deviceInternal.set_calibration(offset, gain)
end

export get_calibration
"""
    $(SIGNATURES)

Returns the calibration as set by :func:`Set Calibration`.
"""
function get_calibration(device::BrickletIndustrialDualAnalogIn)
    return device.deviceInternal.get_calibration()
end

export get_adc_values
"""
    $(SIGNATURES)

Returns the ADC values as given by the MCP3911 IC. This function
is needed for proper calibration, see :func:`Set Calibration`.
"""
function get_adc_values(device::BrickletIndustrialDualAnalogIn)
    return device.deviceInternal.get_adc_values()
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
function get_identity(device::BrickletIndustrialDualAnalogIn)
    return device.deviceInternal.get_identity()
end

export register_callback
"""
Registers the given *function* with the given *callback_id*.
"""
function register_callback(device::BrickletIndustrialDualAnalogIn, callback_id, function_)
    if isnothing(function_)
        device.registered_callbacks.pop(callback_id, None)
    else
        device.registered_callbacks[callback_id] = function_
    end
end
