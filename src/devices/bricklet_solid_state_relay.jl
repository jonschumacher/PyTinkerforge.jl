


export BrickletSolidStateRelayMonoflop
struct BrickletSolidStateRelayMonoflop
    state::Bool
    time::Integer
    time_remaining::Integer
end

export BrickletSolidStateRelayIdentity
struct BrickletSolidStateRelayIdentity
    uid::String
    connected_uid::String
    position::Char
    hardware_version::Vector{Integer}
    firmware_version::Vector{Integer}
    device_identifier::Integer
end

export BrickletSolidStateRelay
"""
Controls AC and DC Solid State Relays
"""
mutable struct BrickletSolidStateRelay <: TinkerforgeDevice
    ipcon::IPConnection
    deviceInternal::PyObject

    """
    Creates an object with the unique device ID *uid* and adds it to
    the IP Connection *ipcon*.
    """
    function BrickletSolidStateRelay(uid::String, ipcon::IPConnection)
        package = pyimport("tinkerforge.bricklet_solid_state_relay")
        deviceInternal = package.BrickletSolidStateRelay(uid, ipcon.ipconInternal)

        return new(ipcon, deviceInternal)
    end
end

export set_state
"""
    $(SIGNATURES)

Sets the state of the relays *true* means on and *false* means off.

A running monoflop timer will be aborted if this function is called.
"""
function set_state(device::BrickletSolidStateRelay, state)
    device.deviceInternal.set_state(state)
end

export get_state
"""
    $(SIGNATURES)

Returns the state of the relay, *true* means on and *false* means off.
"""
function get_state(device::BrickletSolidStateRelay)
    return device.deviceInternal.get_state()
end

export set_monoflop
"""
    $(SIGNATURES)

The first parameter  is the desired state of the relay (*true* means on
and *false* means off). The second parameter indicates the time that
the relay should hold the state.

If this function is called with the parameters (true, 1500):
The relay will turn on and in 1.5s it will turn off again.

A monoflop can be used as a failsafe mechanism. For example: Lets assume you
have a RS485 bus and a Solid State Relay Bricklet connected to one of the slave
stacks. You can now call this function every second, with a time parameter
of two seconds. The relay will be on all the time. If now the RS485
connection is lost, the relay will turn off in at most two seconds.
"""
function set_monoflop(device::BrickletSolidStateRelay, state, time)
    device.deviceInternal.set_monoflop(state, time)
end

export get_monoflop
"""
    $(SIGNATURES)

Returns the current state and the time as set by
:func:`Set Monoflop` as well as the remaining time until the state flips.

If the timer is not running currently, the remaining time will be returned
as 0.
"""
function get_monoflop(device::BrickletSolidStateRelay)
    return device.deviceInternal.get_monoflop()
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
function get_identity(device::BrickletSolidStateRelay)
    return device.deviceInternal.get_identity()
end

export register_callback
"""
Registers the given *function* with the given *callback_id*.
"""
function register_callback(device::BrickletSolidStateRelay, callback_id, function_)
    if isnothing(function_)
        device.registered_callbacks.pop(callback_id, None)
    else
        device.registered_callbacks[callback_id] = function_
    end
end
