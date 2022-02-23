


export BrickletRemoteSwitchIdentity
struct BrickletRemoteSwitchIdentity
    uid::String
    connected_uid::String
    position::Char
    hardware_version::Vector{Integer}
    firmware_version::Vector{Integer}
    device_identifier::Integer
end

export BrickletRemoteSwitch
"""
Controls remote mains switches
"""
mutable struct BrickletRemoteSwitch <: TinkerforgeDevice
    ipcon::IPConnection
    deviceInternal::PyObject

    """
    Creates an object with the unique device ID *uid* and adds it to
    the IP Connection *ipcon*.
    """
    function BrickletRemoteSwitch(uid::String, ipcon::IPConnection)
        package = pyimport("tinkerforge.bricklet_remote_switch")
        deviceInternal = package.BrickletRemoteSwitch(uid, ipcon.ipconInternal)

        return new(ipcon, deviceInternal)
    end
end

export switch_socket
"""
    $(SIGNATURES)

This function is deprecated, use :func:`Switch Socket A` instead.
"""
function switch_socket(device::BrickletRemoteSwitch, house_code, receiver_code, switch_to)
    device.deviceInternal.switch_socket(house_code, receiver_code, switch_to)
end

export get_switching_state
"""
    $(SIGNATURES)

Returns the current switching state. If the current state is busy, the
Bricklet is currently sending a code to switch a socket. It will not
accept any requests to switch sockets until the state changes to ready.

How long the switching takes is dependent on the number of repeats, see
:func:`Set Repeats`.
"""
function get_switching_state(device::BrickletRemoteSwitch)
    return device.deviceInternal.get_switching_state()
end

export set_repeats
"""
    $(SIGNATURES)

Sets the number of times the code is sent when one of the switch socket
functions is called. The repeats basically correspond to the amount of time
that a button of the remote is pressed.

Some dimmers are controlled by the length of a button pressed,
this can be simulated by increasing the repeats.
"""
function set_repeats(device::BrickletRemoteSwitch, repeats)
    device.deviceInternal.set_repeats(repeats)
end

export get_repeats
"""
    $(SIGNATURES)

Returns the number of repeats as set by :func:`Set Repeats`.
"""
function get_repeats(device::BrickletRemoteSwitch)
    return device.deviceInternal.get_repeats()
end

export switch_socket_a
"""
    $(SIGNATURES)

To switch a type A socket you have to give the house code, receiver code and the
state (on or off) you want to switch to.

A detailed description on how you can figure out the house and receiver code
can be found :ref:`here <remote_switch_bricklet_type_a_house_and_receiver_code>`.

.. versionadded:: 2.0.1\$nbsp;(Plugin)
"""
function switch_socket_a(device::BrickletRemoteSwitch, house_code, receiver_code, switch_to)
    device.deviceInternal.switch_socket_a(house_code, receiver_code, switch_to)
end

export switch_socket_b
"""
    $(SIGNATURES)

To switch a type B socket you have to give the address, unit and the state
(on or off) you want to switch to.

To switch all devices with the same address use 255 for the unit.

A detailed description on how you can teach a socket the address and unit can
be found :ref:`here <remote_switch_bricklet_type_b_address_and_unit>`.

.. versionadded:: 2.0.1\$nbsp;(Plugin)
"""
function switch_socket_b(device::BrickletRemoteSwitch, address, unit, switch_to)
    device.deviceInternal.switch_socket_b(address, unit, switch_to)
end

export dim_socket_b
"""
    $(SIGNATURES)

To control a type B dimmer you have to give the address, unit and the
dim value you want to set the dimmer to.

A detailed description on how you can teach a dimmer the address and unit can
be found :ref:`here <remote_switch_bricklet_type_b_address_and_unit>`.

.. versionadded:: 2.0.1\$nbsp;(Plugin)
"""
function dim_socket_b(device::BrickletRemoteSwitch, address, unit, dim_value)
    device.deviceInternal.dim_socket_b(address, unit, dim_value)
end

export switch_socket_c
"""
    $(SIGNATURES)

To switch a type C socket you have to give the system code, device code and the
state (on or off) you want to switch to.

A detailed description on how you can figure out the system and device code
can be found :ref:`here <remote_switch_bricklet_type_c_system_and_device_code>`.

.. versionadded:: 2.0.1\$nbsp;(Plugin)
"""
function switch_socket_c(device::BrickletRemoteSwitch, system_code, device_code, switch_to)
    device.deviceInternal.switch_socket_c(system_code, device_code, switch_to)
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
function get_identity(device::BrickletRemoteSwitch)
    return device.deviceInternal.get_identity()
end

export register_callback
"""
Registers the given *function* with the given *callback_id*.
"""
function register_callback(device::BrickletRemoteSwitch, callback_id, function_)
    if isnothing(function_)
        device.registered_callbacks.pop(callback_id, None)
    else
        device.registered_callbacks[callback_id] = function_
    end
end
