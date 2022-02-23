


export BrickletPiezoSpeakerV2Beep
struct BrickletPiezoSpeakerV2Beep
    frequency::Integer
    volume::Integer
    duration::Integer
    duration_remaining::Integer
end

export BrickletPiezoSpeakerV2Alarm
struct BrickletPiezoSpeakerV2Alarm
    start_frequency::Integer
    end_frequency::Integer
    step_size::Integer
    step_delay::Integer
    volume::Integer
    duration::Integer
    duration_remaining::Integer
    current_frequency::Integer
end

export BrickletPiezoSpeakerV2SPITFPErrorCount
struct BrickletPiezoSpeakerV2SPITFPErrorCount
    error_count_ack_checksum::Integer
    error_count_message_checksum::Integer
    error_count_frame::Integer
    error_count_overflow::Integer
end

export BrickletPiezoSpeakerV2Identity
struct BrickletPiezoSpeakerV2Identity
    uid::String
    connected_uid::String
    position::Char
    hardware_version::Vector{Integer}
    firmware_version::Vector{Integer}
    device_identifier::Integer
end

export BrickletPiezoSpeakerV2
"""
Creates beep and alarm with configurable volume and frequency
"""
mutable struct BrickletPiezoSpeakerV2 <: TinkerforgeDevice
    ipcon::IPConnection
    deviceInternal::PyObject

    """
    Creates an object with the unique device ID *uid* and adds it to
    the IP Connection *ipcon*.
    """
    function BrickletPiezoSpeakerV2(uid::String, ipcon::IPConnection)
        package = pyimport("tinkerforge.bricklet_piezo_speaker_v2")
        deviceInternal = package.BrickletPiezoSpeakerV2(uid, ipcon.ipconInternal)

        return new(ipcon, deviceInternal)
    end
end

export set_beep
"""
    $(SIGNATURES)

Beeps with the given frequency and volume for the duration.

A duration of 0 stops the current beep if any is ongoing.
A duration of 4294967295 results in an infinite beep.
"""
function set_beep(device::BrickletPiezoSpeakerV2, frequency, volume, duration)
    device.deviceInternal.set_beep(frequency, volume, duration)
end

export get_beep
"""
    $(SIGNATURES)

Returns the last beep settings as set by :func:`Set Beep`. If a beep is currently
running it also returns the remaining duration of the beep.

If the frequency or volume is updated during a beep (with :func:`Update Frequency`
or :func:`Update Volume`) this function returns the updated value.
"""
function get_beep(device::BrickletPiezoSpeakerV2)
    return device.deviceInternal.get_beep()
end

export set_alarm
"""
    $(SIGNATURES)

Creates an alarm (a tone that goes back and force between two specified frequencies).

The following parameters can be set:

* Start Frequency: Start frequency of the alarm.
* End Frequency: End frequency of the alarm.
* Step Size: Size of one step of the sweep between the start/end frequencies.
* Step Delay: Delay between two steps (duration of time that one tone is used in a sweep).
* Duration: Duration of the alarm.

A duration of 0 stops the current alarm if any is ongoing.
A duration of 4294967295 results in an infinite alarm.

Below you can find two sets of example settings that you can try out. You can use
these as a starting point to find an alarm signal that suits your application.

Example 1: 10 seconds of loud annoying fast alarm

* Start Frequency = 800
* End Frequency = 2000
* Step Size = 10
* Step Delay = 1
* Volume = 10
* Duration = 10000

Example 2: 10 seconds of soft siren sound with slow build-up

* Start Frequency = 250
* End Frequency = 750
* Step Size = 1
* Step Delay = 5
* Volume = 0
* Duration = 10000

The following conditions must be met:

* Start Frequency: has to be smaller than end frequency
* End Frequency: has to be bigger than start frequency
* Step Size: has to be small enough to fit into the frequency range
* Step Delay: has to be small enough to fit into the duration
"""
function set_alarm(device::BrickletPiezoSpeakerV2, start_frequency, end_frequency, step_size, step_delay, volume, duration)
    device.deviceInternal.set_alarm(start_frequency, end_frequency, step_size, step_delay, volume, duration)
end

export get_alarm
"""
    $(SIGNATURES)

Returns the last alarm settings as set by :func:`Set Alarm`. If an alarm is currently
running it also returns the remaining duration of the alarm as well as the
current frequency of the alarm.

If the volume is updated during an alarm (with :func:`Update Volume`)
this function returns the updated value.
"""
function get_alarm(device::BrickletPiezoSpeakerV2)
    return device.deviceInternal.get_alarm()
end

export update_volume
"""
    $(SIGNATURES)

Updates the volume of an ongoing beep or alarm.
"""
function update_volume(device::BrickletPiezoSpeakerV2, volume)
    device.deviceInternal.update_volume(volume)
end

export update_frequency
"""
    $(SIGNATURES)

Updates the frequency of an ongoing beep.
"""
function update_frequency(device::BrickletPiezoSpeakerV2, frequency)
    device.deviceInternal.update_frequency(frequency)
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
function get_spitfp_error_count(device::BrickletPiezoSpeakerV2)
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
function set_bootloader_mode(device::BrickletPiezoSpeakerV2, mode)
    return device.deviceInternal.set_bootloader_mode(mode)
end

export get_bootloader_mode
"""
    $(SIGNATURES)

Returns the current bootloader mode, see :func:`Set Bootloader Mode`.
"""
function get_bootloader_mode(device::BrickletPiezoSpeakerV2)
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
function set_write_firmware_pointer(device::BrickletPiezoSpeakerV2, pointer)
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
function write_firmware(device::BrickletPiezoSpeakerV2, data)
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
function set_status_led_config(device::BrickletPiezoSpeakerV2, config)
    device.deviceInternal.set_status_led_config(config)
end

export get_status_led_config
"""
    $(SIGNATURES)

Returns the configuration as set by :func:`Set Status LED Config`
"""
function get_status_led_config(device::BrickletPiezoSpeakerV2)
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
function get_chip_temperature(device::BrickletPiezoSpeakerV2)
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
function reset(device::BrickletPiezoSpeakerV2)
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
function write_uid(device::BrickletPiezoSpeakerV2, uid)
    device.deviceInternal.write_uid(uid)
end

export read_uid
"""
    $(SIGNATURES)

Returns the current UID as an integer. Encode as
Base58 to get the usual string version.
"""
function read_uid(device::BrickletPiezoSpeakerV2)
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
function get_identity(device::BrickletPiezoSpeakerV2)
    return device.deviceInternal.get_identity()
end

export register_callback
"""
Registers the given *function* with the given *callback_id*.
"""
function register_callback(device::BrickletPiezoSpeakerV2, callback_id, function_)
    if isnothing(function_)
        device.registered_callbacks.pop(callback_id, None)
    else
        device.registered_callbacks[callback_id] = function_
    end
end
