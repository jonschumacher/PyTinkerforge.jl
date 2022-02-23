


export BrickletAnalogOutV2Identity
struct BrickletAnalogOutV2Identity
    uid::String
    connected_uid::String
    position::Char
    hardware_version::Vector{Integer}
    firmware_version::Vector{Integer}
    device_identifier::Integer
end

export BrickletAnalogOutV2
"""
Generates configurable DC voltage between 0V and 12V
"""
mutable struct BrickletAnalogOutV2 <: TinkerforgeDevice
    ipcon::IPConnection
    deviceInternal::PyObject

    """
    Creates an object with the unique device ID *uid* and adds it to
    the IP Connection *ipcon*.
    """
    function BrickletAnalogOutV2(uid::String, ipcon::IPConnection)
        package = pyimport("tinkerforge.bricklet_analog_out_v2")
        deviceInternal = package.BrickletAnalogOutV2(uid, ipcon.ipconInternal)

        return new(ipcon, deviceInternal)
    end
end

export set_output_voltage
"""
    $(SIGNATURES)

Sets the voltage.
"""
function set_output_voltage(device::BrickletAnalogOutV2, voltage)
    device.deviceInternal.set_output_voltage(voltage)
end

export get_output_voltage
"""
    $(SIGNATURES)

Returns the voltage as set by :func:`Set Output Voltage`.
"""
function get_output_voltage(device::BrickletAnalogOutV2)
    return device.deviceInternal.get_output_voltage()
end

export get_input_voltage
"""
    $(SIGNATURES)

Returns the input voltage.
"""
function get_input_voltage(device::BrickletAnalogOutV2)
    return device.deviceInternal.get_input_voltage()
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
function get_identity(device::BrickletAnalogOutV2)
    return device.deviceInternal.get_identity()
end
