


export BrickletAmbientLightIlluminanceCallbackThreshold
struct BrickletAmbientLightIlluminanceCallbackThreshold
    option::Char
    min::Integer
    max::Integer
end

export BrickletAmbientLightAnalogValueCallbackThreshold
struct BrickletAmbientLightAnalogValueCallbackThreshold
    option::Char
    min::Integer
    max::Integer
end

export BrickletAmbientLightIdentity
struct BrickletAmbientLightIdentity
    uid::String
    connected_uid::String
    position::Char
    hardware_version::Vector{Integer}
    firmware_version::Vector{Integer}
    device_identifier::Integer
end

export BrickletAmbientLight
"""
Measures ambient light up to 900lux
"""
mutable struct BrickletAmbientLight <: TinkerforgeDevice
    ipcon::IPConnection
    deviceInternal::PyObject

    """
    Creates an object with the unique device ID *uid* and adds it to
    the IP Connection *ipcon*.
    """
    function BrickletAmbientLight(uid::String, ipcon::IPConnection)
        package = pyimport("tinkerforge.bricklet_ambient_light")
        deviceInternal = package.BrickletAmbientLight(uid, ipcon.ipconInternal)

        return new(ipcon, deviceInternal)
    end
end

export get_illuminance
"""
    $(SIGNATURES)

Returns the illuminance of the ambient light sensor.

If you want to get the illuminance periodically, it is recommended to use the
:cb:`Illuminance` callback and set the period with
:func:`Set Illuminance Callback Period`.
"""
function get_illuminance(device::BrickletAmbientLight)
    return device.deviceInternal.get_illuminance()
end

export get_analog_value
"""
    $(SIGNATURES)

Returns the value as read by a 12-bit analog-to-digital converter.

.. note::
 The value returned by :func:`Get Illuminance` is averaged over several samples
 to yield less noise, while :func:`Get Analog Value` gives back raw
 unfiltered analog values. The only reason to use :func:`Get Analog Value` is,
 if you need the full resolution of the analog-to-digital converter.

 Also, the analog-to-digital converter covers three different ranges that are
 set dynamically depending on the light intensity. It is impossible to
 distinguish between these ranges with the analog value.

If you want the analog value periodically, it is recommended to use the
:cb:`Analog Value` callback and set the period with
:func:`Set Analog Value Callback Period`.
"""
function get_analog_value(device::BrickletAmbientLight)
    return device.deviceInternal.get_analog_value()
end

export set_illuminance_callback_period
"""
    $(SIGNATURES)

Sets the period with which the :cb:`Illuminance` callback is triggered
periodically. A value of 0 turns the callback off.

The :cb:`Illuminance` callback is only triggered if the illuminance has changed
since the last triggering.
"""
function set_illuminance_callback_period(device::BrickletAmbientLight, period)
    device.deviceInternal.set_illuminance_callback_period(period)
end

export get_illuminance_callback_period
"""
    $(SIGNATURES)

Returns the period as set by :func:`Set Illuminance Callback Period`.
"""
function get_illuminance_callback_period(device::BrickletAmbientLight)
    return device.deviceInternal.get_illuminance_callback_period()
end

export set_analog_value_callback_period
"""
    $(SIGNATURES)

Sets the period with which the :cb:`Analog Value` callback is triggered
periodically. A value of 0 turns the callback off.

The :cb:`Analog Value` callback is only triggered if the analog value has
changed since the last triggering.
"""
function set_analog_value_callback_period(device::BrickletAmbientLight, period)
    device.deviceInternal.set_analog_value_callback_period(period)
end

export get_analog_value_callback_period
"""
    $(SIGNATURES)

Returns the period as set by :func:`Set Analog Value Callback Period`.
"""
function get_analog_value_callback_period(device::BrickletAmbientLight)
    return device.deviceInternal.get_analog_value_callback_period()
end

export set_illuminance_callback_threshold
"""
    $(SIGNATURES)

Sets the thresholds for the :cb:`Illuminance Reached` callback.

The following options are possible:

.. csv-table::
 :header: "Option", "Description"
 :widths: 10, 100

 "'x'",    "Callback is turned off"
 "'o'",    "Callback is triggered when the illuminance is *outside* the min and max values"
 "'i'",    "Callback is triggered when the illuminance is *inside* the min and max values"
 "'<'",    "Callback is triggered when the illuminance is smaller than the min value (max is ignored)"
 "'>'",    "Callback is triggered when the illuminance is greater than the min value (max is ignored)"
"""
function set_illuminance_callback_threshold(device::BrickletAmbientLight, option, min, max)
    device.deviceInternal.set_illuminance_callback_threshold(option, min, max)
end

export get_illuminance_callback_threshold
"""
    $(SIGNATURES)

Returns the threshold as set by :func:`Set Illuminance Callback Threshold`.
"""
function get_illuminance_callback_threshold(device::BrickletAmbientLight)
    return device.deviceInternal.get_illuminance_callback_threshold()
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
function set_analog_value_callback_threshold(device::BrickletAmbientLight, option, min, max)
    device.deviceInternal.set_analog_value_callback_threshold(option, min, max)
end

export get_analog_value_callback_threshold
"""
    $(SIGNATURES)

Returns the threshold as set by :func:`Set Analog Value Callback Threshold`.
"""
function get_analog_value_callback_threshold(device::BrickletAmbientLight)
    return device.deviceInternal.get_analog_value_callback_threshold()
end

export set_debounce_period
"""
    $(SIGNATURES)

Sets the period with which the threshold callbacks

* :cb:`Illuminance Reached`,
* :cb:`Analog Value Reached`

are triggered, if the thresholds

* :func:`Set Illuminance Callback Threshold`,
* :func:`Set Analog Value Callback Threshold`

keep being reached.
"""
function set_debounce_period(device::BrickletAmbientLight, debounce)
    device.deviceInternal.set_debounce_period(debounce)
end

export get_debounce_period
"""
    $(SIGNATURES)

Returns the debounce period as set by :func:`Set Debounce Period`.
"""
function get_debounce_period(device::BrickletAmbientLight)
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
function get_identity(device::BrickletAmbientLight)
    return device.deviceInternal.get_identity()
end

export register_callback
"""
Registers the given *function* with the given *callback_id*.
"""
function register_callback(device::BrickletAmbientLight, callback_id, function_)
    if isnothing(function_)
        device.registered_callbacks.pop(callback_id, None)
    else
        device.registered_callbacks[callback_id] = function_
    end
end
