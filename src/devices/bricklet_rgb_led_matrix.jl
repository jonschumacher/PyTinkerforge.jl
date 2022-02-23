


export BrickletRGBLEDMatrixSPITFPErrorCount
struct BrickletRGBLEDMatrixSPITFPErrorCount
    error_count_ack_checksum::Integer
    error_count_message_checksum::Integer
    error_count_frame::Integer
    error_count_overflow::Integer
end

export BrickletRGBLEDMatrixIdentity
struct BrickletRGBLEDMatrixIdentity
    uid::String
    connected_uid::String
    position::Char
    hardware_version::Vector{Integer}
    firmware_version::Vector{Integer}
    device_identifier::Integer
end

export BrickletRGBLEDMatrix
"""
RGB LED Matrix with 8x8 pixel
"""
mutable struct BrickletRGBLEDMatrix <: TinkerforgeDevice
    ipcon::IPConnection
    deviceInternal::PyObject

    """
    Creates an object with the unique device ID *uid* and adds it to
    the IP Connection *ipcon*.
    """
    function BrickletRGBLEDMatrix(uid::String, ipcon::IPConnection)
        package = pyimport("tinkerforge.bricklet_rgb_led_matrix")
        deviceInternal = package.BrickletRGBLEDMatrix(uid, ipcon.ipconInternal)

        return new(ipcon, deviceInternal)
    end
end

export set_red
"""
    $(SIGNATURES)

Sets the 64 red LED values of the matrix.
"""
function set_red(device::BrickletRGBLEDMatrix, red)
    device.deviceInternal.set_red(red)
end

export get_red
"""
    $(SIGNATURES)

Returns the red LED values as set by :func:`Set Red`.
"""
function get_red(device::BrickletRGBLEDMatrix)
    return device.deviceInternal.get_red()
end

export set_green
"""
    $(SIGNATURES)

Sets the 64 green LED values of the matrix.
"""
function set_green(device::BrickletRGBLEDMatrix, green)
    device.deviceInternal.set_green(green)
end

export get_green
"""
    $(SIGNATURES)

Returns the green LED values as set by :func:`Set Green`.
"""
function get_green(device::BrickletRGBLEDMatrix)
    return device.deviceInternal.get_green()
end

export set_blue
"""
    $(SIGNATURES)

Sets the 64 blue LED values of the matrix.
"""
function set_blue(device::BrickletRGBLEDMatrix, blue)
    device.deviceInternal.set_blue(blue)
end

export get_blue
"""
    $(SIGNATURES)

Returns the blue LED values as set by :func:`Set Blue`.
"""
function get_blue(device::BrickletRGBLEDMatrix)
    return device.deviceInternal.get_blue()
end

export set_frame_duration
"""
    $(SIGNATURES)

Sets the frame duration.

Example: If you want to achieve 20 frames per second, you should
set the frame duration to 50ms (50ms * 20 = 1 second).

Set this value to 0 to turn the automatic frame write mechanism off.

Approach:

* Call :func:`Set Frame Duration` with value > 0.
* Set LED values for first frame with :func:`Set Red`, :func:`Set Green`, :func:`Set Blue`.
* Wait for :cb:`Frame Started` callback.
* Set LED values for second frame with :func:`Set Red`, :func:`Set Green`, :func:`Set Blue`.
* Wait for :cb:`Frame Started` callback.
* and so on.

For frame duration of 0 see :func:`Draw Frame`.
"""
function set_frame_duration(device::BrickletRGBLEDMatrix, frame_duration)
    device.deviceInternal.set_frame_duration(frame_duration)
end

export get_frame_duration
"""
    $(SIGNATURES)

Returns the frame duration as set by :func:`Set Frame Duration`.
"""
function get_frame_duration(device::BrickletRGBLEDMatrix)
    return device.deviceInternal.get_frame_duration()
end

export draw_frame
"""
    $(SIGNATURES)

If you set the frame duration to 0 (see :func:`Set Frame Duration`), you can use this
function to transfer the frame to the matrix.

Approach:

* Call :func:`Set Frame Duration` with 0.
* Set LED values for first frame with :func:`Set Red`, :func:`Set Green`, :func:`Set Blue`.
* Call :func:`Draw Frame`.
* Wait for :cb:`Frame Started` callback.
* Set LED values for second frame with :func:`Set Red`, :func:`Set Green`, :func:`Set Blue`.
* Call :func:`Draw Frame`.
* Wait for :cb:`Frame Started` callback.
* and so on.
"""
function draw_frame(device::BrickletRGBLEDMatrix)
    device.deviceInternal.draw_frame()
end

export get_supply_voltage
"""
    $(SIGNATURES)

Returns the current supply voltage of the Bricklet.
"""
function get_supply_voltage(device::BrickletRGBLEDMatrix)
    return device.deviceInternal.get_supply_voltage()
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
function get_spitfp_error_count(device::BrickletRGBLEDMatrix)
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
function set_bootloader_mode(device::BrickletRGBLEDMatrix, mode)
    return device.deviceInternal.set_bootloader_mode(mode)
end

export get_bootloader_mode
"""
    $(SIGNATURES)

Returns the current bootloader mode, see :func:`Set Bootloader Mode`.
"""
function get_bootloader_mode(device::BrickletRGBLEDMatrix)
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
function set_write_firmware_pointer(device::BrickletRGBLEDMatrix, pointer)
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
function write_firmware(device::BrickletRGBLEDMatrix, data)
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
function set_status_led_config(device::BrickletRGBLEDMatrix, config)
    device.deviceInternal.set_status_led_config(config)
end

export get_status_led_config
"""
    $(SIGNATURES)

Returns the configuration as set by :func:`Set Status LED Config`
"""
function get_status_led_config(device::BrickletRGBLEDMatrix)
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
function get_chip_temperature(device::BrickletRGBLEDMatrix)
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
function reset(device::BrickletRGBLEDMatrix)
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
function write_uid(device::BrickletRGBLEDMatrix, uid)
    device.deviceInternal.write_uid(uid)
end

export read_uid
"""
    $(SIGNATURES)

Returns the current UID as an integer. Encode as
Base58 to get the usual string version.
"""
function read_uid(device::BrickletRGBLEDMatrix)
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
function get_identity(device::BrickletRGBLEDMatrix)
    return device.deviceInternal.get_identity()
end

export register_callback
"""
Registers the given *function* with the given *callback_id*.
"""
function register_callback(device::BrickletRGBLEDMatrix, callback_id, function_)
    if isnothing(function_)
        device.registered_callbacks.pop(callback_id, None)
    else
        device.registered_callbacks[callback_id] = function_
    end
end
