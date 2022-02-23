


export BrickletRotaryEncoderCountCallbackThreshold
struct BrickletRotaryEncoderCountCallbackThreshold
    option::Char
    min::Integer
    max::Integer
end

export BrickletRotaryEncoderIdentity
struct BrickletRotaryEncoderIdentity
    uid::String
    connected_uid::String
    position::Char
    hardware_version::Vector{Integer}
    firmware_version::Vector{Integer}
    device_identifier::Integer
end

export BrickletRotaryEncoder
"""
360° rotary encoder with push-button
"""
mutable struct BrickletRotaryEncoder <: TinkerforgeDevice
    ipcon::IPConnection
    deviceInternal::PyObject

    """
    Creates an object with the unique device ID *uid* and adds it to
    the IP Connection *ipcon*.
    """
    function BrickletRotaryEncoder(uid::String, ipcon::IPConnection)
        package = pyimport("tinkerforge.bricklet_rotary_encoder")
        deviceInternal = package.BrickletRotaryEncoder(uid, ipcon.ipconInternal)

        return new(ipcon, deviceInternal)
    end
end

export get_count
"""
    $(SIGNATURES)

Returns the current count of the encoder. If you set reset
to true, the count is set back to 0 directly after the
current count is read.

The encoder has 24 steps per rotation

Turning the encoder to the left decrements the counter,
so a negative count is possible.
"""
function get_count(device::BrickletRotaryEncoder, reset)
    return device.deviceInternal.get_count(reset)
end

export set_count_callback_period
"""
    $(SIGNATURES)

Sets the period with which the :cb:`Count` callback is triggered
periodically. A value of 0 turns the callback off.

The :cb:`Count` callback is only triggered if the count has changed since the
last triggering.
"""
function set_count_callback_period(device::BrickletRotaryEncoder, period)
    device.deviceInternal.set_count_callback_period(period)
end

export get_count_callback_period
"""
    $(SIGNATURES)

Returns the period as set by :func:`Set Count Callback Period`.
"""
function get_count_callback_period(device::BrickletRotaryEncoder)
    return device.deviceInternal.get_count_callback_period()
end

export set_count_callback_threshold
"""
    $(SIGNATURES)

Sets the thresholds for the :cb:`Count Reached` callback.

The following options are possible:

.. csv-table::
 :header: "Option", "Description"
 :widths: 10, 100

 "'x'",    "Callback is turned off"
 "'o'",    "Callback is triggered when the count is *outside* the min and max values"
 "'i'",    "Callback is triggered when the count is *inside* the min and max values"
 "'<'",    "Callback is triggered when the count is smaller than the min value (max is ignored)"
 "'>'",    "Callback is triggered when the count is greater than the min value (max is ignored)"
"""
function set_count_callback_threshold(device::BrickletRotaryEncoder, option, min, max)
    device.deviceInternal.set_count_callback_threshold(option, min, max)
end

export get_count_callback_threshold
"""
    $(SIGNATURES)

Returns the threshold as set by :func:`Set Count Callback Threshold`.
"""
function get_count_callback_threshold(device::BrickletRotaryEncoder)
    return device.deviceInternal.get_count_callback_threshold()
end

export set_debounce_period
"""
    $(SIGNATURES)

Sets the period with which the threshold callback

* :cb:`Count Reached`

is triggered, if the thresholds

* :func:`Set Count Callback Threshold`

keeps being reached.
"""
function set_debounce_period(device::BrickletRotaryEncoder, debounce)
    device.deviceInternal.set_debounce_period(debounce)
end

export get_debounce_period
"""
    $(SIGNATURES)

Returns the debounce period as set by :func:`Set Debounce Period`.
"""
function get_debounce_period(device::BrickletRotaryEncoder)
    return device.deviceInternal.get_debounce_period()
end

export is_pressed
"""
    $(SIGNATURES)

Returns *true* if the button is pressed and *false* otherwise.

It is recommended to use the :cb:`Pressed` and :cb:`Released` callbacks
to handle the button.
"""
function is_pressed(device::BrickletRotaryEncoder)
    return device.deviceInternal.is_pressed()
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
function get_identity(device::BrickletRotaryEncoder)
    return device.deviceInternal.get_identity()
end

export register_callback
"""
Registers the given *function* with the given *callback_id*.
"""
function register_callback(device::BrickletRotaryEncoder, callback_id, function_)
    if isnothing(function_)
        device.registered_callbacks.pop(callback_id, None)
    else
        device.registered_callbacks[callback_id] = function_
    end
end
