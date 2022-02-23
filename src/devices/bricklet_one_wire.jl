


export BrickletOneWireSearchBusLowLevel
struct BrickletOneWireSearchBusLowLevel
    identifier_length::Integer
    identifier_chunk_offset::Integer
    identifier_chunk_data::Vector{Integer}
    status::Integer
end

export BrickletOneWireRead
struct BrickletOneWireRead
    data::Integer
    status::Integer
end

export BrickletOneWireSPITFPErrorCount
struct BrickletOneWireSPITFPErrorCount
    error_count_ack_checksum::Integer
    error_count_message_checksum::Integer
    error_count_frame::Integer
    error_count_overflow::Integer
end

export BrickletOneWireIdentity
struct BrickletOneWireIdentity
    uid::String
    connected_uid::String
    position::Char
    hardware_version::Vector{Integer}
    firmware_version::Vector{Integer}
    device_identifier::Integer
end

export BrickletOneWireSearchBus
struct BrickletOneWireSearchBus
    identifier::Vector{Integer}
    status::Integer
end

export BrickletOneWire
"""
Communicates with up 64 1-Wire devices
"""
mutable struct BrickletOneWire <: TinkerforgeDevice
    ipcon::IPConnection
    deviceInternal::PyObject

    """
    Creates an object with the unique device ID *uid* and adds it to
    the IP Connection *ipcon*.
    """
    function BrickletOneWire(uid::String, ipcon::IPConnection)
        package = pyimport("tinkerforge.bricklet_one_wire")
        deviceInternal = package.BrickletOneWire(uid, ipcon.ipconInternal)

        return new(ipcon, deviceInternal)
    end
end

export search_bus_low_level
"""
    $(SIGNATURES)

Returns a list of up to 64 identifiers of the connected 1-Wire devices.
Each identifier is 64-bit and consists of 8-bit family code, 48-bit ID and
8-bit CRC.

To get these identifiers the Bricklet runs the
`SEARCH ROM algorithm <https://www.maximintegrated.com/en/app-notes/index.mvp/id/187>`__,
as defined by Maxim.
"""
function search_bus_low_level(device::BrickletOneWire)
    return device.deviceInternal.search_bus_low_level()
end

export reset_bus
"""
    $(SIGNATURES)

Resets the bus with the 1-Wire reset operation.
"""
function reset_bus(device::BrickletOneWire)
    return device.deviceInternal.reset_bus()
end

export write
"""
    $(SIGNATURES)

Writes a byte of data to the 1-Wire bus.
"""
function write(device::BrickletOneWire, data)
    return device.deviceInternal.write(data)
end

export read
"""
    $(SIGNATURES)

Reads a byte of data from the 1-Wire bus.
"""
function read(device::BrickletOneWire)
    return device.deviceInternal.read()
end

export write_command
"""
    $(SIGNATURES)

Writes a command to the 1-Wire device with the given identifier. You can obtain
the identifier by calling :func:`Search Bus`. The MATCH ROM operation is used to
write the command.

If you only have one device connected or want to broadcast to all devices
you can set the identifier to 0. In this case the SKIP ROM operation is used to
write the command.
"""
function write_command(device::BrickletOneWire, identifier, command)
    return device.deviceInternal.write_command(identifier, command)
end

export set_communication_led_config
"""
    $(SIGNATURES)

Sets the communication LED configuration. By default the LED shows 1-wire
communication traffic by flickering.

You can also turn the LED permanently on/off or show a heartbeat.

If the Bricklet is in bootloader mode, the LED is off.
"""
function set_communication_led_config(device::BrickletOneWire, config)
    device.deviceInternal.set_communication_led_config(config)
end

export get_communication_led_config
"""
    $(SIGNATURES)

Returns the configuration as set by :func:`Set Communication LED Config`
"""
function get_communication_led_config(device::BrickletOneWire)
    return device.deviceInternal.get_communication_led_config()
end

export get_spitfp_error_count
"""
    $(SIGNATURES)

Returns the error count for the communication between Brick and Bricklet.

The errors are divided into

* ACK checksum errors,
* message checksum errors,
* framing errors and
* overflow errors.

The errors counts are for errors that occur on the Bricklet side. All
Bricks have a similar function that returns the errors on the Brick side.
"""
function get_spitfp_error_count(device::BrickletOneWire)
    return device.deviceInternal.get_spitfp_error_count()
end

export set_bootloader_mode
"""
    $(SIGNATURES)

Sets the bootloader mode and returns the status after the requested
mode change was instigated.

You can change from bootloader mode to firmware mode and vice versa. A change
from bootloader mode to firmware mode will only take place if the entry function,
device identifier and CRC are present and correct.

This function is used by Brick Viewer during flashing. It should not be
necessary to call it in a normal user program.
"""
function set_bootloader_mode(device::BrickletOneWire, mode)
    return device.deviceInternal.set_bootloader_mode(mode)
