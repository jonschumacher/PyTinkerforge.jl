


export BrickletUVLightUVLightCallbackThreshold
struct BrickletUVLightUVLightCallbackThreshold
    option::Char
    min::Integer
    max::Integer
end

export BrickletUVLightIdentity
struct BrickletUVLightIdentity
    uid::String
    connected_uid::String
    position::Char
    hardware_version::Vector{Integer}
    firmware_version::Vector{Integer}
    device_identifier::Integer
end

export BrickletUVLight
"""
Measures UV light
"""
mutable struct BrickletUVLight <: TinkerforgeDevice
    ipcon::IPConnection
    deviceInternal::PyObject

    """
    Creates an object with the unique device ID *uid* and adds it to
    the IP Connection *ipcon*.
    """
    function BrickletUVLight(uid::String, ipcon::IPConnection)
        package = pyimport("tinkerforge.bricklet_uv_light")
        deviceInternal = package.BrickletUVLight(uid, ipcon.ipconInternal)

        return new(ipcon, deviceInternal)
    end
end

export get_uv_light
"""
    $(SIGNATURES)

Returns the UV light intensity of the sensor.
The sensor has already weighted the intensity with the erythemal
action spectrum to get the skin-affecting irradiation.

To get UV index you just have to divide the value by 250. For example, a UV
light intensity of 500 is equivalent to an UV index of 2.

If you want to get the intensity periodically, it is recommended to use the
:cb:`UV Light` callback and set the period with
:func:`Set UV Light Callback Period`.
"""
function get_uv_light(device::BrickletUVLight)
    return device.deviceInternal.get_uv_light()
end

export set_uv_light_callback_period
"""
    $(SIGNATURES)

Sets the period with which the :cb:`UV Light` callback is triggered
periodically. A value of 0 turns the callback off.

The :cb:`UV Light` callback is only triggered if the intensity has changed since
the last triggering.
"""
function set_uv_light_callback_period(device::BrickletUVLight, period)
    device.deviceInternal.set_uv_light_callback_period(period)
end

export get_uv_light_callback_period
"""
    $(SIGNATURES)

Returns the period as set by :func:`Set UV Light Callback Period`.
"""
function get_uv_light_callback_period(device::BrickletUVLight)
    return device.deviceInternal.get_uv_light_callback_period()
end

export set_uv_light_callback_threshold
"""
    $(SIGNATURES)

Sets the thresholds for the :cb:`UV Light Reached` callback.

The following options are possible:

.. csv-table::
 :header: "Option", "Description"
 :widths: 10, 100

 "'x'",    "Callback is turned off"
 "'o'",    "Callback is triggered when the intensity is *outside* the min and max values"
 "'i'",    "Callback is triggered when the intensity is *inside* the min and max values"
 "'<'",    "Callback is triggered when the intensity is smaller than the min value (max is ignored)"
 "'>'",    "Callback is triggered when the intensity is greater than the min value (max is ignored)"
"""
function set_uv_light_callback_threshold(device::BrickletUVLight, option, min, max)
    device.deviceInternal.set_uv_light_callback_threshold(option, min, max)
end

export get_uv_light_callback_threshold
"""
    $(SIGNATURES)

Returns the threshold as set by :func:`Set UV Light Callback Threshold`.
"""
function get_uv_light_callback_threshold(device::BrickletUVLight)
    return device.deviceInternal.get_uv_light_callback_threshold()
end

export set_debounce_period
"""
    $(SIGNATURES)

Sets the period with which the threshold callbacks

* :cb:`UV Light Reached`,

are triggered, if the thresholds

* :func:`Set UV Light Callback Threshold`,

keep being reached.
"""
function set_debounce_period(device::BrickletUVLight, debounce)
    device.deviceInternal.set_debounce_period(debounce)
end

export get_debounce_period
"""
    $(SIGNATURES)

Returns the debounce period as set by :func:`Set Debounce Period`.
"""
function get_debounce_period(device::BrickletUVLight)
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
function get_identity(device::BrickletUVLight)
    return device.deviceInternal.get_identity()
end

export register_callback
"""
Registers the given *function* with the given *callback_id*.
"""
function register_callback(device::BrickletUVLight, callback_id, function_)
    if isnothing(function_)
        device.registered_callbacks.pop(callback_id, None)
    else
        device.registered_callbacks[callback_id] = function_
    end
end
