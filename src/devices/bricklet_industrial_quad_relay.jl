


export BrickletIndustrialQuadRelayMonoflop
struct BrickletIndustrialQuadRelayMonoflop
    value::Integer
    time::Integer
    time_remaining::Integer
end

export BrickletIndustrialQuadRelayIdentity
struct BrickletIndustrialQuadRelayIdentity
    uid::String
    connected_uid::String
    position::Char
    hardware_version::Vector{Integer}
    firmware_version::Vector{Integer}
    device_identifier::Integer
end

export BrickletIndustrialQuadRelay
"""
4 galvanically isolated solid state relays
"""
mutable struct BrickletIndustrialQuadRelay <: TinkerforgeDevice
    ipcon::IPConnection
    deviceInternal::PyObject

    """
    Creates an object with the unique device ID *uid* and adds it to
    the IP Connection *ipcon*.
    """
    function BrickletIndustrialQuadRelay(uid::String, ipcon::IPConnection)
        package = pyimport("tinkerforge.bricklet_industrial_quad_relay")
        deviceInternal = package.BrickletIndustrialQuadRelay(uid, ipcon.ipconInternal)

        return new(ipcon, deviceInternal)
    end
end

export set_value
"""
    $(SIGNATURES)

Sets the output value with a bitmask (16bit). A 1 in the bitmask means relay
closed and a 0 means relay open.

For example: The value 3 or 0b0011 will close the relay of pins 0-1 and open
the other pins.

If no groups are used (see :func:`Set Group`), the pins correspond to the
markings on the Industrial Quad Relay Bricklet.

If groups are used, the pins correspond to the element in the group.
Element 1 in the group will get pins 0-3, element 2 pins 4-7, element 3
pins 8-11 and element 4 pins 12-15.

All running monoflop timers will be aborted if this function is called.
"""
function set_value(device::BrickletIndustrialQuadRelay, value_mask)
    device.deviceInternal.set_value(value_mask)
end

export get_value
"""
    $(SIGNATURES)

Returns the bitmask as set by :func:`Set Value`.
"""
function get_value(device::BrickletIndustrialQuadRelay)
    return device.deviceInternal.get_value()
end

export set_monoflop
"""
    $(SIGNATURES)

Configures a monoflop of the pins specified by the first parameter
bitmask.

The second parameter is a bitmask with the desired value of the specified
pins. A 1 in the bitmask means relay closed and a 0 means relay open.

The third parameter indicates the time that the pins should hold
the value.

If this function is called with the parameters (9, 1, 1500) or
(0b1001, 0b0001, 1500): Pin 0 will close and pin 3 will open. In 1.5s pin 0
will open and pin 3 will close again.

A monoflop can be used as a fail-safe mechanism. For example: Lets assume you
have a RS485 bus and a Quad Relay Bricklet connected to one of the slave
stacks. You can now call this function every second, with a time parameter
of two seconds and pin 0 closed. Pin 0 will be closed all the time. If now
the RS485 connection is lost, then pin 0 will be opened in at most two seconds.
"""
function set_monoflop(device::BrickletIndustrialQuadRelay, selection_mask, value_mask, time)
    device.deviceInternal.set_monoflop(selection_mask, value_mask, time)
end

export get_monoflop
"""
    $(SIGNATURES)

Returns (for the given pin) the current value and the time as set by
:func:`Set Monoflop` as well as the remaining time until the value flips.

If the timer is not running currently, the remaining time will be returned
as 0.
"""
function get_monoflop(device::BrickletIndustrialQuadRelay, pin)
    return device.deviceInternal.get_monoflop(pin)
end

export set_group
"""
    $(SIGNATURES)

Sets a group of Quad Relay Bricklets that should work together. You can
find Bricklets that can be grouped together with :func:`Get Available For Group`.

The group consists of 4 elements. Element 1 in the group will get pins 0-3,
element 2 pins 4-7, element 3 pins 8-11 and element 4 pins 12-15.

Each element can either be one of the ports ('a' to 'd') or 'n' if it should
not be used.

For example: If you have two Quad Relay Bricklets connected to port A and
port B respectively, you could call with ``['a', 'b', 'n', 'n']``.

Now the pins on the Quad Relay on port A are assigned to 0-3 and the
pins on the Quad Relay on port B are assigned to 4-7. It is now possible
to call :func:`Set Value` and control two Bricklets at the same time.
"""
function set_group(device::BrickletIndustrialQuadRelay, group)
    device.deviceInternal.set_group(group)
end

export get_group
"""
    $(SIGNATURES)

Returns the group as set by :func:`Set Group`
"""
function get_group(device::BrickletIndustrialQuadRelay)
    return device.deviceInternal.get_group()
end

export get_available_for_group
"""
    $(SIGNATURES)

Returns a bitmask of ports that are available for grouping. For example the
value 5 or 0b0101 means: Port A and port C are connected to Bricklets that
can be grouped together.
"""
function get_available_for_group(device::BrickletIndustrialQuadRelay)
    return device.deviceInternal.get_available_for_group()
end

export set_selected_values
"""
    $(SIGNATURES)

Sets the output value with a bitmask, according to the selection mask.
The bitmask is 16 bit long, *true* refers to a closed relay and
*false* refers to an open relay.

For example: The values (3, 1) or (0b0011, 0b0001) will close the relay of
pin 0, open the relay of pin 1 and leave the others untouched.

If no groups are used (see :func:`Set Group`), the pins correspond to the
markings on the Industrial Quad Relay Bricklet.

If groups are used, the pins correspond to the element in the group.
Element 1 in the group will get pins 0-3, element 2 pins 4-7, element 3
pins 8-11 and element 4 pins 12-15.

Running monoflop timers for the selected relays will be aborted if this function
is called.
"""
function set_selected_values(device::BrickletIndustrialQuadRelay, selection_mask, value_mask)
    device.deviceInternal.set_selected_values(selection_mask, value_mask)
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
function get_identity(device::BrickletIndustrialQuadRelay)
    return device.deviceInternal.get_identity()
end

export register_callback
"""
Registers the given *function* with the given *callback_id*.
"""
function register_callback(device::BrickletIndustrialQuadRelay, callback_id, function_)
    if isnothing(function_)
        device.registered_callbacks.pop(callback_id, None)
    else
        device.registered_callbacks[callback_id] = function_
    end
end
