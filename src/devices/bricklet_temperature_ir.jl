


export BrickletTemperatureIRAmbientTemperatureCallbackThreshold
struct BrickletTemperatureIRAmbientTemperatureCallbackThreshold
    option::Char
    min::Integer
    max::Integer
end

export BrickletTemperatureIRObjectTemperatureCallbackThreshold
struct BrickletTemperatureIRObjectTemperatureCallbackThreshold
    option::Char
    min::Integer
    max::Integer
end

export BrickletTemperatureIRIdentity
struct BrickletTemperatureIRIdentity
    uid::String
    connected_uid::String
    position::Char
    hardware_version::Vector{Integer}
    firmware_version::Vector{Integer}
    device_identifier::Integer
end

export BrickletTemperatureIR
"""
Measures contactless object temperature between -70°C and +380°C
"""
mutable struct BrickletTemperatureIR <: TinkerforgeDevice
    ipcon::IPConnection
    deviceInternal::PyObject

    """
    Creates an object with the unique device ID *uid* and adds it to
    the IP Connection *ipcon*.
    """
    function BrickletTemperatureIR(uid::String, ipcon::IPConnection)
        package = pyimport("tinkerforge.bricklet_temperature_ir")
        deviceInternal = package.BrickletTemperatureIR(uid, ipcon.ipconInternal)

        return new(ipcon, deviceInternal)
    end
end

export get_ambient_temperature
"""
    $(SIGNATURES)

Returns the ambient temperature of the sensor.

If you want to get the ambient temperature periodically, it is recommended
to use the :cb:`Ambient Temperature` callback and set the period with
:func:`Set Ambient Temperature Callback Period`.
"""
function get_ambient_temperature(device::BrickletTemperatureIR)
    return device.deviceInternal.get_ambient_temperature()
end

export get_object_temperature
"""
    $(SIGNATURES)

Returns the object temperature of the sensor, i.e. the temperature
of the surface of the object the sensor is aimed at.

The temperature of different materials is dependent on their `emissivity
<https://en.wikipedia.org/wiki/Emissivity>`__. The emissivity of the material
can be set with :func:`Set Emissivity`.

If you want to get the object temperature periodically, it is recommended
to use the :cb:`Object Temperature` callback and set the period with
:func:`Set Object Temperature Callback Period`.
"""
function get_object_temperature(device::BrickletTemperatureIR)
    return device.deviceInternal.get_object_temperature()
end

export set_emissivity
"""
    $(SIGNATURES)

Sets the `emissivity <https://en.wikipedia.org/wiki/Emissivity>`__ that is
used to calculate the surface temperature as returned by
:func:`Get Object Temperature`.

The emissivity is usually given as a value between 0.0 and 1.0. A list of
emissivities of different materials can be found
`here <https://www.infrared-thermography.com/material.htm>`__.

The parameter of :func:`Set Emissivity` has to be given with a factor of
65535 (16-bit). For example: An emissivity of 0.1 can be set with the
value 6553, an emissivity of 0.5 with the value 32767 and so on.

.. note::
 If you need a precise measurement for the object temperature, it is
 absolutely crucial that you also provide a precise emissivity.

The emissivity is stored in non-volatile memory and will still be used after a restart or power cycle of the Bricklet.
"""
function set_emissivity(device::BrickletTemperatureIR, emissivity)
    device.deviceInternal.set_emissivity(emissivity)
end

export get_emissivity
"""
    $(SIGNATURES)

Returns the emissivity as set by :func:`Set Emissivity`.
"""
function get_emissivity(device::BrickletTemperatureIR)
    return device.deviceInternal.get_emissivity()
end

export set_ambient_temperature_callback_period
"""
    $(SIGNATURES)

Sets the period with which the :cb:`Ambient Temperature` callback is
triggered periodically. A value of 0 turns the callback off.

The :cb:`Ambient Temperature` callback is only triggered if the temperature has
changed since the last triggering.
"""
function set_ambient_temperature_callback_period(device::BrickletTemperatureIR, period)
    device.deviceInternal.set_ambient_temperature_callback_period(period)
end

export get_ambient_temperature_callback_period
"""
    $(SIGNATURES)

Returns the period as set by :func:`Set Ambient Temperature Callback Period`.
"""
function get_ambient_temperature_callback_period(device::BrickletTemperatureIR)
    return device.deviceInternal.get_ambient_temperature_callback_period()
