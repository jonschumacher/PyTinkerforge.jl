


export BrickletCO2CO2ConcentrationCallbackThreshold
struct BrickletCO2CO2ConcentrationCallbackThreshold
    option::Char
    min::Integer
    max::Integer
end

export BrickletCO2Identity
struct BrickletCO2Identity
    uid::String
    connected_uid::String
    position::Char
    hardware_version::Vector{Integer}
    firmware_version::Vector{Integer}
    device_identifier::Integer
end

export BrickletCO2
"""
Measures CO2 concentration in ppm
"""
mutable struct BrickletCO2 <: TinkerforgeDevice
    ipcon::IPConnection
    deviceInternal::PyObject

    """
    Creates an object with the unique device ID *uid* and adds it to
    the IP Connection *ipcon*.
    """
    function BrickletCO2(uid::String, ipcon::IPConnection)
        package = pyimport("tinkerforge.bricklet_co2")
        deviceInternal = package.BrickletCO2(uid, ipcon.ipconInternal)

        return new(ipcon, deviceInternal)
    end
end

export get_co2_concentration
"""
    $(SIGNATURES)

Returns the measured CO2 concentration.

If you want to get the CO2 concentration periodically, it is recommended to use
the :cb:`CO2 Concentration` callback and set the period with
:func:`Set CO2 Concentration Callback Period`.
"""
function get_co2_concentration(device::BrickletCO2)
    return device.deviceInternal.get_co2_concentration()
end

export set_co2_concentration_callback_period
"""
    $(SIGNATURES)

Sets the period with which the :cb:`CO2 Concentration` callback is
triggered periodically. A value of 0 turns the callback off.

The :cb:`CO2 Concentration` callback is only triggered if the CO2 concentration
has changed since the last triggering.
"""
function set_co2_concentration_callback_period(device::BrickletCO2, period)
    device.deviceInternal.set_co2_concentration_callback_period(period)
end

export get_co2_concentration_callback_period
"""
    $(SIGNATURES)

Returns the period as set by :func:`Set CO2 Concentration Callback Period`.
"""
function get_co2_concentration_callback_period(device::BrickletCO2)
    return device.deviceInternal.get_co2_concentration_callback_period()
end

export set_co2_concentration_callback_threshold
"""
    $(SIGNATURES)

Sets the thresholds for the :cb:`CO2 Concentration Reached` callback.

The following options are possible:

.. csv-table::
 :header: "Option", "Description"
 :widths: 10, 100

 "'x'",    "Callback is turned off"
 "'o'",    "Callback is triggered when the CO2 concentration is *outside* the min and max values"
 "'i'",    "Callback is triggered when the CO2 concentration is *inside* the min and max values"
 "'<'",    "Callback is triggered when the CO2 concentration is smaller than the min value (max is ignored)"
 "'>'",    "Callback is triggered when the CO2 concentration is greater than the min value (max is ignored)"
"""
function set_co2_concentration_callback_threshold(device::BrickletCO2, option, min, max)
    device.deviceInternal.set_co2_concentration_callback_threshold(option, min, max)
end

export get_co2_concentration_callback_threshold
"""
    $(SIGNATURES)

Returns the threshold as set by :func:`Set CO2 Concentration Callback Threshold`.
"""
function get_co2_concentration_callback_threshold(device::BrickletCO2)
    return device.deviceInternal.get_co2_concentration_callback_threshold()
end

export set_debounce_period
"""
    $(SIGNATURES)

Sets the period with which the threshold callbacks

* :cb:`CO2 Concentration Reached`,

are triggered, if the thresholds

* :func:`Set CO2 Concentration Callback Threshold`,

keep being reached.
"""
function set_debounce_period(device::BrickletCO2, debounce)
    device.deviceInternal.set_debounce_period(debounce)
end

export get_debounce_period
"""
    $(SIGNATURES)

Returns the debounce period as set by :func:`Set Debounce Period`.
"""
function get_debounce_period(device::BrickletCO2)
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
function get_identity(device::BrickletCO2)
    return device.deviceInternal.get_identity()
end

export register_callback
"""
Registers the given *function* with the given *callback_id*.
"""
function register_callback(device::BrickletCO2, callback_id, function_)
    if isnothing(function_)
        device.registered_callbacks.pop(callback_id, None)
    else
        device.registered_callbacks[callback_id] = function_
    end
end
