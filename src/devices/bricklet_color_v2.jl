


export BrickletColorV2Color
struct BrickletColorV2Color
    r::Integer
    g::Integer
    b::Integer
    c::Integer
end

export BrickletColorV2ColorCallbackConfiguration
struct BrickletColorV2ColorCallbackConfiguration
    period::Integer
    value_has_to_change::Bool
end

export BrickletColorV2IlluminanceCallbackConfiguration
struct BrickletColorV2IlluminanceCallbackConfiguration
    period::Integer
    value_has_to_change::Bool
    option::Char
    min::Integer
    max::Integer
end

export BrickletColorV2ColorTemperatureCallbackConfiguration
struct BrickletColorV2ColorTemperatureCallbackConfiguration
    period::Integer
    value_has_to_change::Bool
    option::Char
    min::Integer
    max::Integer
end

export BrickletColorV2Configuration
struct BrickletColorV2Configuration
    gain::Integer
    integration_time::Integer
end

export BrickletColorV2SPITFPErrorCount
struct BrickletColorV2SPITFPErrorCount
    error_count_ack_checksum::Integer
    error_count_message_checksum::Integer
    error_count_frame::Integer
    error_count_overflow::Integer
end

export BrickletColorV2Identity
struct BrickletColorV2Identity
    uid::String
    connected_uid::String
    position::Char
    hardware_version::Vector{Integer}
    firmware_version::Vector{Integer}
    device_identifier::Integer
end

export BrickletColorV2
"""
Measures color (RGB value), illuminance and color temperature
"""
mutable struct BrickletColorV2 <: TinkerforgeDevice
    ipcon::IPConnection
    deviceInternal::PyObject

    """
    Creates an object with the unique device ID *uid* and adds it to
    the IP Connection *ipcon*.
    """
    function BrickletColorV2(uid::String, ipcon::IPConnection)
        package = pyimport("tinkerforge.bricklet_color_v2")
        deviceInternal = package.BrickletColorV2(uid, ipcon.ipconInternal)

        return new(ipcon, deviceInternal)
    end
end

export get_color
"""
    $(SIGNATURES)

Returns the measured color of the sensor.

The red (r), green (g), blue (b) and clear (c) colors are measured
with four different photodiodes that are responsive at different
wavelengths:

.. image:: /Images/Bricklets/bricklet_color_wavelength_chart_600.jpg
   :scale: 100 %
   :alt: Chart Responsivity / Wavelength
   :align: center
   :target: ../../_images/Bricklets/bricklet_color_wavelength_chart_600.jpg

If you want to get the color periodically, it is recommended
to use the :cb:`Color` callback and set the period with
:func:`Set Color Callback Configuration`.
"""
function get_color(device::BrickletColorV2)
    return device.deviceInternal.get_color()
end

export set_color_callback_configuration
"""
    $(SIGNATURES)

The period is the period with which the :cb:`Color`
callback is triggered periodically. A value of 0 turns the callback off.

If the `value has to change`-parameter is set to true, the callback is only
triggered after the value has changed. If the value didn't change within the
period, the callback is triggered immediately on change.

If it is set to false, the callback is continuously triggered with the period,
independent of the value.
"""
function set_color_callback_configuration(device::BrickletColorV2, period, value_has_to_change)
    device.deviceInternal.set_color_callback_configuration(period, value_has_to_change)
end

export get_color_callback_configuration
"""
    $(SIGNATURES)

Returns the callback configuration as set by
:func:`Set Color Callback Configuration`.
"""
function get_color_callback_configuration(device::BrickletColorV2)
    return device.deviceInternal.get_color_callback_configuration()
end

export get_illuminance
"""
    $(SIGNATURES)

Returns the illuminance affected by the gain and integration time as
set by :func:`Set Configuration`. To get the illuminance in Lux apply this formula::

 lux = illuminance * 700 / gain / integration_time

To get a correct illuminance measurement make sure that the color
values themselves are not saturated. The color value (R, G or B)
is saturated if it is equal to the maximum value of 65535.
In that case you have to reduce the gain, see :func:`Set Configuration`.


If you want to get the value periodically, it is recommended to use the
:cb:`Illuminance` callback. You can set the callback configuration
with :func:`Set Illuminance Callback Configuration`.
"""
function get_illuminance(device::BrickletColorV2)
    return device.deviceInternal.get_illuminance()
end

export set_illuminance_callback_configuration
"""
    $(SIGNATURES)

The period is the period with which the :cb:`Illuminance` callback is triggered
periodically. A value of 0 turns the callback off.

If the `value has to change`-parameter is set to true, the callback is only
triggered after the value has changed. If the value didn't change
within the period, the callback is triggered immediately on change.

If it is set to false, the callback is continuously triggered with the period,
independent of the value.

It is furthermore possible to constrain the callback with thresholds.

The `option`-parameter together with min/max sets a threshold for the :cb:`Illuminance` callback.

The following options are possible:

.. csv-table::
 :header: "Option", "Description"
 :widths: 10, 100

 "'x'",    "Threshold is turned off"
 "'o'",    "Threshold is triggered when the value is *outside* the min and max values"
 "'i'",    "Threshold is triggered when the value is *inside* or equal to the min and max values"
 "'<'",    "Threshold is triggered when the value is smaller than the min value (max is ignored)"
 "'>'",    "Threshold is triggered when the value is greater than the min value (max is ignored)"

If the option is set to 'x' (threshold turned off) the callback is triggered with the fixed period.
"""
function set_illuminance_callback_configuration(device::BrickletColorV2, period, value_has_to_change, option, min, max)
    device.deviceInternal.set_illuminance_callback_configuration(period, value_has_to_change, option, min, max)
