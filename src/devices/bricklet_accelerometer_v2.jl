


export BrickletAccelerometerV2Acceleration
struct BrickletAccelerometerV2Acceleration
    x::Integer
    y::Integer
    z::Integer
end

export BrickletAccelerometerV2Configuration
struct BrickletAccelerometerV2Configuration
    data_rate::Integer
    full_scale::Integer
end

export BrickletAccelerometerV2AccelerationCallbackConfiguration
struct BrickletAccelerometerV2AccelerationCallbackConfiguration
    period::Integer
    value_has_to_change::Bool
end

export BrickletAccelerometerV2ContinuousAccelerationConfiguration
struct BrickletAccelerometerV2ContinuousAccelerationConfiguration
    enable_x::Bool
    enable_y::Bool
    enable_z::Bool
    resolution::Integer
end

export BrickletAccelerometerV2FilterConfiguration
struct BrickletAccelerometerV2FilterConfiguration
    iir_bypass::Integer
    low_pass_filter::Integer
end

export BrickletAccelerometerV2SPITFPErrorCount
struct BrickletAccelerometerV2SPITFPErrorCount
    error_count_ack_checksum::Integer
    error_count_message_checksum::Integer
    error_count_frame::Integer
    error_count_overflow::Integer
end

export BrickletAccelerometerV2Identity
struct BrickletAccelerometerV2Identity
    uid::String
    connected_uid::String
    position::Char
    hardware_version::Vector{Integer}
    firmware_version::Vector{Integer}
    device_identifier::Integer
end

export BrickletAccelerometerV2
"""
Measures acceleration in three axis
"""
mutable struct BrickletAccelerometerV2 <: TinkerforgeDevice
    ipcon::IPConnection
    deviceInternal::PyObject

    """
    Creates an object with the unique device ID *uid* and adds it to
    the IP Connection *ipcon*.
    """
    function BrickletAccelerometerV2(uid::String, ipcon::IPConnection)
        package = pyimport("tinkerforge.bricklet_accelerometer_v2")
        deviceInternal = package.BrickletAccelerometerV2(uid, ipcon.ipconInternal)

        return new(ipcon, deviceInternal)
    end
end

export get_acceleration
"""
    $(SIGNATURES)

Returns the acceleration in x, y and z direction. The values
are given in gₙ/10000 (1gₙ = 9.80665m/s²). The range is
configured with :func:`Set Configuration`.

If you want to get the acceleration periodically, it is recommended
to use the :cb:`Acceleration` callback and set the period with
:func:`Set Acceleration Callback Configuration`.
"""
function get_acceleration(device::BrickletAccelerometerV2)
    return device.deviceInternal.get_acceleration()
end

export set_configuration
"""
    $(SIGNATURES)

Configures the data rate and full scale range.
Possible values are:

* Data rate of 0.781Hz to 25600Hz.
* Full scale range of ±2g up to ±8g.

Decreasing data rate or full scale range will also decrease the noise on
the data.
"""
function set_configuration(device::BrickletAccelerometerV2, data_rate, full_scale)
    device.deviceInternal.set_configuration(data_rate, full_scale)
end

export get_configuration
"""
    $(SIGNATURES)

Returns the configuration as set by :func:`Set Configuration`.
"""
function get_configuration(device::BrickletAccelerometerV2)
    return device.deviceInternal.get_configuration()
end

export set_acceleration_callback_configuration
"""
    $(SIGNATURES)

The period is the period with which the :cb:`Acceleration`
callback is triggered periodically. A value of 0 turns the callback off.

If the `value has to change`-parameter is set to true, the callback is only
triggered after the value has changed. If the value didn't change within the
period, the callback is triggered immediately on change.

If it is set to false, the callback is continuously triggered with the period,
independent of the value.

If this callback is enabled, the :cb:`Continuous Acceleration 16 Bit` callback
and :cb:`Continuous Acceleration 8 Bit` callback will automatically be disabled.
"""
function set_acceleration_callback_configuration(device::BrickletAccelerometerV2, period, value_has_to_change)
    device.deviceInternal.set_acceleration_callback_configuration(period, value_has_to_change)
end

export get_acceleration_callback_configuration
"""
    $(SIGNATURES)

Returns the callback configuration as set by
:func:`Set Acceleration Callback Configuration`.
"""
function get_acceleration_callback_configuration(device::BrickletAccelerometerV2)
    return device.deviceInternal.get_acceleration_callback_configuration()
end

export set_info_led_config
"""
    $(SIGNATURES)

Configures the info LED (marked as "Force" on the Bricklet) to be either turned off,
turned on, or blink in heartbeat mode.
"""
function set_info_led_config(device::BrickletAccelerometerV2, config)
    device.deviceInternal.set_info_led_config(config)
end

export get_info_led_config
"""
    $(SIGNATURES)

Returns the LED configuration as set by :func:`Set Info LED Config`
"""
function get_info_led_config(device::BrickletAccelerometerV2)
    return device.deviceInternal.get_info_led_config()
end

