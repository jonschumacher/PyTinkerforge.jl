


export BrickletRGBLEDRGBValue
struct BrickletRGBLEDRGBValue
    r::Integer
    g::Integer
    b::Integer
end

export BrickletRGBLEDIdentity
struct BrickletRGBLEDIdentity
    uid::String
    connected_uid::String
    position::Char
    hardware_version::Vector{Integer}
    firmware_version::Vector{Integer}
    device_identifier::Integer
end

export BrickletRGBLED
"""
Controls one RGB LED
"""
mutable struct BrickletRGBLED <: TinkerforgeDevice
    ipcon::IPConnection
    deviceInternal::PyObject

    """
    Creates an object with the unique device ID *uid* and adds it to
    the IP Connection *ipcon*.
    """
    function BrickletRGBLED(uid::String, ipcon::IPConnection)
        package = pyimport("tinkerforge.bricklet_rgb_led")
        deviceInternal = package.BrickletRGBLED(uid, ipcon.ipconInternal)

        return new(ipcon, deviceInternal)
    end
end

export set_rgb_value
"""
    $(SIGNATURES)

Sets the *r*, *g* and *b* values for the LED.
"""
function set_rgb_value(device::BrickletRGBLED, r, g, b)
    device.deviceInternal.set_rgb_value(r, g, b)
end

export get_rgb_value
"""
    $(SIGNATURES)

Returns the *r*, *g* and *b* values of the LED as set by :func:`Set RGB Value`.
"""
function get_rgb_value(device::BrickletRGBLED)
    return device.deviceInternal.get_rgb_value()
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
function get_identity(device::BrickletRGBLED)
    return device.deviceInternal.get_identity()
end