end

export set_object_temperature_callback_period
"""
    $(SIGNATURES)

Sets the period with which the :cb:`Object Temperature` callback is
triggered periodically. A value of 0 turns the callback off.

The :cb:`Object Temperature` callback is only triggered if the temperature
has changed since the last triggering.
"""
function set_object_temperature_callback_period(device::BrickletTemperatureIR, period)
    device.deviceInternal.set_object_temperature_callback_period(period)
end

export get_object_temperature_callback_period
"""
    $(SIGNATURES)

Returns the period as set by :func:`Set Object Temperature Callback Period`.
"""
function get_object_temperature_callback_period(device::BrickletTemperatureIR)
    return device.deviceInternal.get_object_temperature_callback_period()
end

export set_ambient_temperature_callback_threshold
"""
    $(SIGNATURES)

Sets the thresholds for the :cb:`Ambient Temperature Reached` callback.

The following options are possible:

.. csv-table::
 :header: "Option", "Description"
 :widths: 10, 100

 "'x'",    "Callback is turned off"
 "'o'",    "Callback is triggered when the ambient temperature is *outside* the min and max values"
 "'i'",    "Callback is triggered when the ambient temperature is *inside* the min and max values"
 "'<'",    "Callback is triggered when the ambient temperature is smaller than the min value (max is ignored)"
 "'>'",    "Callback is triggered when the ambient temperature is greater than the min value (max is ignored)"
"""
function set_ambient_temperature_callback_threshold(device::BrickletTemperatureIR, option, min, max)
    device.deviceInternal.set_ambient_temperature_callback_threshold(option, min, max)
end

export get_ambient_temperature_callback_threshold
"""
    $(SIGNATURES)

Returns the threshold as set by :func:`Set Ambient Temperature Callback Threshold`.
"""
function get_ambient_temperature_callback_threshold(device::BrickletTemperatureIR)
    return device.deviceInternal.get_ambient_temperature_callback_threshold()
end

export set_object_temperature_callback_threshold
"""
    $(SIGNATURES)

Sets the thresholds for the :cb:`Object Temperature Reached` callback.

The following options are possible:

.. csv-table::
 :header: "Option", "Description"
 :widths: 10, 100

 "'x'",    "Callback is turned off"
 "'o'",    "Callback is triggered when the object temperature is *outside* the min and max values"
 "'i'",    "Callback is triggered when the object temperature is *inside* the min and max values"
 "'<'",    "Callback is triggered when the object temperature is smaller than the min value (max is ignored)"
 "'>'",    "Callback is triggered when the object temperature is greater than the min value (max is ignored)"
"""
function set_object_temperature_callback_threshold(device::BrickletTemperatureIR, option, min, max)
    device.deviceInternal.set_object_temperature_callback_threshold(option, min, max)
end

export get_object_temperature_callback_threshold
"""
    $(SIGNATURES)

Returns the threshold as set by :func:`Set Object Temperature Callback Threshold`.
"""
function get_object_temperature_callback_threshold(device::BrickletTemperatureIR)
    return device.deviceInternal.get_object_temperature_callback_threshold()
end

export set_debounce_period
"""
    $(SIGNATURES)

Sets the period with which the threshold callbacks

* :cb:`Ambient Temperature Reached`,
* :cb:`Object Temperature Reached`

are triggered, if the thresholds

* :func:`Set Ambient Temperature Callback Threshold`,
* :func:`Set Object Temperature Callback Threshold`

keep being reached.
"""
function set_debounce_period(device::BrickletTemperatureIR, debounce)
    device.deviceInternal.set_debounce_period(debounce)
end

export get_debounce_period
"""
    $(SIGNATURES)

Returns the debounce period as set by :func:`Set Debounce Period`.
"""
function get_debounce_period(device::BrickletTemperatureIR)
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
function get_identity(device::BrickletTemperatureIR)
    return device.deviceInternal.get_identity()
end

export register_callback
"""
Registers the given *function* with the given *callback_id*.
"""
function register_callback(device::BrickletTemperatureIR, callback_id, function_)
    if isnothing(function_)
        device.registered_callbacks.pop(callback_id, None)
    else
        device.registered_callbacks[callback_id] = function_
    end
end
