


export BrickletIndustrialAnalogOutV2Configuration
struct BrickletIndustrialAnalogOutV2Configuration
    voltage_range::Integer
    current_range::Integer
end

export BrickletIndustrialAnalogOutV2OutLEDStatusConfig
struct BrickletIndustrialAnalogOutV2OutLEDStatusConfig
    min::Integer
    max::Integer
    config::Integer
end

export BrickletIndustrialAnalogOutV2SPITFPErrorCount
struct BrickletIndustrialAnalogOutV2SPITFPErrorCount
    error_count_ack_checksum::Integer
    error_count_message_checksum::Integer
    error_count_frame::Integer
    error_count_overflow::Integer
end

export BrickletIndustrialAnalogOutV2Identity
struct BrickletIndustrialAnalogOutV2Identity
    uid::String
    connected_uid::String
    position::Char
    hardware_version::Vector{Integer}
    firmware_version::Vector{Integer}
    device_identifier::Integer
end

export BrickletIndustrialAnalogOutV2
"""
Generates configurable DC voltage and current, 0V to 10V and 4mA to 20mA
"""
mutable struct BrickletIndustrialAnalogOutV2 <: TinkerforgeDevice
    ipcon::IPConnection
    deviceInternal::PyObject

    """
    Creates an object with the unique device ID *uid* and adds it to
    the IP Connection *ipcon*.
    """
    function BrickletIndustrialAnalogOutV2(uid::String, ipcon::IPConnection)
        package = pyimport("tinkerforge.bricklet_industrial_analog_out_v2")
        deviceInternal = package.BrickletIndustrialAnalogOutV2(uid, ipcon.ipconInternal)

        return new(ipcon, deviceInternal)
    end
end

export set_enabled
"""
    $(SIGNATURES)

Enables/disables the output of voltage and current.
"""
function set_enabled(device::BrickletIndustrialAnalogOutV2, enabled)
    device.deviceInternal.set_enabled(enabled)
end

export get_enabled
"""
    $(SIGNATURES)

Returns *true* if output of voltage and current is enabled, *false* otherwise.
"""
function get_enabled(device::BrickletIndustrialAnalogOutV2)
    return device.deviceInternal.get_enabled()
end

export set_voltage
"""
    $(SIGNATURES)

Sets the output voltage.

The output voltage and output current are linked. Changing the output voltage
also changes the output current.
"""
function set_voltage(device::BrickletIndustrialAnalogOutV2, voltage)
    device.deviceInternal.set_voltage(voltage)
end

export get_voltage
"""
    $(SIGNATURES)

Returns the voltage as set by :func:`Set Voltage`.
"""
function get_voltage(device::BrickletIndustrialAnalogOutV2)
    return device.deviceInternal.get_voltage()
end

export set_current
"""
    $(SIGNATURES)

Sets the output current.

The output current and output voltage are linked. Changing the output current
also changes the output voltage.
"""
function set_current(device::BrickletIndustrialAnalogOutV2, current)
    device.deviceInternal.set_current(current)
end

export get_current
"""
    $(SIGNATURES)

Returns the current as set by :func:`Set Current`.
"""
function get_current(device::BrickletIndustrialAnalogOutV2)
    return device.deviceInternal.get_current()
end

export set_configuration
"""
    $(SIGNATURES)

Configures the voltage and current range.

Possible voltage ranges are:

* 0V to 5V
* 0V to 10V

Possible current ranges are:

* 4mA to 20mA
* 0mA to 20mA
* 0mA to 24mA

The resolution will always be 12 bit. This means, that the
precision is higher with a smaller range.
"""
function set_configuration(device::BrickletIndustrialAnalogOutV2, voltage_range, current_range)
    device.deviceInternal.set_configuration(voltage_range, current_range)
end

export get_configuration
"""
    $(SIGNATURES)

Returns the configuration as set by :func:`Set Configuration`.
"""
function get_configuration(device::BrickletIndustrialAnalogOutV2)
    return device.deviceInternal.get_configuration()
