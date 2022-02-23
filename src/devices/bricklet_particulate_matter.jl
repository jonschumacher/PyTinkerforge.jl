


export BrickletParticulateMatterPMConcentration
struct BrickletParticulateMatterPMConcentration
    pm10::Integer
    pm25::Integer
    pm100::Integer
end

export BrickletParticulateMatterPMCount
struct BrickletParticulateMatterPMCount
    greater03um::Integer
    greater05um::Integer
    greater10um::Integer
    greater25um::Integer
    greater50um::Integer
    greater100um::Integer
end

export BrickletParticulateMatterSensorInfo
struct BrickletParticulateMatterSensorInfo
    sensor_version::Integer
    last_error_code::Integer
    framing_error_count::Integer
    checksum_error_count::Integer
end

export BrickletParticulateMatterPMConcentrationCallbackConfiguration
struct BrickletParticulateMatterPMConcentrationCallbackConfiguration
    period::Integer
    value_has_to_change::Bool
end

export BrickletParticulateMatterPMCountCallbackConfiguration
struct BrickletParticulateMatterPMCountCallbackConfiguration
    period::Integer
    value_has_to_change::Bool
end

export BrickletParticulateMatterSPITFPErrorCount
struct BrickletParticulateMatterSPITFPErrorCount
    error_count_ack_checksum::Integer
    error_count_message_checksum::Integer
    error_count_frame::Integer
    error_count_overflow::Integer
end

export BrickletParticulateMatterIdentity
struct BrickletParticulateMatterIdentity
    uid::String
    connected_uid::String
    position::Char
    hardware_version::Vector{Integer}
    firmware_version::Vector{Integer}
    device_identifier::Integer
end

export BrickletParticulateMatter
"""
Measures Particulate Matter concentration (PM1.0, PM2.5 and PM10)
"""
mutable struct BrickletParticulateMatter <: TinkerforgeDevice
    ipcon::IPConnection
    deviceInternal::PyObject

    """
    Creates an object with the unique device ID *uid* and adds it to
    the IP Connection *ipcon*.
    """
    function BrickletParticulateMatter(uid::String, ipcon::IPConnection)
        package = pyimport("tinkerforge.bricklet_particulate_matter")
        deviceInternal = package.BrickletParticulateMatter(uid, ipcon.ipconInternal)

        return new(ipcon, deviceInternal)
    end
end

export get_pm_concentration
"""
    $(SIGNATURES)

Returns the particulate matter concentration, broken down as:

* PM\\ :sub:`1.0`\\ ,
* PM\\ :sub:`2.5`\\  and
* PM\\ :sub:`10.0`\\ .

If the sensor is disabled (see :func:`Set Enable`) then the last known good
values from the sensor are returned.

If you want to get the values periodically, it is recommended to use the
:cb:`PM Concentration` callback. You can set the callback configuration
with :func:`Set PM Concentration Callback Configuration`.
"""
function get_pm_concentration(device::BrickletParticulateMatter)
    return device.deviceInternal.get_pm_concentration()
end

export get_pm_count
"""
    $(SIGNATURES)

Returns the number of particulates in 100 ml of air, broken down by their
diameter:

* greater 0.3µm,
* greater 0.5µm,
* greater 1.0µm,
* greater 2.5µm,
* greater 5.0µm and
* greater 10.0µm.

If the sensor is disabled (see :func:`Set Enable`) then the last known good
value from the sensor is returned.

If you want to get the values periodically, it is recommended to use the
:cb:`PM Count` callback. You can set the callback configuration
with :func:`Set PM Count Callback Configuration`.
"""
function get_pm_count(device::BrickletParticulateMatter)
    return device.deviceInternal.get_pm_count()
end

export set_enable
"""
    $(SIGNATURES)

Enables/Disables the fan and the laser diode of the sensors.

The sensor takes about 30 seconds after it is enabled to settle and produce stable
values.

The laser diode has a lifetime of about 8000 hours. If you want to measure in
an interval with a long idle time (e.g. hourly) you should turn the
laser diode off between the measurements.
"""
function set_enable(device::BrickletParticulateMatter, enable)
    device.deviceInternal.set_enable(enable)
end

