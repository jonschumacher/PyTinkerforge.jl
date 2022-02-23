


export BrickletPiezoBuzzerIdentity
struct BrickletPiezoBuzzerIdentity
    uid::String
    connected_uid::String
    position::Char
    hardware_version::Vector{Integer}
    firmware_version::Vector{Integer}
    device_identifier::Integer
end

export BrickletPiezoBuzzer
"""
Creates 1kHz beep
"""
mutable struct BrickletPiezoBuzzer <: TinkerforgeDevice
    ipcon::IPConnection
    deviceInternal::PyObject

    """
    Creates an object with the unique device ID *uid* and adds it to
    the IP Connection *ipcon*.
    """
    function BrickletPiezoBuzzer(uid::String, ipcon::IPConnection)
        package = pyimport("tinkerforge.bricklet_piezo_buzzer")
        deviceInternal = package.BrickletPiezoBuzzer(uid, ipcon.ipconInternal)

        return new(ipcon, deviceInternal)
    end
end

export beep
"""
    $(SIGNATURES)

Beeps for the given duration.
"""
function beep(device::BrickletPiezoBuzzer, duration)
    device.deviceInternal.beep(duration)
end

export morse_code
"""
    $(SIGNATURES)

Sets morse code that will be played by the piezo buzzer. The morse code
is given as a string consisting of "." (dot), "-" (minus) and " " (space)
for *dits*, *dahs* and *pauses*. Every other character is ignored.

For example: If you set the string "...---...", the piezo buzzer will beep
nine times with the durations "short short short long long long short
short short".
"""
function morse_code(device::BrickletPiezoBuzzer, morse)
    device.deviceInternal.morse_code(morse)
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
function get_identity(device::BrickletPiezoBuzzer)
    return device.deviceInternal.get_identity()
end

export register_callback
"""
Registers the given *function* with the given *callback_id*.
"""
function register_callback(device::BrickletPiezoBuzzer, callback_id, function_)
    if isnothing(function_)
        device.registered_callbacks.pop(callback_id, None)
    else
        device.registered_callbacks[callback_id] = function_
    end
end
