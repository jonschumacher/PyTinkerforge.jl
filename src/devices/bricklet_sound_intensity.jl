


export BrickletSoundIntensityIntensityCallbackThreshold
struct BrickletSoundIntensityIntensityCallbackThreshold
    option::Char
    min::Integer
    max::Integer
end

export BrickletSoundIntensityIdentity
struct BrickletSoundIntensityIdentity
    uid::String
    connected_uid::String
    position::Char
    hardware_version::Vector{Integer}
    firmware_version::Vector{Integer}
    device_identifier::Integer
end

export BrickletSoundIntensity
"""
Measures sound intensity
"""
mutable struct BrickletSoundIntensity <: TinkerforgeDevice
    ipcon::IPConnection
    deviceInternal::PyObject

    """
    Creates an object with the unique device ID *uid* and adds it to
    the IP Connection *ipcon*.
    """
    function BrickletSoundIntensity(uid::String, ipcon::IPConnection)
        package = pyimport("tinkerforge.bricklet_sound_intensity")
        deviceInternal = package.BrickletSoundIntensity(uid, ipcon.ipconInternal)

        return new(ipcon, deviceInternal)
    end
end

export get_intensity
"""
    $(SIGNATURES)

Returns the current sound intensity.

The value corresponds to the
`upper envelop <https://en.wikipedia.org/wiki/Envelope_(waves)>`__
of the signal of the microphone capsule.

If you want to get the intensity periodically, it is recommended to use the
:cb:`Intensity` callback and set the period with
:func:`Set Intensity Callback Period`.
"""
function get_intensity(device::BrickletSoundIntensity)
    return device.deviceInternal.get_intensity()
end

export set_intensity_callback_period
"""
    $(SIGNATURES)

Sets the period with which the :cb:`Intensity` callback is triggered
periodically. A value of 0 turns the callback off.

The :cb:`Intensity` callback is only triggered if the intensity has changed
since the last triggering.
"""
function set_intensity_callback_period(device::BrickletSoundIntensity, period)
    device.deviceInternal.set_intensity_callback_period(period)
end

export get_intensity_callback_period
"""
    $(SIGNATURES)

Returns the period as set by :func:`Set Intensity Callback Period`.
"""
function get_intensity_callback_period(device::BrickletSoundIntensity)
    return device.deviceInternal.get_intensity_callback_period()
end

export set_intensity_callback_threshold
"""
    $(SIGNATURES)

Sets the thresholds for the :cb:`Intensity Reached` callback.

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
function set_intensity_callback_threshold(device::BrickletSoundIntensity, option, min, max)
    device.deviceInternal.set_intensity_callback_threshold(option, min, max)
end

export get_intensity_callback_threshold
"""
    $(SIGNATURES)

Returns the threshold as set by :func:`Set Intensity Callback Threshold`.
"""
function get_intensity_callback_threshold(device::BrickletSoundIntensity)
    return device.deviceInternal.get_intensity_callback_threshold()
end

export set_debounce_period
"""
    $(SIGNATURES)

Sets the period with which the threshold callback

* :cb:`Intensity Reached`

is triggered, if the thresholds

* :func:`Set Intensity Callback Threshold`

keeps being reached.
"""
function set_debounce_period(device::BrickletSoundIntensity, debounce)
    device.deviceInternal.set_debounce_period(debounce)
end

export get_debounce_period
"""
    $(SIGNATURES)

Returns the debounce period as set by :func:`Set Debounce Period`.
"""
function get_debounce_period(device::BrickletSoundIntensity)
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
function get_identity(device::BrickletSoundIntensity)
    return device.deviceInternal.get_identity()
end

export register_callback
"""
Registers the given *function* with the given *callback_id*.
"""
function register_callback(device::BrickletSoundIntensity, callback_id, function_)
    if isnothing(function_)
        device.registered_callbacks.pop(callback_id, None)
    else
        device.registered_callbacks[callback_id] = function_
    end
end