export get_enable
"""
    $(SIGNATURES)

Returns the state of the sensor as set by :func:`Set Enable`.
"""
function get_enable(device::BrickletParticulateMatter)
    return device.deviceInternal.get_enable()
end

export get_sensor_info
"""
    $(SIGNATURES)

Returns information about the sensor:

* the sensor version number,
* the last error code reported by the sensor (0 means no error) and
* the number of framing and checksum errors that occurred in the communication
  with the sensor.
"""
function get_sensor_info(device::BrickletParticulateMatter)
    return device.deviceInternal.get_sensor_info()
end

export set_pm_concentration_callback_configuration
"""
    $(SIGNATURES)

The period is the period with which the :cb:`PM Concentration`
callback is triggered periodically. A value of 0 turns the callback off.

If the `value has to change`-parameter is set to true, the callback is only
triggered after the value has changed. If the value didn't change within the
period, the callback is triggered immediately on change.

If it is set to false, the callback is continuously triggered with the period,
independent of the value.
"""
function set_pm_concentration_callback_configuration(device::BrickletParticulateMatter, period, value_has_to_change)
    device.deviceInternal.set_pm_concentration_callback_configuration(period, value_has_to_change)
end

export get_pm_concentration_callback_configuration
"""
    $(SIGNATURES)

Returns the callback configuration as set by
:func:`Set PM Concentration Callback Configuration`.
"""
function get_pm_concentration_callback_configuration(device::BrickletParticulateMatter)
    return device.deviceInternal.get_pm_concentration_callback_configuration()
end

export set_pm_count_callback_configuration
"""
    $(SIGNATURES)

The period is the period with which the :cb:`PM Count` callback
is triggered periodically. A value of 0 turns the callback off.

If the `value has to change`-parameter is set to true, the callback is only
triggered after the value has changed. If the value didn't change within the
period, the callback is triggered immediately on change.

If it is set to false, the callback is continuously triggered with the period,
independent of the value.
"""
function set_pm_count_callback_configuration(device::BrickletParticulateMatter, period, value_has_to_change)
    device.deviceInternal.set_pm_count_callback_configuration(period, value_has_to_change)
end

export get_pm_count_callback_configuration
"""
    $(SIGNATURES)

Returns the callback configuration as set by
:func:`Set PM Count Callback Configuration`.
"""
function get_pm_count_callback_configuration(device::BrickletParticulateMatter)
    return device.deviceInternal.get_pm_count_callback_configuration()
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
function get_spitfp_error_count(device::BrickletParticulateMatter)
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
function set_bootloader_mode(device::BrickletParticulateMatter, mode)
    return device.deviceInternal.set_bootloader_mode(mode)
end

export get_bootloader_mode
"""
    $(SIGNATURES)

Returns the current bootloader mode, see :func:`Set Bootloader Mode`.
"""
function get_bootloader_mode(device::BrickletParticulateMatter)
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
function set_write_firmware_pointer(device::BrickletParticulateMatter, pointer)
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
function write_firmware(device::BrickletParticulateMatter, data)
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
function set_status_led_config(device::BrickletParticulateMatter, config)
    device.deviceInternal.set_status_led_config(config)
end

export get_status_led_config
"""
    $(SIGNATURES)

Returns the configuration as set by :func:`Set Status LED Config`
"""
function get_status_led_config(device::BrickletParticulateMatter)
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
function get_chip_temperature(device::BrickletParticulateMatter)
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
function reset(device::BrickletParticulateMatter)
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
function write_uid(device::BrickletParticulateMatter, uid)
    device.deviceInternal.write_uid(uid)
end

export read_uid
"""
    $(SIGNATURES)

Returns the current UID as an integer. Encode as
Base58 to get the usual string version.
"""
function read_uid(device::BrickletParticulateMatter)
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
function get_identity(device::BrickletParticulateMatter)
    return device.deviceInternal.get_identity()
end

export register_callback
"""
Registers the given *function* with the given *callback_id*.
"""
function register_callback(device::BrickletParticulateMatter, callback_id, function_)
    if isnothing(function_)
        device.registered_callbacks.pop(callback_id, None)
    else
        device.registered_callbacks[callback_id] = function_
    end
end
