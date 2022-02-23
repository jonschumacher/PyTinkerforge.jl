


export BrickletIndustrialDigitalOut4Monoflop
struct BrickletIndustrialDigitalOut4Monoflop
    value::Integer
    time::Integer
    time_remaining::Integer
end

export BrickletIndustrialDigitalOut4Identity
struct BrickletIndustrialDigitalOut4Identity
    uid::String
    connected_uid::String
    position::Char
    hardware_version::Vector{Integer}
    firmware_version::Vector{Integer}
    device_identifier::Integer
end

export BrickletIndustrialDigitalOut4
"""
4 galvanically isolated digital outputs
"""
mutable struct BrickletIndustrialDigitalOut4 <: TinkerforgeDevice
    ipcon::IPConnection
    deviceInternal::PyObject

    """
    Creates an object with the unique device ID *uid* and adds it to
    the IP Connection *ipcon*.
    """
    function BrickletIndustrialDigitalOut4(uid::String, ipcon::IPConnection)
        package = pyimport("tinkerforge.bricklet_industrial_digital_out_4")
        deviceInternal = package.BrickletIndustrialDigitalOut4(uid, ipcon.ipconInternal)

        return new(ipcon, deviceInternal)
    end
end

export set_value
"""
    $(SIGNATURES)

Sets the output value with a bitmask (16bit). A 1 in the bitmask means high
and a 0 in the bitmask means low.

For example: The value 3 or 0b0011 will turn pins 0-1 high and the other pins
low.

If no groups are used (see :func:`Set Group`), the pins correspond to the
markings on the Industrial Digital Out 4 Bricklet.

If groups are used, the pins correspond to the element in the group.
Element 1 in the group will get pins 0-3, element 2 pins 4-7, element 3
pins 8-11 and element 4 pins 12-15.

All running monoflop timers will be aborted if this function is called.
"""
function set_value(device::BrickletIndustrialDigitalOut4, value_mask)
    device.deviceInternal.set_value(value_mask)
end

export get_value
"""
    $(SIGNATURES)

Returns the bitmask as set by :func:`Set Value`.
"""
function get_value(device::BrickletIndustrialDigitalOut4)
    return device.deviceInternal.get_value()
end

export set_monoflop
"""
    $(SIGNATURES)

Configures a monoflop of the pins specified by the first parameter
bitmask.

The second parameter is a bitmask with the desired value of the specified
pins. A 1 in the bitmask means high and a 0 in the bitmask means low.

The third parameter indicates the time that the pins should hold
the value.

If this function is called with the parameters (9, 1, 1500) or
(0b1001, 0b0001, 1500): Pin 0 will get high and pin 3 will get low. In 1.5s
pin 0 will get low and pin 3 will get high again.

A monoflop can be used as a fail-safe mechanism. For example: Lets assume you
have a RS485 bus and a Digital Out 4 Bricklet connected to one of the slave
stacks. You can now call this function every second, with a time parameter
of two seconds and pin 0 high. Pin 0 will be high all the time. If now
the RS485 connection is lost, then pin 0 will turn low in at most two seconds.
"""
function set_monoflop(device::BrickletIndustrialDigitalOut4, selection_mask, value_mask, time)
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
function get_monoflop(device::BrickletIndustrialDigitalOut4, pin)
    return device.deviceInternal.get_monoflop(pin)
end

export set_group
"""
    $(SIGNATURES)

Sets a group of Digital Out 4 Bricklets that should work together. You can
find Bricklets that can be grouped together with :func:`Get Available For Group`.

The group consists of 4 elements. Element 1 in the group will get pins 0-3,
element 2 pins 4-7, element 3 pins 8-11 and element 4 pins 12-15.

Each element can either be one of the ports ('a' to 'd') or 'n' if it should
not be used.

For example: If you have two Digital Out 4 Bricklets connected to port A and
port B respectively, you could call with ``['a', 'b', 'n', 'n']``.

Now the pins on the Digital Out 4 on port A are assigned to 0-3 and the
pins on the Digital Out 4 on port B are assigned to 4-7. It is now possible
to call :func:`Set Value` and control two Bricklets at the same time.
"""
function set_group(device::BrickletIndustrialDigitalOut4, group)
    device.deviceInternal.set_group(group)
end

export get_group
"""
    $(SIGNATURES)

Returns the group as set by :func:`Set Group`
"""
function get_group(device::BrickletIndustrialDigitalOut4)
    return device.deviceInternal.get_group()
end

export get_available_for_group
"""
    $(SIGNATURES)

Returns a bitmask of ports that are available for grouping. For example the
value 5 or 0b0101 means: Port A and port C are connected to Bricklets that
can be grouped together.
"""
function get_available_for_group(device::BrickletIndustrialDigitalOut4)
    return device.deviceInternal.get_available_for_group()
end

export set_selected_values
"""
    $(SIGNATURES)

Sets the output value with a bitmask, according to the selection mask.
The bitmask is 16 bit long, *true* refers to high and *false* refers to
low.

For example: The values (3, 1) or (0b0011, 0b0001) will turn pin 0 high, pin 1
low the other pins remain untouched.

If no groups are used (see :func:`Set Group`), the pins correspond to the
markings on the Industrial Digital Out 4 Bricklet.

If groups are used, the pins correspond to the element in the group.
Element 1 in the group will get pins 0-3, element 2 pins 4-7, element 3
pins 8-11 and element 4 pins 12-15.

Running monoflop timers for the selected pins will be aborted if this function
is called.
"""
function set_selected_values(device::BrickletIndustrialDigitalOut4, selection_mask, value_mask)
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
function get_identity(device::BrickletIndustrialDigitalOut4)
    return device.deviceInternal.get_identity()
end

export register_callback
"""
Registers the given *function* with the given *callback_id*.
"""
function register_callback(device::BrickletIndustrialDigitalOut4, callback_id, function_)
    if isnothing(function_)
        device.registered_callbacks.pop(callback_id, None)
    else
        device.registered_callbacks[callback_id] = function_
    end
end
