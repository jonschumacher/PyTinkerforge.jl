


export BrickletLineReflectivityCallbackThreshold
struct BrickletLineReflectivityCallbackThreshold
    option::Char
    min::Integer
    max::Integer
end

export BrickletLineIdentity
struct BrickletLineIdentity
    uid::String
    connected_uid::String
    position::Char
    hardware_version::Vector{Integer}
    firmware_version::Vector{Integer}
    device_identifier::Integer
end

export BrickletLine
"""
Measures reflectivity of a surface
"""
mutable struct BrickletLine <: TinkerforgeDevice
    ipcon::IPConnection
    deviceInternal::PyObject

    """
    Creates an object with the unique device ID *uid* and adds it to
    the IP Connection *ipcon*.
    """
    function BrickletLine(uid::String, ipcon::IPConnection)
        package = pyimport("tinkerforge.bricklet_line")
        deviceInternal = package.BrickletLine(uid, ipcon.ipconInternal)

        return new(ipcon, deviceInternal)
    end
end

export get_reflectivity
"""
    $(SIGNATURES)

Returns the currently measured reflectivity. The reflectivity is
a value between 0 (not reflective) and 4095 (very reflective).

Usually black has a low reflectivity while white has a high
reflectivity.

If you want to get the reflectivity periodically, it is recommended
to use the :cb:`Reflectivity` callback and set the period with
:func:`Set Reflectivity Callback Period`.
"""
function get_reflectivity(device::BrickletLine)
    return device.deviceInternal.get_reflectivity()
end

export set_reflectivity_callback_period
"""
    $(SIGNATURES)

Sets the period with which the :cb:`Reflectivity` callback is triggered
periodically. A value of 0 turns the callback off.

The :cb:`Reflectivity` callback is only triggered if the reflectivity has
changed since the last triggering.
"""
function set_reflectivity_callback_period(device::BrickletLine, period)
    device.deviceInternal.set_reflectivity_callback_period(period)
end

export get_reflectivity_callback_period
"""
    $(SIGNATURES)

Returns the period as set by :func:`Set Reflectivity Callback Period`.
"""
function get_reflectivity_callback_period(device::BrickletLine)
    return device.deviceInternal.get_reflectivity_callback_period()
end

export set_reflectivity_callback_threshold
"""
    $(SIGNATURES)

Sets the thresholds for the :cb:`Reflectivity Reached` callback.

The following options are possible:

.. csv-table::
 :header: "Option", "Description"
 :widths: 10, 100

 "'x'",    "Callback is turned off"
 "'o'",    "Callback is triggered when the reflectivity is *outside* the min and max values"
 "'i'",    "Callback is triggered when the reflectivity is *inside* the min and max values"
 "'<'",    "Callback is triggered when the reflectivity is smaller than the min value (max is ignored)"
 "'>'",    "Callback is triggered when the reflectivity is greater than the min value (max is ignored)"
"""
function set_reflectivity_callback_threshold(device::BrickletLine, option, min, max)
    device.deviceInternal.set_reflectivity_callback_threshold(option, min, max)
end

export get_reflectivity_callback_threshold
"""
    $(SIGNATURES)

Returns the threshold as set by :func:`Set Reflectivity Callback Threshold`.
"""
function get_reflectivity_callback_threshold(device::BrickletLine)
    return device.deviceInternal.get_reflectivity_callback_threshold()
end

export set_debounce_period
"""
    $(SIGNATURES)

Sets the period with which the threshold callback

* :cb:`Reflectivity Reached`

is triggered, if the threshold

* :func:`Set Reflectivity Callback Threshold`

keeps being reached.
"""
function set_debounce_period(device::BrickletLine, debounce)
    device.deviceInternal.set_debounce_period(debounce)
end

export get_debounce_period
"""
    $(SIGNATURES)

Returns the debounce period as set by :func:`Set Debounce Period`.
"""
function get_debounce_period(device::BrickletLine)
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
function get_identity(device::BrickletLine)
    return device.deviceInternal.get_identity()
end

export register_callback
"""
Registers the given *function* with the given *callback_id*.
"""
function register_callback(device::BrickletLine, callback_id, function_)
    if isnothing(function_)
        device.registered_callbacks.pop(callback_id, None)
    else
        device.registered_callbacks[callback_id] = function_
    end
end
