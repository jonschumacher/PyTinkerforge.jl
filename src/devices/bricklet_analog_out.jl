


export BrickletAnalogOutIdentity
struct BrickletAnalogOutIdentity
    uid::String
    connected_uid::String
    position::Char
    hardware_version::Vector{Integer}
    firmware_version::Vector{Integer}
    device_identifier::Integer
end

export BrickletAnalogOut
"""
Generates configurable DC voltage between 0V and 5V
"""
mutable struct BrickletAnalogOut <: TinkerforgeDevice
    ipcon::IPConnection
    deviceInternal::PyObject

    """
    Creates an object with the unique device ID *uid* and adds it to
    the IP Connection *ipcon*.
    """
    function BrickletAnalogOut(uid::String, ipcon::IPConnection)
        package = pyimport("tinkerforge.bricklet_analog_out")
        deviceInternal = package.BrickletAnalogOut(uid, ipcon.ipconInternal)

        return new(ipcon, deviceInternal)
    end
end

export set_voltage
"""
    $(SIGNATURES)

Sets the voltage. Calling this function will set
the mode to 0 (see :func:`Set Mode`).
"""
function set_voltage(device::BrickletAnalogOut, voltage)
    device.deviceInternal.set_voltage(voltage)
end

export get_voltage
"""
    $(SIGNATURES)

Returns the voltage as set by :func:`Set Voltage`.
"""
function get_voltage(device::BrickletAnalogOut)
    return device.deviceInternal.get_voltage()
end

export set_mode
"""
    $(SIGNATURES)

Sets the mode of the analog value. Possible modes:

* 0: Normal Mode (Analog value as set by :func:`Set Voltage` is applied)
* 1: 1k Ohm resistor to ground
* 2: 100k Ohm resistor to ground
* 3: 500k Ohm resistor to ground

Setting the mode to 0 will result in an output voltage of 0 V. You can jump
to a higher output voltage directly by calling :func:`Set Voltage`.
"""
function set_mode(device::BrickletAnalogOut, mode)
    device.deviceInternal.set_mode(mode)
end

export get_mode
"""
    $(SIGNATURES)

Returns the mode as set by :func:`Set Mode`.
"""
function get_mode(device::BrickletAnalogOut)
    return device.deviceInternal.get_mode()
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
function get_identity(device::BrickletAnalogOut)
    return device.deviceInternal.get_identity()
end
