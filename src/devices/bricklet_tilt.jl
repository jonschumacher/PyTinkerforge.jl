


export BrickletTiltIdentity
struct BrickletTiltIdentity
    uid::String
    connected_uid::String
    position::Char
    hardware_version::Vector{Integer}
    firmware_version::Vector{Integer}
    device_identifier::Integer
end

export BrickletTilt
"""
Detects inclination of Bricklet (tilt switch open/closed)
"""
mutable struct BrickletTilt <: TinkerforgeDevice
    ipcon::IPConnection
    deviceInternal::PyObject

    """
    Creates an object with the unique device ID *uid* and adds it to
    the IP Connection *ipcon*.
    """
    function BrickletTilt(uid::String, ipcon::IPConnection)
        package = pyimport("tinkerforge.bricklet_tilt")
        deviceInternal = package.BrickletTilt(uid, ipcon.ipconInternal)

        return new(ipcon, deviceInternal)
    end
end

export get_tilt_state
"""
    $(SIGNATURES)

Returns the current tilt state. The state can either be

* 0 = Closed: The ball in the tilt switch closes the circuit.
* 1 = Open: The ball in the tilt switch does not close the circuit.
* 2 = Closed Vibrating: The tilt switch is in motion (rapid change between open and close).

.. image:: /Images/Bricklets/bricklet_tilt_mechanics.jpg
   :scale: 100 %
   :alt: Tilt states
   :align: center
   :target: ../../_images/Bricklets/bricklet_tilt_mechanics.jpg
"""
function get_tilt_state(device::BrickletTilt)
    return device.deviceInternal.get_tilt_state()
end

export enable_tilt_state_callback
"""
    $(SIGNATURES)

Enables the :cb:`Tilt State` callback.
"""
function enable_tilt_state_callback(device::BrickletTilt)
    device.deviceInternal.enable_tilt_state_callback()
end

export disable_tilt_state_callback
"""
    $(SIGNATURES)

Disables the :cb:`Tilt State` callback.
"""
function disable_tilt_state_callback(device::BrickletTilt)
    device.deviceInternal.disable_tilt_state_callback()
end

export is_tilt_state_callback_enabled
"""
    $(SIGNATURES)

Returns *true* if the :cb:`Tilt State` callback is enabled.
"""
function is_tilt_state_callback_enabled(device::BrickletTilt)
    return device.deviceInternal.is_tilt_state_callback_enabled()
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
function get_identity(device::BrickletTilt)
    return device.deviceInternal.get_identity()
end

export register_callback
"""
Registers the given *function* with the given *callback_id*.
"""
function register_callback(device::BrickletTilt, callback_id, function_)
    if isnothing(function_)
        device.registered_callbacks.pop(callback_id, None)
    else
        device.registered_callbacks[callback_id] = function_
    end
end