end

export get_bootloader_mode
"""
    $(SIGNATURES)

Returns the current bootloader mode, see :func:`Set Bootloader Mode`.
"""
function get_bootloader_mode(device::BrickletOneWire)
    return device.deviceInternal.get_bootloader_mode()
end

export set_write_firmware_pointer
"""
    $(SIGNATURES)

Sets the firmware pointer for :func:`Write Firmware`. The pointer has
to be increased by chunks of size 64. The data is written to flash
every 4 chunks (which equals to one page of size 256).

This function is used by Brick Viewer during flashing. It should not be
necessary to call it in a normal user program.
"""
function set_write_firmware_pointer(device::BrickletOneWire, pointer)
    device.deviceInternal.set_write_firmware_pointer(pointer)
end

export write_firmware
"""
    $(SIGNATURES)

Writes 64 Bytes of firmware at the position as written by
:func:`Set Write Firmware Pointer` before. The firmware is written
to flash every 4 chunks.

You can only write firmware in bootloader mode.

This function is used by Brick Viewer during flashing. It should not be
necessary to call it in a normal user program.
"""
function write_firmware(device::BrickletOneWire, data)
    return device.deviceInternal.write_firmware(data)
end

export set_status_led_config
"""
    $(SIGNATURES)

Sets the status LED configuration. By default the LED shows
communication traffic between Brick and Bricklet, it flickers once
for every 10 received data packets.

You can also turn the LED permanently on/off or show a heartbeat.

If the Bricklet is in bootloader mode, the LED is will show heartbeat by default.
"""
function set_status_led_config(device::BrickletOneWire, config)
    device.deviceInternal.set_status_led_config(config)
end

export get_status_led_config
"""
    $(SIGNATURES)

Returns the configuration as set by :func:`Set Status LED Config`
"""
function get_status_led_config(device::BrickletOneWire)
    return device.deviceInternal.get_status_led_config()
end

export get_chip_temperature
"""
    $(SIGNATURES)

Returns the temperature as measured inside the microcontroller. The
value returned is not the ambient temperature!

The temperature is only proportional to the real temperature and it has bad
accuracy. Practically it is only useful as an indicator for
temperature changes.
"""
function get_chip_temperature(device::BrickletOneWire)
    return device.deviceInternal.get_chip_temperature()
end

export reset
"""
    $(SIGNATURES)

Calling this function will reset the Bricklet. All configurations
will be lost.

After a reset you have to create new device objects,
calling functions on the existing ones will result in
undefined behavior!
"""
function reset(device::BrickletOneWire)
    device.deviceInternal.reset()
end

export write_uid
"""
    $(SIGNATURES)

Writes a new UID into flash. If you want to set a new UID
you have to decode the Base58 encoded UID string into an
integer first.

We recommend that you use Brick Viewer to change the UID.
"""
function write_uid(device::BrickletOneWire, uid)
    device.deviceInternal.write_uid(uid)
end

export read_uid
"""
    $(SIGNATURES)

Returns the current UID as an integer. Encode as
Base58 to get the usual string version.
"""
function read_uid(device::BrickletOneWire)
    return device.deviceInternal.read_uid()
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
function get_identity(device::BrickletOneWire)
    return device.deviceInternal.get_identity()
end

export search_bus
"""
Returns a list of up to 64 identifiers of the connected 1-Wire devices.
Each identifier is 64-bit and consists of 8-bit family code, 48-bit ID and
8-bit CRC.

To get these identifiers the Bricklet runs the
`SEARCH ROM algorithm <https://www.maximintegrated.com/en/app-notes/index.mvp/id/187>`__,
as defined by Maxim.
"""
function search_bus(device::BrickletOneWire)

    lock(device.stream_lock) do
        ret = search_bus_low_level(device, )
            identifier_length = ret.identifier_length
        identifier_out_of_sync = ret.identifier_chunk_offset != 0

        identifier_data = ret.identifier_chunk_data

        while !identifier_out_of_sync && length(identifier_data) < identifier_length
            ret = search_bus_low_level(device, )
                identifier_length = ret.identifier_length
            identifier_out_of_sync = ret.identifier_chunk_offset != length(identifier_data)
            identifier_data += ret.identifier_chunk_data
        end

        if identifier_out_of_sync # discard remaining stream to bring it back in-sync
            while ret.identifier_chunk_offset + 7 < identifier_length
                ret = search_bus_low_level(device, )
                    identifier_length = ret.identifier_length
            end

            throw(TinkerforgeStreamOutOfSyncError("Identifier stream is out-of-sync"))
        end
    end

        return SearchBus(identifier_data[:identifier_length], ret.status)
end