export set_continuous_acceleration_configuration
"""
    $(SIGNATURES)

For high throughput of acceleration data (> 1000Hz) you have to use the
:cb:`Continuous Acceleration 16 Bit` or :cb:`Continuous Acceleration 8 Bit`
callbacks.

You can enable the callback for each axis (x, y, z) individually and choose a
resolution of 8 bit or 16 bit.

If at least one of the axis is enabled and the resolution is set to 8 bit,
the :cb:`Continuous Acceleration 8 Bit` callback is activated. If at least
one of the axis is enabled and the resolution is set to 16 bit,
the :cb:`Continuous Acceleration 16 Bit` callback is activated.

The returned values are raw ADC data. If you want to put this data into
a FFT to determine the occurrences of specific frequencies we recommend
that you use the data as is. It has all of the ADC noise in it. This noise
looks like pure noise at first glance, but it might still have some frequnecy
information in it that can be utilized by the FFT.

Otherwise you have to use the following formulas that depend on the configured
resolution (8/16 bit) and the full scale range (see :func:`Set Configuration`) to calculate
the data in gₙ/10000 (same unit that is returned by :func:`Get Acceleration`):

* 16 bit, full scale 2g: acceleration = value * 625 / 1024
* 16 bit, full scale 4g: acceleration = value * 1250 / 1024
* 16 bit, full scale 8g: acceleration = value * 2500 / 1024

If a resolution of 8 bit is used, only the 8 most significant bits will be
transferred, so you can use the following formulas:

* 8 bit, full scale 2g: acceleration = value * 256 * 625 / 1024
* 8 bit, full scale 4g: acceleration = value * 256 * 1250 / 1024
* 8 bit, full scale 8g: acceleration = value * 256 * 2500 / 1024

If no axis is enabled, both callbacks are disabled. If one of the continuous
callbacks is enabled, the :cb:`Acceleration` callback is disabled.

The maximum throughput depends on the exact configuration:

.. csv-table::
 :header: "Number of axis enabled", "Throughput 8 bit", "Throughout 16 bit"
 :widths: 20, 20, 20

 "1", "25600Hz", "25600Hz"
 "2", "25600Hz", "15000Hz"
 "3", "20000Hz", "10000Hz"
"""
function set_continuous_acceleration_configuration(device::BrickletAccelerometerV2, enable_x, enable_y, enable_z, resolution)
    device.deviceInternal.set_continuous_acceleration_configuration(enable_x, enable_y, enable_z, resolution)
end

export get_continuous_acceleration_configuration
"""
    $(SIGNATURES)

Returns the continuous acceleration configuration as set by
:func:`Set Continuous Acceleration Configuration`.
"""
function get_continuous_acceleration_configuration(device::BrickletAccelerometerV2)
    return device.deviceInternal.get_continuous_acceleration_configuration()
end

export set_filter_configuration
"""
    $(SIGNATURES)

Configures IIR Bypass filter mode and low pass filter roll off corner frequency.

The filter can be applied or bypassed and the corner frequency can be
half or a ninth of the output data rate.

.. image:: /Images/Bricklets/bricklet_accelerometer_v2_filter.png
   :scale: 100 %
   :alt: Accelerometer filter
   :align: center
   :target: ../../_images/Bricklets/bricklet_accelerometer_v2_filter.png

.. versionadded:: 2.0.2\$nbsp;(Plugin)
"""
function set_filter_configuration(device::BrickletAccelerometerV2, iir_bypass, low_pass_filter)
    device.deviceInternal.set_filter_configuration(iir_bypass, low_pass_filter)
end

export get_filter_configuration
"""
    $(SIGNATURES)

Returns the configuration as set by :func:`Set Filter Configuration`.

.. versionadded:: 2.0.2\$nbsp;(Plugin)
"""
function get_filter_configuration(device::BrickletAccelerometerV2)
    return device.deviceInternal.get_filter_configuration()
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
function get_spitfp_error_count(device::BrickletAccelerometerV2)
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
function set_bootloader_mode(device::BrickletAccelerometerV2, mode)
    return device.deviceInternal.set_bootloader_mode(mode)
end

export get_bootloader_mode
"""
    $(SIGNATURES)

Returns the current bootloader mode, see :func:`Set Bootloader Mode`.
"""
function get_bootloader_mode(device::BrickletAccelerometerV2)
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
function set_write_firmware_pointer(device::BrickletAccelerometerV2, pointer)
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
function write_firmware(device::BrickletAccelerometerV2, data)
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
function set_status_led_config(device::BrickletAccelerometerV2, config)
    device.deviceInternal.set_status_led_config(config)
end

export get_status_led_config
"""
    $(SIGNATURES)

Returns the configuration as set by :func:`Set Status LED Config`
"""
function get_status_led_config(device::BrickletAccelerometerV2)
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
function get_chip_temperature(device::BrickletAccelerometerV2)
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
function reset(device::BrickletAccelerometerV2)
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
function write_uid(device::BrickletAccelerometerV2, uid)
    device.deviceInternal.write_uid(uid)
end

export read_uid
"""
    $(SIGNATURES)

Returns the current UID as an integer. Encode as
Base58 to get the usual string version.
"""
function read_uid(device::BrickletAccelerometerV2)
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
function get_identity(device::BrickletAccelerometerV2)
    return device.deviceInternal.get_identity()
end

export register_callback
"""
Registers the given *function* with the given *callback_id*.
"""
function register_callback(device::BrickletAccelerometerV2, callback_id, function_)
    if isnothing(function_)
        device.registered_callbacks.pop(callback_id, None)
    else
        device.registered_callbacks[callback_id] = function_
    end
end
