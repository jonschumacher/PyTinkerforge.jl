


export BrickletHallEffectEdgeCountConfig
struct BrickletHallEffectEdgeCountConfig
    edge_type::Integer
    debounce::Integer
end

export BrickletHallEffectEdgeInterrupt
struct BrickletHallEffectEdgeInterrupt
    count::Integer
    value::Bool
end

export BrickletHallEffectIdentity
struct BrickletHallEffectIdentity
    uid::String
    connected_uid::String
    position::Char
    hardware_version::Vector{Integer}
    firmware_version::Vector{Integer}
    device_identifier::Integer
end

export BrickletHallEffect
"""
Detects presence of magnetic field
"""
mutable struct BrickletHallEffect <: TinkerforgeDevice
    ipcon::IPConnection
    deviceInternal::PyObject

    """
    Creates an object with the unique device ID *uid* and adds it to
    the IP Connection *ipcon*.
    """
    function BrickletHallEffect(uid::String, ipcon::IPConnection)
        package = pyimport("tinkerforge.bricklet_hall_effect")
        deviceInternal = package.BrickletHallEffect(uid, ipcon.ipconInternal)

        return new(ipcon, deviceInternal)
    end
end

export get_value
"""
    $(SIGNATURES)

Returns *true* if a magnetic field of 3.5 millitesla or greater is detected.
"""
function get_value(device::BrickletHallEffect)
    return device.deviceInternal.get_value()
end

export get_edge_count
"""
    $(SIGNATURES)

Returns the current value of the edge counter. You can configure
edge type (rising, falling, both) that is counted with
:func:`Set Edge Count Config`.

If you set the reset counter to *true*, the count is set back to 0
directly after it is read.
"""
function get_edge_count(device::BrickletHallEffect, reset_counter)
    return device.deviceInternal.get_edge_count(reset_counter)
end

export set_edge_count_config
"""
    $(SIGNATURES)

The edge type parameter configures if rising edges, falling edges or
both are counted. Possible edge types are:

* 0 = rising
* 1 = falling
* 2 = both

A magnetic field of 3.5 millitesla or greater causes a falling edge and a
magnetic field of 2.5 millitesla or smaller causes a rising edge.

If a magnet comes near the Bricklet the signal goes low (falling edge), if
a magnet is removed from the vicinity the signal goes high (rising edge).

Configuring an edge counter resets its value to 0.

If you don't know what any of this means, just leave it at default. The
default configuration is very likely OK for you.
"""
function set_edge_count_config(device::BrickletHallEffect, edge_type, debounce)
    device.deviceInternal.set_edge_count_config(edge_type, debounce)
end

export get_edge_count_config
"""
    $(SIGNATURES)

Returns the edge type and debounce time as set by :func:`Set Edge Count Config`.
"""
function get_edge_count_config(device::BrickletHallEffect)
    return device.deviceInternal.get_edge_count_config()
end

export set_edge_interrupt
"""
    $(SIGNATURES)

Sets the number of edges until an interrupt is invoked.

If *edges* is set to n, an interrupt is invoked for every n-th detected edge.

If *edges* is set to 0, the interrupt is disabled.
"""
function set_edge_interrupt(device::BrickletHallEffect, edges)
    device.deviceInternal.set_edge_interrupt(edges)
end

export get_edge_interrupt
"""
    $(SIGNATURES)

Returns the edges as set by :func:`Set Edge Interrupt`.
"""
function get_edge_interrupt(device::BrickletHallEffect)
    return device.deviceInternal.get_edge_interrupt()
end

export set_edge_count_callback_period
"""
    $(SIGNATURES)

Sets the period with which the :cb:`Edge Count` callback is triggered
periodically. A value of 0 turns the callback off.

The :cb:`Edge Count` callback is only triggered if the edge count has changed
since the last triggering.
"""
function set_edge_count_callback_period(device::BrickletHallEffect, period)
    device.deviceInternal.set_edge_count_callback_period(period)
end

export get_edge_count_callback_period
"""
    $(SIGNATURES)

Returns the period as set by :func:`Set Edge Count Callback Period`.
"""
function get_edge_count_callback_period(device::BrickletHallEffect)
    return device.deviceInternal.get_edge_count_callback_period()
end

export edge_interrupt
"""
    $(SIGNATURES)

This callback is triggered every n-th count, as configured with
:func:`Set Edge Interrupt`. The parameters are the
current count and the current value (see :func:`Get Value` and
:func:`Get Edge Count`).
"""
function edge_interrupt(device::BrickletHallEffect)
    return device.deviceInternal.edge_interrupt()
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
function get_identity(device::BrickletHallEffect)
    return device.deviceInternal.get_identity()
end

export register_callback
"""
Registers the given *function* with the given *callback_id*.
"""
function register_callback(device::BrickletHallEffect, callback_id, function_)
    if isnothing(function_)
        device.registered_callbacks.pop(callback_id, None)
    else
        device.registered_callbacks[callback_id] = function_
    end
end
