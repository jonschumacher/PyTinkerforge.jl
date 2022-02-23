


export BrickletPiezoSpeakerIdentity
struct BrickletPiezoSpeakerIdentity
    uid::String
    connected_uid::String
    position::Char
    hardware_version::Vector{Integer}
    firmware_version::Vector{Integer}
    device_identifier::Integer
end

export BrickletPiezoSpeaker
"""
Creates beep with configurable frequency
"""
mutable struct BrickletPiezoSpeaker <: TinkerforgeDevice
    ipcon::IPConnection
    deviceInternal::PyObject

    """
    Creates an object with the unique device ID *uid* and adds it to
    the IP Connection *ipcon*.
    """
    function BrickletPiezoSpeaker(uid::String, ipcon::IPConnection)
        package = pyimport("tinkerforge.bricklet_piezo_speaker")
        deviceInternal = package.BrickletPiezoSpeaker(uid, ipcon.ipconInternal)

        return new(ipcon, deviceInternal)
    end
end

export beep
"""
    $(SIGNATURES)

Beeps with the given frequency for the given duration.

.. versionchanged:: 2.0.2\$nbsp;(Plugin)
   A duration of 0 stops the current beep if any, the frequency parameter is
   ignored. A duration of 4294967295 results in an infinite beep.

The Piezo Speaker Bricklet can only approximate the frequency, it will play
the best possible match by applying the calibration (see :func:`Calibrate`).
"""
function beep(device::BrickletPiezoSpeaker, duration, frequency)
    device.deviceInternal.beep(duration, frequency)
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
function morse_code(device::BrickletPiezoSpeaker, morse, frequency)
    device.deviceInternal.morse_code(morse, frequency)
end

export calibrate
"""
    $(SIGNATURES)

The Piezo Speaker Bricklet can play 512 different tones. This function
plays each tone and measures the exact frequency back. The result is a
mapping between setting value and frequency. This mapping is stored
in the EEPROM and loaded on startup.

The Bricklet should come calibrated, you only need to call this
function (once) every time you reflash the Bricklet plugin.

Returns *true* after the calibration finishes.
"""
function calibrate(device::BrickletPiezoSpeaker)
    return device.deviceInternal.calibrate()
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
function get_identity(device::BrickletPiezoSpeaker)
    return device.deviceInternal.get_identity()
end

export register_callback
"""
Registers the given *function* with the given *callback_id*.
"""
function register_callback(device::BrickletPiezoSpeaker, callback_id, function_)
    if isnothing(function_)
        device.registered_callbacks.pop(callback_id, None)
    else
        device.registered_callbacks[callback_id] = function_
    end
end
