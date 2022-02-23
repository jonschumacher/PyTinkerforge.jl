


export BrickletRGBLEDButtonColor
struct BrickletRGBLEDButtonColor
    red::Integer
    green::Integer
    blue::Integer
end

export BrickletRGBLEDButtonColorCalibration
struct BrickletRGBLEDButtonColorCalibration
    red::Integer
    green::Integer
    blue::Integer
end

export BrickletRGBLEDButtonSPITFPErrorCount
struct BrickletRGBLEDButtonSPITFPErrorCount
    error_count_ack_checksum::Integer
    error_count_message_checksum::Integer
    error_count_frame::Integer
    error_count_overflow::Integer
end

export BrickletRGBLEDButtonIdentity
struct BrickletRGBLEDButtonIdentity
    uid::String
    connected_uid::String
    position::Char
    hardware_version::Vector{Integer}
    firmware_version::Vector{Integer}
    device_identifier::Integer
end

export BrickletRGBLEDButton
"""
Push button with built-in RGB LED
"""
mutable struct BrickletRGBLEDButton <: TinkerforgeDevice
    ipcon::IPConnection
    deviceInternal::PyObject

    """
    Creates an object with the unique device ID *uid* and adds it to
    the IP Connection *ipcon*.
    """
    function BrickletRGBLEDButton(uid::String, ipcon::IPConnection)
        package = pyimport("tinkerforge.bricklet_rgb_led_button")
        deviceInternal = package.BrickletRGBLEDButton(uid, ipcon.ipconInternal)

        return new(ipcon, deviceInternal)
    end
end

export set_color
"""
    $(SIGNATURES)

Sets the color of the LED.
"""
function set_color(device::BrickletRGBLEDButton, red, green, blue)
    device.deviceInternal.set_color(red, green, blue)
end

export get_color
"""
    $(SIGNATURES)

Returns the LED color as set by :func:`Set Color`.
"""
function get_color(device::BrickletRGBLEDButton)
    return device.deviceInternal.get_color()
end

export get_button_state
"""
    $(SIGNATURES)

Returns the current state of the button (either pressed or released).
"""
function get_button_state(device::BrickletRGBLEDButton)
    return device.deviceInternal.get_button_state()
end

export set_color_calibration
"""
    $(SIGNATURES)

Sets a color calibration. Some colors appear brighter then others,
so a calibration may be necessary for uniform colors.

The calibration is saved in flash. You don't need to call this
function on every startup.
"""
function set_color_calibration(device::BrickletRGBLEDButton, red, green, blue)
    device.deviceInternal.set_color_calibration(red, green, blue)
end

export get_color_calibration
"""
    $(SIGNATURES)

Returns the color calibration as set by :func:`Set Color Calibration`.
"""
function get_color_calibration(device::BrickletRGBLEDButton)
    return device.deviceInternal.get_color_calibration()
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
function get_spitfp_error_count(device::BrickletRGBLEDButton)
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
function set_bootloader_mode(device::BrickletRGBLEDButton, mode)
    return device.deviceInternal.set_bootloader_mode(mode)
end

export get_bootloader_mode
"""
    $(SIGNATURES)

Returns the current bootloader mode, see :func:`Set Bootloader Mode`.
"""
function get_bootloader_mode(device::BrickletRGBLEDButton)
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
function set_write_firmware_pointer(device::BrickletRGBLEDButton, pointer)
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
function write_firmware(device::BrickletRGBLEDButton, data)
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
function set_status_led_config(device::BrickletRGBLEDButton, config)
    device.deviceInternal.set_status_led_config(config)
end

export get_status_led_config
"""
    $(SIGNATURES)

Returns the configuration as set by :func:`Set Status LED Config`
"""
function get_status_led_config(device::BrickletRGBLEDButton)
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
function get_chip_temperature(device::BrickletRGBLEDButton)
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
function reset(device::BrickletRGBLEDButton)
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
function write_uid(device::BrickletRGBLEDButton, uid)
    device.deviceInternal.write_uid(uid)
end

export read_uid
"""
    $(SIGNATURES)

Returns the current UID as an integer. Encode as
Base58 to get the usual string version.
"""
function read_uid(device::BrickletRGBLEDButton)
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
function get_identity(device::BrickletRGBLEDButton)
    return device.deviceInternal.get_identity()
end

export register_callback
"""
Registers the given *function* with the given *callback_id*.
"""
function register_callback(device::BrickletRGBLEDButton, callback_id, function_)
    if isnothing(function_)
        device.registered_callbacks.pop(callback_id, None)
    else
        device.registered_callbacks[callback_id] = function_
    end
end