end

export get_illuminance_callback_configuration
"""
    $(SIGNATURES)

Returns the callback configuration as set by :func:`Set Illuminance Callback Configuration`.
"""
function get_illuminance_callback_configuration(device::BrickletColorV2)
    return device.deviceInternal.get_illuminance_callback_configuration()
end

export get_color_temperature
"""
    $(SIGNATURES)

Returns the color temperature.

To get a correct color temperature measurement make sure that the color
values themselves are not saturated. The color value (R, G or B)
is saturated if it is equal to the maximum value of 65535.
In that case you have to reduce the gain, see :func:`Set Configuration`.


If you want to get the value periodically, it is recommended to use the
:cb:`Color Temperature` callback. You can set the callback configuration
with :func:`Set Color Temperature Callback Configuration`.
"""
function get_color_temperature(device::BrickletColorV2)
    return device.deviceInternal.get_color_temperature()
end

export set_color_temperature_callback_configuration
"""
    $(SIGNATURES)

The period is the period with which the :cb:`Color Temperature` callback is triggered
periodically. A value of 0 turns the callback off.

If the `value has to change`-parameter is set to true, the callback is only
triggered after the value has changed. If the value didn't change
within the period, the callback is triggered immediately on change.

If it is set to false, the callback is continuously triggered with the period,
independent of the value.

It is furthermore possible to constrain the callback with thresholds.

The `option`-parameter together with min/max sets a threshold for the :cb:`Color Temperature` callback.

The following options are possible:

.. csv-table::
 :header: "Option", "Description"
 :widths: 10, 100

 "'x'",    "Threshold is turned off"
 "'o'",    "Threshold is triggered when the value is *outside* the min and max values"
 "'i'",    "Threshold is triggered when the value is *inside* or equal to the min and max values"
 "'<'",    "Threshold is triggered when the value is smaller than the min value (max is ignored)"
 "'>'",    "Threshold is triggered when the value is greater than the min value (max is ignored)"

If the option is set to 'x' (threshold turned off) the callback is triggered with the fixed period.
"""
function set_color_temperature_callback_configuration(device::BrickletColorV2, period, value_has_to_change, option, min, max)
    device.deviceInternal.set_color_temperature_callback_configuration(period, value_has_to_change, option, min, max)
end

export get_color_temperature_callback_configuration
"""
    $(SIGNATURES)

Returns the callback configuration as set by :func:`Set Color Temperature Callback Configuration`.
"""
function get_color_temperature_callback_configuration(device::BrickletColorV2)
    return device.deviceInternal.get_color_temperature_callback_configuration()
end

export set_light
"""
    $(SIGNATURES)

Turns the white LED on the Bricklet on/off.
"""
function set_light(device::BrickletColorV2, enable)
    device.deviceInternal.set_light(enable)
end

export get_light
"""
    $(SIGNATURES)

Returns the value as set by :func:`Set Light`.
"""
function get_light(device::BrickletColorV2)
    return device.deviceInternal.get_light()
end

export set_configuration
"""
    $(SIGNATURES)

Sets the configuration of the sensor. Gain and integration time
can be configured this way.

For configuring the gain:

* 0: 1x Gain
* 1: 4x Gain
* 2: 16x Gain
* 3: 60x Gain

For configuring the integration time:

* 0: 2.4ms
* 1: 24ms
* 2: 101ms
* 3: 154ms
* 4: 700ms

Increasing the gain enables the sensor to detect a
color from a higher distance.

The integration time provides a trade-off between conversion time
and accuracy. With a longer integration time the values read will
be more accurate but it will take longer to get the conversion
results.
"""
function set_configuration(device::BrickletColorV2, gain, integration_time)
    device.deviceInternal.set_configuration(gain, integration_time)
end

export get_configuration
"""
    $(SIGNATURES)

Returns the configuration as set by :func:`Set Configuration`.
"""
function get_configuration(device::BrickletColorV2)
    return device.deviceInternal.get_configuration()
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
function get_spitfp_error_count(device::BrickletColorV2)
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
function set_bootloader_mode(device::BrickletColorV2, mode)
    return device.deviceInternal.set_bootloader_mode(mode)
end

export get_bootloader_mode
"""
    $(SIGNATURES)

Returns the current bootloader mode, see :func:`Set Bootloader Mode`.
"""
function get_bootloader_mode(device::BrickletColorV2)
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
function set_write_firmware_pointer(device::BrickletColorV2, pointer)
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
function write_firmware(device::BrickletColorV2, data)
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
function set_status_led_config(device::BrickletColorV2, config)
    device.deviceInternal.set_status_led_config(config)
end

export get_status_led_config
"""
    $(SIGNATURES)

Returns the configuration as set by :func:`Set Status LED Config`
"""
function get_status_led_config(device::BrickletColorV2)
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
function get_chip_temperature(device::BrickletColorV2)
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
function reset(device::BrickletColorV2)
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
function write_uid(device::BrickletColorV2, uid)
    device.deviceInternal.write_uid(uid)
end

export read_uid
"""
    $(SIGNATURES)

Returns the current UID as an integer. Encode as
Base58 to get the usual string version.
"""
function read_uid(device::BrickletColorV2)
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
function get_identity(device::BrickletColorV2)
    return device.deviceInternal.get_identity()
end

export register_callback
"""
Registers the given *function* with the given *callback_id*.
"""
function register_callback(device::BrickletColorV2, callback_id, function_)
    if isnothing(function_)
        device.registered_callbacks.pop(callback_id, None)
    else
        device.registered_callbacks[callback_id] = function_
    end
end