end

export set_out_led_config
"""
    $(SIGNATURES)

You can turn the Out LED off, on or show a
heartbeat. You can also set the LED to "Out Status". In this mode the
LED can either be turned on with a pre-defined threshold or the intensity
of the LED can change with the output value (voltage or current).

You can configure the channel status behavior with :func:`Set Out LED Status Config`.
"""
function set_out_led_config(device::BrickletIndustrialAnalogOutV2, config)
    device.deviceInternal.set_out_led_config(config)
end

export get_out_led_config
"""
    $(SIGNATURES)

Returns the Out LED configuration as set by :func:`Set Out LED Config`
"""
function get_out_led_config(device::BrickletIndustrialAnalogOutV2)
    return device.deviceInternal.get_out_led_config()
end

export set_out_led_status_config
"""
    $(SIGNATURES)

Sets the Out LED status config. This config is used if the Out LED is
configured as "Out Status", see :func:`Set Out LED Config`.

For each channel you can choose between threshold and intensity mode.

In threshold mode you can define a positive or a negative threshold.
For a positive threshold set the "min" parameter to the threshold value in mV or
µA above which the LED should turn on and set the "max" parameter to 0. Example:
If you set a positive threshold of 5V, the LED will turn on as soon as the
output value exceeds 5V and turn off again if it goes below 5V.
For a negative threshold set the "max" parameter to the threshold value in mV or
µA below which the LED should turn on and set the "min" parameter to 0. Example:
If you set a negative threshold of 5V, the LED will turn on as soon as the
output value goes below 5V and the LED will turn off when the output value
exceeds 5V.

In intensity mode you can define a range mV or µA that is used to scale the brightness
of the LED. Example with min=2V, max=8V: The LED is off at 2V and below, on at
8V and above and the brightness is linearly scaled between the values 2V and 8V.
If the min value is greater than the max value, the LED brightness is scaled the
other way around.
"""
function set_out_led_status_config(device::BrickletIndustrialAnalogOutV2, min, max, config)
    device.deviceInternal.set_out_led_status_config(min, max, config)
end

export get_out_led_status_config
"""
    $(SIGNATURES)

Returns the Out LED status configuration as set by :func:`Set Out LED Status Config`.
"""
function get_out_led_status_config(device::BrickletIndustrialAnalogOutV2)
    return device.deviceInternal.get_out_led_status_config()
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
function get_spitfp_error_count(device::BrickletIndustrialAnalogOutV2)
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
function set_bootloader_mode(device::BrickletIndustrialAnalogOutV2, mode)
    return device.deviceInternal.set_bootloader_mode(mode)
end

export get_bootloader_mode
"""
    $(SIGNATURES)

Returns the current bootloader mode, see :func:`Set Bootloader Mode`.
"""
function get_bootloader_mode(device::BrickletIndustrialAnalogOutV2)
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
function set_write_firmware_pointer(device::BrickletIndustrialAnalogOutV2, pointer)
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
function write_firmware(device::BrickletIndustrialAnalogOutV2, data)
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
function set_status_led_config(device::BrickletIndustrialAnalogOutV2, config)
    device.deviceInternal.set_status_led_config(config)
end

export get_status_led_config
"""
    $(SIGNATURES)

Returns the configuration as set by :func:`Set Status LED Config`
"""
function get_status_led_config(device::BrickletIndustrialAnalogOutV2)
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
function get_chip_temperature(device::BrickletIndustrialAnalogOutV2)
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
function reset(device::BrickletIndustrialAnalogOutV2)
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
function write_uid(device::BrickletIndustrialAnalogOutV2, uid)
    device.deviceInternal.write_uid(uid)
end

export read_uid
"""
    $(SIGNATURES)

Returns the current UID as an integer. Encode as
Base58 to get the usual string version.
"""
function read_uid(device::BrickletIndustrialAnalogOutV2)
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
function get_identity(device::BrickletIndustrialAnalogOutV2)
    return device.deviceInternal.get_identity()
end
