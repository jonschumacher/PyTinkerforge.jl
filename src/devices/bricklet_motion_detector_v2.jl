


export BrickletMotionDetectorV2Indicator
struct BrickletMotionDetectorV2Indicator
    top_left::Integer
    top_right::Integer
    bottom::Integer
end

export BrickletMotionDetectorV2SPITFPErrorCount
struct BrickletMotionDetectorV2SPITFPErrorCount
    error_count_ack_checksum::Integer
    error_count_message_checksum::Integer
    error_count_frame::Integer
    error_count_overflow::Integer
end

export BrickletMotionDetectorV2Identity
struct BrickletMotionDetectorV2Identity
    uid::String
    connected_uid::String
    position::Char
    hardware_version::Vector{Integer}
    firmware_version::Vector{Integer}
    device_identifier::Integer
end

export BrickletMotionDetectorV2
"""
Passive infrared (PIR) motion sensor with 12m range and dimmable backlight
"""
mutable struct BrickletMotionDetectorV2 <: TinkerforgeDevice
    ipcon::IPConnection
    deviceInternal::PyObject

    """
    Creates an object with the unique device ID *uid* and adds it to
    the IP Connection *ipcon*.
    """
    function BrickletMotionDetectorV2(uid::String, ipcon::IPConnection)
        package = pyimport("tinkerforge.bricklet_motion_detector_v2")
        deviceInternal = package.BrickletMotionDetectorV2(uid, ipcon.ipconInternal)

        return new(ipcon, deviceInternal)
    end
end

export get_motion_detected
"""
    $(SIGNATURES)

Returns 1 if a motion was detected. It returns 1 approx. for 1.8 seconds
until the sensor checks for a new movement.
"""
function get_motion_detected(device::BrickletMotionDetectorV2)
    return device.deviceInternal.get_motion_detected()
end

export set_sensitivity
"""
    $(SIGNATURES)

Sets the sensitivity of the PIR sensor. At full
sensitivity (100), the Bricklet can detect motion in a range of approximately 12m.

The actual range depends on many things in the environment (e.g. reflections) and the
size of the object to be detected. While a big person might be detected in a range
of 10m a cat may only be detected at 2m distance with the same setting.

So you will have to find a good sensitivity for your application by trial and error.
"""
function set_sensitivity(device::BrickletMotionDetectorV2, sensitivity)
    device.deviceInternal.set_sensitivity(sensitivity)
end

export get_sensitivity
"""
    $(SIGNATURES)

Returns the sensitivity as set by :func:`Set Sensitivity`.
"""
function get_sensitivity(device::BrickletMotionDetectorV2)
    return device.deviceInternal.get_sensitivity()
end

export set_indicator
"""
    $(SIGNATURES)

Sets the blue backlight of the fresnel lens. The backlight consists of
three LEDs. The brightness of each LED can be controlled with a 8-bit value
(0-255). A value of 0 turns the LED off and a value of 255 turns the LED
to full brightness.
"""
function set_indicator(device::BrickletMotionDetectorV2, top_left, top_right, bottom)
    device.deviceInternal.set_indicator(top_left, top_right, bottom)
end

export get_indicator
"""
    $(SIGNATURES)

Returns the indicator configuration as set by :func:`Set Indicator`.
"""
function get_indicator(device::BrickletMotionDetectorV2)
    return device.deviceInternal.get_indicator()
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
function get_spitfp_error_count(device::BrickletMotionDetectorV2)
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
function set_bootloader_mode(device::BrickletMotionDetectorV2, mode)
    return device.deviceInternal.set_bootloader_mode(mode)
end

export get_bootloader_mode
"""
    $(SIGNATURES)

Returns the current bootloader mode, see :func:`Set Bootloader Mode`.
"""
function get_bootloader_mode(device::BrickletMotionDetectorV2)
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
function set_write_firmware_pointer(device::BrickletMotionDetectorV2, pointer)
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
function write_firmware(device::BrickletMotionDetectorV2, data)
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
function set_status_led_config(device::BrickletMotionDetectorV2, config)
    device.deviceInternal.set_status_led_config(config)
end

export get_status_led_config
"""
    $(SIGNATURES)

Returns the configuration as set by :func:`Set Status LED Config`
"""
function get_status_led_config(device::BrickletMotionDetectorV2)
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
function get_chip_temperature(device::BrickletMotionDetectorV2)
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
function reset(device::BrickletMotionDetectorV2)
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
function write_uid(device::BrickletMotionDetectorV2, uid)
    device.deviceInternal.write_uid(uid)
end

export read_uid
"""
    $(SIGNATURES)

Returns the current UID as an integer. Encode as
Base58 to get the usual string version.
"""
function read_uid(device::BrickletMotionDetectorV2)
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
function get_identity(device::BrickletMotionDetectorV2)
    return device.deviceInternal.get_identity()
end

export register_callback
"""
Registers the given *function* with the given *callback_id*.
"""
function register_callback(device::BrickletMotionDetectorV2, callback_id, function_)
    if isnothing(function_)
        device.registered_callbacks.pop(callback_id, None)
    else
        device.registered_callbacks[callback_id] = function_
    end
end
