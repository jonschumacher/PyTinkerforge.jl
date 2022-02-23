


export BrickletSegmentDisplay4x7Segments
struct BrickletSegmentDisplay4x7Segments
    segments::Vector{Integer}
    brightness::Integer
    colon::Bool
end

export BrickletSegmentDisplay4x7Identity
struct BrickletSegmentDisplay4x7Identity
    uid::String
    connected_uid::String
    position::Char
    hardware_version::Vector{Integer}
    firmware_version::Vector{Integer}
    device_identifier::Integer
end

export BrickletSegmentDisplay4x7
"""
Four 7-segment displays with switchable colon
"""
mutable struct BrickletSegmentDisplay4x7 <: TinkerforgeDevice
    ipcon::IPConnection
    deviceInternal::PyObject

    """
    Creates an object with the unique device ID *uid* and adds it to
    the IP Connection *ipcon*.
    """
    function BrickletSegmentDisplay4x7(uid::String, ipcon::IPConnection)
        package = pyimport("tinkerforge.bricklet_segment_display_4x7")
        deviceInternal = package.BrickletSegmentDisplay4x7(uid, ipcon.ipconInternal)

        return new(ipcon, deviceInternal)
    end
end

export set_segments
"""
    $(SIGNATURES)

The 7-segment display can be set with bitmaps. Every bit controls one
segment:

.. image:: /Images/Bricklets/bricklet_segment_display_4x7_bit_order.png
   :scale: 100 %
   :alt: Bit order of one segment
   :align: center

For example to set a "5" you would want to activate segments 0, 2, 3, 5 and 6.
This is represented by the number 0b01101101 = 0x6d = 109.

The brightness can be set between 0 (dark) and 7 (bright). The colon
parameter turns the colon of the display on or off.
"""
function set_segments(device::BrickletSegmentDisplay4x7, segments, brightness, colon)
    device.deviceInternal.set_segments(segments, brightness, colon)
end

export get_segments
"""
    $(SIGNATURES)

Returns the segment, brightness and color data as set by
:func:`Set Segments`.
"""
function get_segments(device::BrickletSegmentDisplay4x7)
    return device.deviceInternal.get_segments()
end

export start_counter
"""
    $(SIGNATURES)

Starts a counter with the *from* value that counts to the *to*
value with the each step incremented by *increment*.
*length* is the pause between each increment.

Example: If you set *from* to 0, *to* to 100, *increment* to 1 and
*length* to 1000, a counter that goes from 0 to 100 with one second
pause between each increment will be started.

Using a negative increment allows to count backwards.

You can stop the counter at every time by calling :func:`Set Segments`.
"""
function start_counter(device::BrickletSegmentDisplay4x7, value_from, value_to, increment, length)
    device.deviceInternal.start_counter(value_from, value_to, increment, length)
end

export get_counter_value
"""
    $(SIGNATURES)

Returns the counter value that is currently shown on the display.

If there is no counter running a 0 will be returned.
"""
function get_counter_value(device::BrickletSegmentDisplay4x7)
    return device.deviceInternal.get_counter_value()
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
function get_identity(device::BrickletSegmentDisplay4x7)
    return device.deviceInternal.get_identity()
end

export register_callback
"""
Registers the given *function* with the given *callback_id*.
"""
function register_callback(device::BrickletSegmentDisplay4x7, callback_id, function_)
    if isnothing(function_)
        device.registered_callbacks.pop(callback_id, None)
    else
        device.registered_callbacks[callback_id] = function_
    end
end
