


export BrickletThermocoupleTemperatureCallbackThreshold
struct BrickletThermocoupleTemperatureCallbackThreshold
    option::Char
    min::Integer
    max::Integer
end

export BrickletThermocoupleConfiguration
struct BrickletThermocoupleConfiguration
    averaging::Integer
    thermocouple_type::Integer
    filter::Integer
end

export BrickletThermocoupleErrorState
struct BrickletThermocoupleErrorState
    over_under::Bool
    open_circuit::Bool
end

export BrickletThermocoupleIdentity
struct BrickletThermocoupleIdentity
    uid::String
    connected_uid::String
    position::Char
    hardware_version::Vector{Integer}
    firmware_version::Vector{Integer}
    device_identifier::Integer
end

export BrickletThermocouple
"""
Measures temperature with thermocouples
"""
mutable struct BrickletThermocouple <: TinkerforgeDevice
    ipcon::IPConnection
    deviceInternal::PyObject

    """
    Creates an object with the unique device ID *uid* and adds it to
    the IP Connection *ipcon*.
    """
    function BrickletThermocouple(uid::String, ipcon::IPConnection)
        package = pyimport("tinkerforge.bricklet_thermocouple")
        deviceInternal = package.BrickletThermocouple(uid, ipcon.ipconInternal)

        return new(ipcon, deviceInternal)
    end
end

export get_temperature
"""
    $(SIGNATURES)

Returns the temperature of the thermocouple.

If you want to get the temperature periodically, it is recommended
to use the :cb:`Temperature` callback and set the period with
:func:`Set Temperature Callback Period`.
"""
function get_temperature(device::BrickletThermocouple)
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
function set_temperature_callback_period(device::BrickletThermocouple, period)
    device.deviceInternal.set_temperature_callback_period(period)
end

export get_temperature_callback_period
"""
    $(SIGNATURES)

Returns the period as set by :func:`Set Temperature Callback Period`.
"""
function get_temperature_callback_period(device::BrickletThermocouple)
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
function set_temperature_callback_threshold(device::BrickletThermocouple, option, min, max)
    device.deviceInternal.set_temperature_callback_threshold(option, min, max)
end

export get_temperature_callback_threshold
"""
    $(SIGNATURES)

Returns the threshold as set by :func:`Set Temperature Callback Threshold`.
"""
function get_temperature_callback_threshold(device::BrickletThermocouple)
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
function set_debounce_period(device::BrickletThermocouple, debounce)
    device.deviceInternal.set_debounce_period(debounce)
end

export get_debounce_period
"""
    $(SIGNATURES)

Returns the debounce period as set by :func:`Set Debounce Period`.
"""
function get_debounce_period(device::BrickletThermocouple)
    return device.deviceInternal.get_debounce_period()
end

export set_configuration
"""
    $(SIGNATURES)

You can configure averaging size, thermocouple type and frequency
filtering.

Available averaging sizes are 1, 2, 4, 8 and 16 samples.

As thermocouple type you can use B, E, J, K, N, R, S and T. If you have a
different thermocouple or a custom thermocouple you can also use
G8 and G32. With these types the returned value will not be in °C/100,
it will be calculated by the following formulas:

* G8: ``value = 8 * 1.6 * 2^17 * Vin``
* G32: ``value = 32 * 1.6 * 2^17 * Vin``

where Vin is the thermocouple input voltage.

The frequency filter can be either configured to 50Hz or to 60Hz. You should
configure it according to your utility frequency.

The conversion time depends on the averaging and filter configuration, it can
be calculated as follows:

* 60Hz: ``time = 82 + (samples - 1) * 16.67``
* 50Hz: ``time = 98 + (samples - 1) * 20``
"""
function set_configuration(device::BrickletThermocouple, averaging, thermocouple_type, filter)
    device.deviceInternal.set_configuration(averaging, thermocouple_type, filter)
end

export get_configuration
"""
    $(SIGNATURES)

Returns the configuration as set by :func:`Set Configuration`.
"""
function get_configuration(device::BrickletThermocouple)
    return device.deviceInternal.get_configuration()
end

export get_error_state
"""
    $(SIGNATURES)

Returns the current error state. There are two possible errors:

* Over/Under Voltage and
* Open Circuit.

Over/Under Voltage happens for voltages below 0V or above 3.3V. In this case
it is very likely that your thermocouple is defective. An Open Circuit error
indicates that there is no thermocouple connected.

You can use the :cb:`Error State` callback to automatically get triggered
when the error state changes.
"""
function get_error_state(device::BrickletThermocouple)
    return device.deviceInternal.get_error_state()
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
function get_identity(device::BrickletThermocouple)
    return device.deviceInternal.get_identity()
end

export register_callback
"""
Registers the given *function* with the given *callback_id*.
"""
function register_callback(device::BrickletThermocouple, callback_id, function_)
    if isnothing(function_)
        device.registered_callbacks.pop(callback_id, None)
    else
        device.registered_callbacks[callback_id] = function_
    end
end
